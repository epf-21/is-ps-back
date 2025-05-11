const { Router } = require('express');
const carService = require('./detailCar.service');

const router = Router();

router.get('/:id', async (req, res) => {
  const carId = parseInt(req.params.id);
  console.log('Id recibido', carId);
  try {
    const car = await carService.findById(carId);
    if (!car) {
      console.log('carro no encontrado')
      return res.status(404).json({ message: "Auto no disponible" });
    }

    res.json(car);
    console.log(car);
  } catch (err) {
    res.status(500).json({ message: "Error al obtener el carro" });
    console.error('Error en el controlador: ', err);
  }
});

module.exports = router;
