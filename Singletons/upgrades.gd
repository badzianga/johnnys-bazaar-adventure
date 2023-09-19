extends Node


var upgrades := [
	{
		"Name": "Djed",
		"Description": "Spawns a pillar which shoots a slow projectile dealing 5 damage every 1.6 seconds.",
		"Price": 10,
		"Icon": "djed.png",
		"Requirement": "",
		"Id": 0,
	},
	{
		"Name": "Extra Djed I",
		"Description": "Spawns an extra Djed.",
		"Price": 20,
		"Icon": "djed.png",
		"Requirement": "Djed",
		"Id": 1,
	},
	{
		"Name": "Scroll of Ra - damage I",
		"Description": "Increases damage by 5.",
		"Price": 5,
		"Icon": "ra_scroll.png",
		"Requirement": "",
		"Id": 2,
	},
	{
		"Name": "Scroll of Ra - damage II",
		"Description": "Increases damage by 10.",
		"Price": 15,
		"Icon": "ra_scroll.png",
		"Requirement": "Scroll of Ra - damage I",
		"Id": 3,
	},
	{
		"Name": "Scroll of Ra - damage III",
		"Description": "Increases damage by 15.",
		"Price": 50,
		"Icon": "ra_scroll.png",
		"Requirement": "Scroll of Ra - damage II",
		"Id": 4,
	},
	{
		"Name": "Scroll of Ra - cooldown I",
		"Description": "Reduces cooldown by 0.1 second.",
		"Price": 5,
		"Icon": "ra_scroll.png",
		"Requirement": "",
		"Id": 5,
	},
	{
		"Name": "Scroll of Ra - extra orb I",
		"Description": "Shoots and extra light orb.",
		"Price": 10,
		"Icon": "ra_scroll.png",
		"Requirement": "",
		"Id": 6,
	},
	{
		"Name": "Ankh",
		"Description": "Increases max health by 5.",
		"Price": 10,
		"Icon": "ankh.png",
		"Requirement": "",
		"Id": 7,
	},
]

@onready var available_upgrades := upgrades