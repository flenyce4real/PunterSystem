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

function UserException(message) {
    this.message = message;
    this.name = 'UserException';
  }

app.post('/addgame', (req, res) => {
    const schema = Joi.object({
        fixture: Joi.string().min(5).required(),
        options: Joi.object().required(),
    })
    
    const { error, value } = schema.validate(req.body);
    
    if (error != undefined) {
        res.status(400).send({
            status: false,
            message: error
        })
    }

    const {fixture, options} = req.body
    const gameid = uuidv4();
    const refid = gameid.split('-')[0].toUpperCase()

    try{
        connection.connect(err => {
            if (err) throw err;
            connection.query(`INSERT INTO games(game_id, ref_id, fixture)
            VALUES('${gameid}','${refid}','${fixture}')`, (error, results, fields) => {
                if(error) throw error
                else{
                    for(let option in options){
                        connection.query(`INSERT INTO options(choice_id, game_id, choice, odd)
                        VALUES('${uuidv4()}','${gameid}','${option}',${Number(options[option])})`, (error, results, fields) => {
                            if(error) throw error
                        })
                    }
                    res.status(201).json({
                        message: "Game successfully added",
                        data: [{"refid": refid}, {"fixture": fixture}, {"options": option}]
                    })
                }
            })
        })
    }catch(e){
        res.status(400).json({
            message: e.message
        })
    }
})

app.post('/newbet', (req, res) => {
    const schema = Joi.object({
        refid: Joi.string().min(8).max(10).required(),
        choice: Joi.string().min(1).max(30).required(),
        amount: Joi.number().min(100).required(),
    })
    
    const { error, value } = schema.validate(req.body);
    
    if (error != undefined) {
        res.status(400).send({
            status: false,
            message: error
        })
    }

    const { refid, choice, amount } = req.body

    try{
        connection.connect(err => {
            if (err) throw err;
            connection.query(`SELECT fixture, g.game_id, counter, odd FROM games g join options o on g.game_id = o.game_id WHERE ref_id='${refid}' and choice='${choice}'`,
            (error, results, fields) => {
                if (error) throw error;
                if(results.length > 0){
                    const { game_id, odd, fixture, counter } = results[0]
                    const potwin = odd * Number(amount)
                    if(counter <= 10){
                        connection.query(`INSERT INTO betslips(slip_id, game_id, choice, bet_amount, pot_win)
                        VALUES('${uuidv4()}','${game_id}','${choice}',${Number(amount)},${potwin})`, (error, results, fields) => {
                            if(error) throw error
                            else{
                                connection.query(`UPDATE games SET counter = counter + 1 WHERE ref_id='${refid}'`, (error, results, fields) => {
                                    if (error) throw error;
                                    res.status(201).json({
                                        message: "Bet successfully placed and accepted",
                                        data: [{"Fixture": fixture}, {"Options": choice}, {"Bet Amount": Number(amount)}, {"Possible Win": potwin}]
                                    })
                                })
                            }
                        })
                    }else{
                        throw new Error('Selected game is closed/expired');
                    }
                }else{
                    throw new Error('Selected game or option does not exist');
                }
            })
        })
    }catch(e){
        res.status(400).json({
            message: e.message
        })
    }
})