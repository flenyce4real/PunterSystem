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

app.post('/addgame', (req, res) => {
    const {gameid, choice, amount} = req.body
})

app.post('/newbet', (req, res) => {
const {gameid, choice, amount} = req.body
    try{
        connection.connect(err => {
            if (err) throw err;
            connection.query(`SELECT * FROM selections WHERE gameid='${gameid}'`, (error, results, fields) => {
                if (error) throw error;
                if(results.length > 0){
                    if(results[0].betcount <= 10){
                        connection.query(`INSERT INTO betslips(betid, gameid, choice, amount)
                        VALUES('${uuidv4()}','${gameid}','${choice}',${Number(amount)})`, (error, results, fields) => {
                            if(error) throw error
                            else{
                                connection.query(`UPDATE booked SET playcount = playcount + 1 WHERE gameid='${gameid}'`, (error, results, fields) => {
                                    if (error) throw error;
                                    res.status(201).json({
                                        status: true,
                                        message: "Bet successfully placed and accepted",
                                        data: req.body
                                    })
                                })
                            }
                        })
                    }else{
                        throw 'Selected game is closed/expired';
                    }
                }else{
                    throw 'Selected game does not exist';
                }
            })
        })
    }catch(e){
        res.status(400).json({
            message: e.message
        })
    }
})