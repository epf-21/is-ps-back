const { prisma } = require("../config/prisma");

class CarModel {
  static async getAll() {
    try {
      const cars = await prisma.carro.findMany({
        include: {
          imagenes: true,
          reservas: {
            where: {
              estado: "confirmado",
            }
          },
        }
      })

      return cars.map(car => ({
        marca: car.marca,
        modelo: car.modelo,
        anio: car.año,
        precio_por_dia: car.precio_por_dia,
        imagenes: car.imagenes?.[0]?.data ? Buffer.from(car.imagenes[0].data).toString('utf-8') : null,
        veces_alquilado: car.reservas.length,
      }))
    } catch (error) {
      console.error('Error al obtener autos: ', error)
      throw new Error('Error al obtener autos')
    }
  }

  static async getMostRented() {
    try {
      const cars = await prisma.carro.findMany({
        where: {
          reservas: {
            some: {
              estado: "confirmado",
            }
          }
        },
        include: {
          imagenes: true,
          _count: {
            select: {
              reservas: {
                where: {
                  estado: "confirmado",
                }
              }
            }
          }
        },
        orderBy: {
          reservas: {
            _count: 'desc'
          }
        },
        take: 15
      })

      return cars.map(car => ({
        marca: car.marca,
        modelo: car.modelo,
        anio: car.año,
        precio_por_dia: car.precio_por_dia,
        imagenes: car.imagenes && car.imagenes.length > 0 ? car.imagenes[0].data : '',
        veces_alquilado: car._count.reservas,
      }))
    } catch (error) {
      console.error('Error al obtener los autos más alquilados: ', error);
      throw new Error('Error al obtener los autos más alquilados');
    }
  }

  static async getCarsAvailableMap({ ids }) {
    try {
      const cars = await prisma.carro.findMany({
        where: {
          id: { in: ids },
          estado: "Disponible"
        },
        select: {
          id: true,
          marca: true,
          modelo: true,
          año: true,
          precio_por_dia: true,
          direccion: {
            select: {
              latitud: true,
              longitud: true,
            }
          }
        }
      })
      return cars
        .filter(car => car.direccion?.latitud !== null && car.direccion?.longitud !== null)
        .map(car => ({
          id: car.id,
          marca: car.marca,
          modelo: car.modelo,
          anio: car.año,
          precio: car.precio_por_dia,
          latitud: car.direccion.latitud,
          longitud: car.direccion.longitud
        }))
    } catch (error) {
      console.error('Error al obtener autos disponibles: ', error)
      throw new Error('Error al obtener autos disponibles')
    }
  }

  static async getCarsAvailable({ startDate, endDate }) {
    try {
      const carsAvailable = await prisma.carro.findMany({
        where: {
          disponible_desde: { lte: new Date(startDate) },
          disponible_hasta: { gte: new Date(endDate) },
          estado: "Disponible",
          reservas: {
            none: {
              AND: [
                {
                  fecha_inicio: { lte: new Date(endDate) },
                  fecha_fin: { gte: new Date(startDate) }
                }, {
                  estado: {
                    in: ["pendiente", "confirmado"]
                  }
                }
              ]
            }
          }
        },

        select: {
          id: true,
          marca: true,
          modelo: true,
          año: true,
          precio_por_dia: true,
          direccion: {
            select: {
              latitud: true,
              longitud: true,
            }
          }
        }
      })
      return carsAvailable
        .filter(car => car.direccion?.latitud !== null && car.direccion?.longitud !== null)
        .map(car => ({
          id: car.id,
          marca: car.marca,
          modelo: car.modelo,
          anio: car.año,
          precio: car.precio_por_dia,
          latitud: car.direccion.latitud,
          longitud: car.direccion.longitud
        }))
    } catch (error) {
      console.error('Error al obtener autos disponibles: ', error)
      throw new Error('Error al obtener autos disponibles')
    }
  }
}

module.exports = { CarModel }

