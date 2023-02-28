extends "res://class/entity/Card.gd"
class_name CharacterCard

var HandCardSlot = TypeUnit.type("HandCardSlot")

var hand_card_slot		# HandCardSlot

func _init():
	hand_card_slot = HandCardSlot.new()

func copy():
	var ret = TypeUnit.type("CharacterCard").new()

	ret.card_name = card_name
	ret.avator_name = avator_name
	ret.introduction = introduction
	ret.template_name = template_name
	ret.card_attr = card_attr.copy()
	ret.hand_card_slot = hand_card_slot.copy()
	
	return ret

# hand_card_slot
func getHandCardsNum():
	return hand_card_slot.getCardsNum()

func isHandCardsEmpty():
	return hand_card_slot.peekCards().empty()

func peekHandCards():
	return hand_card_slot.peekCards().duplicate()

func peekHandCardAt(index):
	return hand_card_slot.peekCardAt(index)

func peekHandCardByName(card_name):
	return hand_card_slot.peekCardByName(card_name)
	
func playHandCardAt(param_list, card_pile, index):
	hand_card_slot.playCardAt(param_list, card_pile, index)

func playHandCardByName(param_list, card_pile, card_name):
	hand_card_slot.playCardByName(param_list, card_pile, card_name)

func drawHandCards(card_pile, card_num):
	hand_card_slot.drawCard(card_pile, card_num)

func positiveDiscardAt(card_pile, index):
	hand_card_slot.positiveDiscard(index, card_pile)

func passiveDiscard(card_pile):
	hand_card_slot.passiveDiscard(card_pile)

func pack():
	var script_tree = .pack()

	return script_tree

func loadScript(script_tree):
	.loadScript(script_tree)
