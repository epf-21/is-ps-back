const { CarModel } = require("../models/cars");

class CarController {
  static async getAll(req, res) {
    try {
      const cars = await CarModel.getAll()
      res.status(200).json(cars)
    } catch (error) {
      res.status(500).json({ error: 'Error al obtener autos' })
    }
  }

  static async getMostRented(req, res) {
    try {
      const cars = await CarModel.getMostRented()
      res.status(200).json(cars)
    } catch (error) {
      res.status(500).json({ error: 'Error al obtener autos más alquilados' })
    }
  }

  static async getCarsAvailableMap(req, res) {
    try {
      const { ids } = req.body
      if (!Array.isArray(ids) || ids.length === 0) {
        return res.status(400).json({ error: 'Debe proporcionar una lista de IDs de carros' });
      }
      const cars = await CarModel.getCarsAvailableMap({ ids })
      res.status(200).json(cars)
    } catch (error) {
      if (error instanceof Error) {
        res.status(400).json({ error: error.message })
      } else {
        res.status(500).json({ error: 'Error al obtener autos disponibles en el mapa' })
      }
    }
  }

  static async getCarsAvailable(req, res) {
    try {
      const { startDate, endDate } = req.query
      if (!startDate || !endDate) {
        return res.status(400).json({ error: 'Debe proporcionar las fechas de inicio y fin' });
      }
      const cars = await CarModel.getCarsAvailable({ startDate, endDate });
      res.status(200).json(cars)
    } catch (error) {
      if (error instanceof Error) {
        res.status(400).json({ error: error.message })
      } else {
        res.status(500).json({ error: 'Error en el servidor' })
      }
    }
  }
}

module.exports = { CarController }