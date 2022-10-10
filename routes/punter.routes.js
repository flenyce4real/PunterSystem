const express = require('express')
const bodyParser = require('body-parser')
const router = express.Router()
const betslipControllers = require('../controllers/punter.controllers')

router.use(bodyParser.json())

router.post('/addgame', betslipControllers.addGame)

router.post('/newbet', betslipControllers.newBet)

module.exports = router;