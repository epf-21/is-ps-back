const { prisma } = require("../config/prisma");

class AirportModel {
  static async getAll() {
    try {
      const airports = await prisma.aeropuerto.findMany()

      return airports.map(airport => ({
        nombre: airport.nombre,
        latitud: airport.latitud,
        longitud: airport.longitud,
        id_ciudad: airport.id_ciudad
      }))
    } catch (error) {
      console.error('Error al obtener aeropuertos: ', error)
      throw new Error('Error al obtener aeropuertos')
    }
  }
}

module.exports = { AirportModel }

