require('./cronJobs/reservationCleanup');
const express = require("express");
const morgan = require("morgan");
const cors = require("cors");

const { carRouter } = require("./routes/cars");
const { airportRouter } = require("./routes/airports");
const { reservationRouter } = require("./routes/reservation");
const { searchRouter } = require("./routes/search");
const { userRouter } = require("./routes/users");
const loginRoutes = require('./login');
const detailCarModule = require('./modules/detailCar/detailCar.module');
const searchCarModule = require('./modules/searchCar/searchCar.module');

const app = express()

app.use(cors())
app.use(express.json())
app.use(morgan("dev"))
app.disable("x-powered-by")

app.use('/api/cars', carRouter)
app.use('/api/airports', airportRouter)
app.use('/api/reservations', reservationRouter)
app.use('/api/search', searchRouter)
app.use('/api/users', userRouter)
app.use('/login', loginRoutes);
app.use('/detailCar', detailCarModule.controller);
app.use('/searchCar', searchCarModule.controller);

module.exports = app;
