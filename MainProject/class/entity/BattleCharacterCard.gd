extends "res://class/entity/Card.gd"
class_name BattleCharacterCard

var BattleSkillCardPile = load("res://class/entity/BattleSkillCardPile.gd")
var EquipmentCard = load("res://class/entity/EquipmentCard.gd")
var BuffCard = load("res://class/entity/BuffCard.gd")

var card_pile 			# BattleSkillCardPile
var equipment_set		# EquipmentCard_Dict
var buff_set			# BuffCard_Dict

func _init():
	equipment_set = {}
	buff_set = {}

func getCards(upper_bound):
	return card_pile.deal([upper_bound])
	
func getCardsByNum(card_num, upper_bound):
	return card_pile.dealCards(min(card_num, upper_bound))

func addBuff(buff_card):
	var card_name = buff_card.getCardName()
	buff_set[card_name] = buff_card

func getBuffSet():
	return buff_set

func equip(equipment_card):
	if equipment_card.isEquipConditon([self]):
		var new_card = equipment_card.equip([self])
		__selfEquipRefresh(new_card)

		var card_name = equipment_card.getCardName()
		equipment_set[card_name] = equipment_card
		
		return true
	
	return false
	
func unequip(card_name):
	Exception.assert(equipment_set.has(card_name))
	var equipment_card = equipment_set[card_name]
	equipment_set.erase(card_name)
	
	var new_card = equipment_card.unequip([self])
	__selfEquipRefresh(new_card)
	
func __selfEquipRefresh(equipment_card):
	self.attr = equipment_card.attr
	self.card_pile = equipment_card.card_pile
	self.buff_set = equipment_card.buff_set

func pack():
	var script_tree = .pack()

	script_tree.addObject("card_pile", card_pile)
	script_tree.addObjectDict("equipment_set", equipment_set)
	script_tree.addObjectDict("buff_set", buff_set)

	return script_tree

func loadScript(script_tree):
	.loadScript(script_tree)
	card_pile = script_tree.loadObject("card_pile", CardPile)
	equipment_set = script_tree.loadObjectDict("equipment_set", equipment_set)
	buff_set = script_tree.loadObjectDict("buff_set", buff_set)
