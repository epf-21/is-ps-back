const express = require('express');
const buscarServicio = require('./searchCar.service');

const buscarAuto = express.Router();

buscarAuto.get('/autos', async (req, res) => {
  try {
    const buscarJson = await buscarServicio.findAll();
    res.json(buscarJson);
  } catch (error) {
    console.log('Autos no encontrados')
    res.status(500).json({ error: 'Autos no encontrados' })
  }
})

module.exports = buscarAuto;