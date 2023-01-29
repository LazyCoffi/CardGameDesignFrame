extends "res://class/entity/Card.gd"
class_name BattleCharacterCard

var BattleSkillCard = TypeUnit.type("BattleSkillCard")
var EquipmentCard = TypeUnit.type("EquipmentCard")
var BuffCard = TypeUnit.type("BuffCard")

var card_pile 			# BattleSkillCardPile
var equipment_set		# EquipmentCard_Dict
var buff_set			# BuffCard_Dict

func _init():
	card_pile = CardPile.new()
	card_pile.setParamType(BattleSkillCard)
	equipment_set = {}
	buff_set = {}

func copy():
	var ret = TypeUnit.type("BattleCharacterCard").new()
	ret.category = category.copy()
	ret.info = info.copy()
	ret.attr = attr.copy()
	ret.card_pile = card_pile.copy() 
	ret.equipment_set = {}
	for key in equipment_set.keys():
		ret.equipment_set[key] = equipment_set[key].copy()
	ret.buff_set = {}
	for key in buff_set:
		ret.buff_set[key] = buff_set[key].copy()
	
	return ret

# TODO: 包装参数列表
func getCards(upper_bound):
	return card_pile.deal([upper_bound])
	
func getCardsByNum(card_num, upper_bound):
	return card_pile.dealCards(min(card_num, upper_bound))

func addBuff(buff_card):
	var card_name = buff_card.getCardName()
	buff_set[card_name] = buff_card

func getBuffSet():
	return buff_set.duplicate()

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
	card_pile = script_tree.loadObject("card_pile", CardPile, BattleSkillCard)
	equipment_set = script_tree.loadObjectDict("equipment_set", EquipmentCard)
	buff_set = script_tree.loadObjectDict("buff_set", BuffCard)
