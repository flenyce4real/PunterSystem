require('dotenv').config()
const express = require("express")
const mysql = require('mysql2')
const bodyParser = require('body-parser')
const { v4: uuidv4 } = require('uuid')
const Joi = require('joi')
const app = express()
const port = process.env.SERVER_PORT

app.use(bodyParser.json())


app.listen(port, () => {
    console.log(`PunterSytem Server is running on port: ${port}`)
})

const connection = mysql.createConnection({
    host: process.env.DATABASE_HOST,
    port: process.env.DATABASE_PORT,
    user: process.env.DATABASE_USER,
    password: process.env.DATABASE_PASSWORD,
    database: process.env.DATABASE_NAME
})

connection.connect()

app.post('/game', (req, res) => {

})

app.post('/bet', (req, res) => {

})