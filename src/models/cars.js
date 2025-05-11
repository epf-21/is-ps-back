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
        id: car.id,
        marca: car.marca,
        modelo: car.modelo,
        anio: car.año,
        precio_por_dia: car.precio_por_dia,
        imagenes: car.imagenes?.[0]?.data ? Buffer.from(car.imagenes[0].data).toString('utf-8') : null,
        veces_alquilado: car.reservas.length,
        latitud: car.latitud,
        longitud: car.longitud,
        puertas: car.puertas,
        asientos: car.asientos,
        calificacion: car.calificacion,
        transmision: car.transmicion
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
          latitud: true,
          longitud: true,
          imagenes: {
            select: {
              data: true,
            }
          }
        }
      })
      return carsAvailable
        .filter(car => car.latitud !== null && car.longitud !== null)
        .map(car => ({
          id: car.id,
          marca: car.marca,
          modelo: car.modelo,
          image: car.imagenes?.[0]?.data || "",
          anio: car.año,
          precio: car.precio_por_dia,
          latitud: car.latitud,
          longitud: car.longitud,
        }))
    } catch (error) {
      console.error('Error al obtener autos disponibles: ', error)
      throw new Error('Error al obtener autos disponibles')
    }
  }

  static async createCar({ anio, marca, modelo, precio, disponible_desde, disponible_hasta, latitud, longitud }) {
    try {
      const newCars = await prisma.carro.create({
        data: {
          vim: "zxcv",
          año: anio,
          marca: marca,
          modelo: modelo,
          placa: "wert",
          id_direccion: 1,
          asientos: 8,
          puertas: 6,
          soat: true,
          precio_por_dia: precio,
          num_mantenimientos: 123,
          transmicion: "dfdg",
          estado: "Disponible",
          id_usuario_rol: 1,
          disponible_desde: disponible_desde,
          disponible_hasta: disponible_hasta,
          latitud: latitud,
          longitud: longitud
        }
      })
      return newCars
    } catch (error) {
      console.error('Error al crear un carro: ', error)
      throw new Error('Error al crear coches')
    }
  }

  static async updatePriceCar({ id, price }) {
    try {
      const updatePrice = await prisma.carro.update({
        where: { id: id },
        data: {
          precio_por_dia: price
        }
      })

      return updatePrice;
    } catch (error) {
      console.error('Error al obtener autos:', error);
      throw new Error('Error al actualizar el precio');
    }
  }
}

module.exports = { CarModel }

