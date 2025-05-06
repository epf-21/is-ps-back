const Router = require("express");
const { CarController } = require("../controllers/cars");

const carRouter = Router()

carRouter.get('/', CarController.getAll)
carRouter.get('/most-rented', CarController.getMostRented)
carRouter.post('/available-map', CarController.getCarsAvailableMap)
carRouter.get('/available', CarController.getCarsAvailable)
module.exports = { carRouter }