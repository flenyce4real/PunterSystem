const express = require('express')
const bodyParser = require('body-parser')
const router = express.Router()
const betslipControllers = require('../controllers/punter.controllers')

router.use(bodyParser.json())

const { addGame, newBet } = betslipControllers

router.post('/addgame', addGame)

router.post('/newbet', newBet)

module.exports = router;