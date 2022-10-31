extends Node

var CharacterCard = load("res://class/CharacterCard.gd")
var EquipmentCard = load("res://class/EquipmentCard.gd")
var SkillCard = load("res://class/SkillCard.gd")
var ItemCard = load("res://class/ItemCard.gd")

var cards = {}

func parseType(type):
	if type == "CharacterCard":
		return CharacterCard
	if type == "EquipmentCard":
		return EquipmentCard
	if type == "SkillCard":
		return SkillCard
	if type == "ItemCard":
		return ItemCard
		
	assert(false)

func loadCards():
	var raw_content = ResourceTool.parse("res://script/cards/cardTemplate.json")
	assert(raw_content is Array)
	
	for card in raw_content:
		var card_name = card["name"]
		var card_type = parseType(card["type"])
		var card_content = card["content"]
		
		assert(not cards.has(card_name))
		
		cards[card_name] = card_type.loadPack(card_content)

func getCard(card_name):
	assert(cards.has(card_name))
	
	var card = cards[card_name]
	card.loadResource()
	
	return card
