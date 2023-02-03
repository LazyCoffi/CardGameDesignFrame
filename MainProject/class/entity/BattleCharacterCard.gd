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
	ret.card_name = card_name
	ret.avator_name = avator_name
	ret.introduction = introduction
	ret.template_name = template_name
	ret.card_attr = card_attr.copy()
	ret.card_pile = card_pile.copy() 
	ret.equipment_set = {}
	for key in equipment_set.keys():
		ret.equipment_set[key] = equipment_set[key].copy()
	ret.buff_set = {}
	for key in buff_set:
		ret.buff_set[key] = buff_set[key].copy()
	
	return ret

# card_pile
func peekCardPile():
	return card_pile.getCardPile()

func peekTrashPile():
	return card_pile.getTrashPile()

func pileRandomOn():
	card_pile.randomOn()

func pileRandomOff():
	card_pile.randomOff()

func dealCards(num):
	return card_pile.deal(num)

func dealTrashCards(num):
	return card_pile.dealTrash(num)

func drawCardFront(card):
	card_pile.drawFront(card)

func drawCardBack(card):
	card_pile.drawBack(card)

func drawTrashCardFront(card):
	card_pile.drawTrashFront(card)

func drawTrashCardBack(card):
	card_pile.drawTrashBack(card)

func shufflePile():
	card_pile.shufflePile()

func shuffleTrash():
	card_pile.shuffleTrash()

# buff_set
func addBuff(buff_card):
	var card_name = buff_card.getCardName()
	buff_set[card_name] = buff_card

func peekBuff():
	return buff_set.duplicate()

# equipment_set
func equip(equipment_card):
	equipment_card.equip(self)
	var card_name = equipment_card.getCardName()
	equipment_set[card_name] = equipment_card
		
func unequip(card_name):
	Exception.assert(equipment_set.has(card_name))
	var equipment_card = equipment_set[card_name]
	equipment_card.unequip(self)
	equipment_set.erase(card_name)
	
func pack():
	var script_tree = .pack()

	script_tree.addObject("card_pile", card_pile)
	script_tree.addObjectDict("equipment_set", equipment_set)
	script_tree.addObjectDict("buff_set", buff_set)

	return script_tree

func loadScript(script_tree):
	.loadScript(script_tree)
	card_pile = script_tree.getTypeObject("card_pile", CardPile, BattleSkillCard)
	equipment_set = script_tree.getObjectDict("equipment_set", EquipmentCard)
	buff_set = script_tree.getObjectDict("buff_set", BuffCard)
