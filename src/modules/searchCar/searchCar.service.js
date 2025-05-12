const { prisma } = require('../../config/prisma')

const findAll = async () => {
  try {
    return await prisma.carro.findMany({
      select: {
        id: true,
        modelo: true,
        marca: true,
        asientos: true,
        puertas: true,
        transmicion: true,
        precio_por_dia: true,
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
        disponible_desde: true,
        disponible_hasta: true,
      }
    });
  } catch (error) {
    console.error('Error al obtener los carros:', error);
  }
};

module.exports = { findAll };