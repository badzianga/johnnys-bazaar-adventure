extends Node


var upgrades := [
	{
		"Name": "Djed",
		"Description": "Spawns a pillar which shoots a projectile dealing 5 damage every 1.6 seconds.",
		"Price": 6,
		"Icon": "djed.png",
		"Requirement": "",
		"Id": 0,
	},
	{
		"Name": "Extra Djed I",
		"Description": "Spawns an extra Djed.",
		"Price": 12,
		"Icon": "djed.png",
		"Requirement": "Djed",
		"Id": 1,
	},
	{
		"Name": "Extra Djed II",
		"Description": "Spawns an extra Djed.",
		"Price": 28,
		"Icon": "djed.png",
		"Requirement": "Extra Djed I",
		"Id": 2,
	},
	{
		"Name": "Djed Upgrade I",
		"Description": "Increases Djed damage by 5. Decreases Djed cooldown by 8%.",
		"Price": 10,
		"Icon": "djed.png",
		"Requirement": "Djed",
		"Id": 3,
	},
	{
		"Name": "Djed Upgrade II",
		"Description": "Increases Djed damage by 10 and Djed bullet penetration by 1. Djed shoots an extra bullet.",
		"Price": 18,
		"Icon": "djed.png",
		"Requirement": "Djed Upgrade I",
		"Id": 4,
	},
	{
		"Name": "Djed Upgrade III",
		"Description": "Increases Djed bullet penetration by 1 and damage by 10%. Decreases Djed cooldown by 8%.",
		"Price": 32,
		"Icon": "djed.png",
		"Requirement": "Djed Upgrade II",
		"Id": 5,
	},
	{
		"Name": "Scroll of Ra - damage I",
		"Description": "Increases damage by 5.",
		"Price": 3,
		"Icon": "ra_scroll.png",
		"Requirement": "",
		"Id": 6,
	},
	{
		"Name": "Scroll of Ra - damage II",
		"Description": "Increases damage by 10.",
		"Price": 10,
		"Icon": "ra_scroll.png",
		"Requirement": "Scroll of Ra - damage I",
		"Id": 7,
	},
	{
		"Name": "Scroll of Ra - damage III",
		"Description": "Increases damage by 10.",
		"Price": 18,
		"Icon": "ra_scroll.png",
		"Requirement": "Scroll of Ra - damage II",
		"Id": 8,
	},
	{
		"Name": "Scroll of Ra - cooldown I",
		"Description": "Reduces cooldown by 0.15 second.",
		"Price": 5,
		"Icon": "ra_scroll.png",
		"Requirement": "",
		"Id": 9,
	},
	{
		"Name": "Scroll of Ra - cooldown II",
		"Description": "Reduces cooldown by 0.1 second.",
		"Price": 12,
		"Icon": "ra_scroll.png",
		"Requirement": "Scroll of Ra - cooldown I",
		"Id": 10,
	},
	{
		"Name": "Scroll of Ra - cooldown III",
		"Description": "Reduces cooldown by 0.2 second.",
		"Price": 25,
		"Icon": "ra_scroll.png",
		"Requirement": "Scroll of Ra - cooldown II",
		"Id": 11,
	},
	{
		"Name": "Scroll of Ra - orb upgrade I",
		"Description": "Shoots and extra light orb. Light orbs penetrate 1 more enemy.",
		"Price": 8,
		"Icon": "ra_scroll.png",
		"Requirement": "",
		"Id": 12,
	},
	{
		"Name": "Scroll of Ra - orb upgrade II",
		"Description": "Shoots and extra light orb. Light orbs penetrate 1 more enemy.",
		"Price": 20,
		"Icon": "ra_scroll.png",
		"Requirement": "Scroll of Ra - orb upgrade I",
		"Id": 13,
	},
	{
		"Name": "Ankh I",
		"Description": "Increases max health by 5 and movement speed by 5%.",
		"Price": 10,
		"Icon": "ankh.png",
		"Requirement": "",
		"Id": 14,
	},
	{
		"Name": "Ankh II",
		"Description": "Increases max health by 8 and movement speed by 10%.",
		"Price": 24,
		"Icon": "ankh.png",
		"Requirement": "Ankh I",
		"Id": 15,
	},
	{
		"Name": "Ankh III",
		"Description": "Increases max health by 10.",
		"Price": 30,
		"Icon": "ankh.png",
		"Requirement": "Ankh II",
		"Id": 16,
	},
	{
		"Name": "Hathor Symbol I",
		"Description": "Increases all damage by 8% and all bullet speed by 15%. Reduces all cooldown by 8%.",
		"Price": 7,
		"Icon": "hathor.png",
		"Requirement": "",
		"Id": 17,
	},
	{
		"Name": "Hathor Symbol II",
		"Description": "Increases all damage by 8% and all bullet speed by 15%. Reduces all cooldown by 8%.",
		"Price": 20,
		"Icon": "hathor.png",
		"Requirement": "Hathor Symbol I",
		"Id": 18,
	},
]

var available_upgrades: Array[Dictionary]


func _ready() -> void:
	push_upgrades()


func push_upgrades() -> void:
	for upgrade in upgrades:
		available_upgrades.append(upgrade)
