require('dotenv').config()
const express = require("express")
const app = express()
const port = process.env.SERVER_PORT
const punterRoutes = require('./routes/punter.routes')

app.use(bodyParser.json())
app.use(punterRoutes)

app.listen(port, () => {
    console.log(`PunterSytem Server is running on port: ${port}`)
})