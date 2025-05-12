const { prisma } = require('../../config/prisma')

const carService = {
  async findById(id) {
    try {
      console.log('Id recibido desde constroller', id);
      const car = await prisma.carro.findUnique({
        where: { id },
        select: {
          marca: true,
          modelo: true,
          placa: true,
          año: true,
          asientos: true,
          puertas: true,
          soat: true,
          precio_por_dia: true,
          descripcion: true,
          transmicion: true,
          direccion: {
            select: {
              calle: true,
              zona: true,
              num_casa: true,
              provincia: {
                select: {
                  nombre: true,
                  ciudad: {
                    select: {
                      nombre: true,
                    }
                  }
                }
              }
            }
          },
          usuario: {
            select: {
              nombre: true,
            }
          },
          combustiblesporCarro: {
            select: {
              combustible: {
                select: {
                  tipoDeCombustible: true,
                }
              }
            }
          },
          imagenes: {
            select: {
              id: true,
              data: true,
              id_carro: true,
            }
          },
          caracteristicasAdicionalesCarro: {
            select: {
              carasteristicasAdicionales: {
                select: {
                  nombre: true,
                }
              }
            }
          }
        },
      });
      return {
        marca: car.marca,
        modelo: car.modelo,
        placa: car.placa,
        anio: car.año,
        asientos: car.asientos,
        puertas: car.puertas,
        soat: car.soat,
        precio_por_dia: car.precio_por_dia,
        descripcion: car.descripcion,
        transmicion: car.transmicion,
        direccion: car.direccion,
        usuario: car.usuario,
        combustiblesporCarro: car.combustiblesporCarro,
        imagenes: car.imagenes,
        caracteristicasAdicionalesCarro: car.caracteristicasAdicionalesCarro,
      }
    } catch (error) {
      console.log(error);
    }
  }
}

module.exports = carService;