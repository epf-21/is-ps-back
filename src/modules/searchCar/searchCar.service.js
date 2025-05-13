const { prisma } = require('../../config/prisma')

const findAll = async () => {
  try {
    return await prisma.carro.findMany({
      select: {
        id: true,
        modelo: true,
        marca: true,
        año: true,
        asientos: true,
        puertas: true,
        transmicion: true,
        precio_por_dia: true,
        latitud: true,
        longitud: true,
        combustiblesporCarro: {
          select: {
            combustible: {
              select: {
                tipoDeCombustible: true,
              }
            }
          }
        },
        estado: true,
        usuario: {
          select: {
            nombre: true,
          }
        },
        direccion: {
          select: {
            calle: true,
            provincia: {
              select: {
                ciudad: {
                  select: {
                    nombre: true,
                  }
                }
              }
            }
          }
        },
        imagenes: {
          select: {
            data: true,
          }
        },
        reservas: {
          select: {
            fecha_inicio: true,
            fecha_fin: true,
            estado: true,
          }
        }
      }
    });
  } catch (error) {
    console.error('Error al obtener los carros:', error);
  }
};

module.exports = { findAll };