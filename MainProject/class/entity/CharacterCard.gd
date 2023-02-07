extends "res://class/entity/Card.gd"
class_name CharacterCard

var HandCardSlot = TypeUnit.type("HandCardSlot")
var EquipmentCard = TypeUnit.type("EquipmentCard")
var BuffCard = TypeUnit.type("BuffCard")

var hand_card_slot		# HandCardSlot
var equipment_set		# EquipmentCard_Dict
var buff_set			# BuffCard_Dict

func _init():
	hand_card_slot = HandCardSlot.new()
	equipment_set = {}
	buff_set = {}

func copy():
	var ret = TypeUnit.type("CharacterCard").new()

	ret.card_name = card_name
	ret.avator_name = avator_name
	ret.introduction = introduction
	ret.template_name = template_name
	ret.card_attr = card_attr.copy()

	ret.hand_card_slot = hand_card_slot.copy()
	ret.equipment_set = {}
	for key in equipment_set.keys():
		ret.equipment_set[key] = equipment_set[key].copy()
	ret.buff_set = {}
	for key in buff_set:
		ret.buff_set[key] = buff_set[key].copy()
	
	return ret

# hand_card_slot
func getHandCardsNum():
	return hand_card_slot.getCardsNum()

func peekHandCards():
	return hand_card_slot.peekCards()

func peekHandCardAt(index):
	return hand_card_slot.peekCardAt(index)

func playHandCardAt(param_list, card_pile, index):
	hand_card_slot.playCardAt(param_list, card_pile, index)

func drawHandCard(card_pile, card_num):
	hand_card_slot.drawCard(card_pile, card_num)

func positiveDiscardAt(index, card_pile):
	hand_card_slot.positiveDiscard(index, card_pile)

func passiveDiscard(card_pile):
	hand_card_slot.passiveDiscard(card_pile)

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

	# hand_card_slot交由派生类
	script_tree.addObjectDict("equipment_set", equipment_set)
	script_tree.addObjectDict("buff_set", buff_set)

	return script_tree

func loadScript(script_tree):
	.loadScript(script_tree)

	# hand_card_slot交由派生类
	equipment_set = script_tree.getObjectDict("equipment_set", EquipmentCard)
	buff_set = script_tree.getObjectDict("buff_set", BuffCard)
