const express = require('express')
const bodyParser = require('body-parser')
const router = express.Router()
const { addGame, newBet } = require('../controllers/punter.controllers')

router.use(bodyParser.json())

router.post('/addgame', addGame)

router.post('/newbet', newBet)

module.exports = router;