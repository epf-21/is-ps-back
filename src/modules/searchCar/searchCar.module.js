const traerControlarAuto = require('./searchCar.controller');
const traerServicioAuto = require('./searchCar.service');

module.exports = {
  controller: traerControlarAuto,
  service: traerServicioAuto,
}