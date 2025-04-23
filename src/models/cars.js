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
        imagenes: car.imagenes?.[0]?.data ? Buffer.from(car.imagenes[0].data).toString('utf-8') : null,
        veces_alquilado: car._count.reservas,
      }))
    } catch (error) {
      console.error('Error al obtener los autos más alquilados: ', error);
      throw new Error('Error al obtener los autos más alquilados');
    }
  }
}

module.exports = { CarModel }

