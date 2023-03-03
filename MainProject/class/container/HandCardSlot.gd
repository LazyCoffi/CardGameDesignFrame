extends Node
class_name HandCardSlot

var ScriptTree = TypeUnit.type("ScriptTree")

var card_slot
var param_type

func _init():
	card_slot = []

func copy():
	var ret = TypeUnit.type("HandCardSlot").new()
	ret.card_slot = []
	for node in card_slot:
		ret.card_slot.append(node.copy())
	
	ret.param_type = param_type
	
	return ret

func setParamType(param_type_):
	param_type = param_type_

# card_slot
func getCardsNum():
	return card_slot.size()

func peekCardAt(index):
	return card_slot[index]

func peekCardByName(card_name):
	for hand_card in card_slot:
		if hand_card.getCardName() == card_name:
			return hand_card

func peekCards():
	return card_slot.duplicate()

func drawCard(card_pile, card_num):
	var cards = card_pile.deal(card_num)
	card_slot.append_array(cards)

func playCardAt(param_list, card_pile, index):
	var card = card_slot[index]
	card.exec(param_list)
	card.afterPlayDiscard(card_pile, card_slot)

func playCardByName(param_list, card_pile, card_name):
	for card in card_slot:
		if card.getCardName() == card_name:
			card.exec(param_list)
			card.afterPlayDiscard(card_pile, card_slot)
	
func positiveDiscardAt(card_pile, index):
	card_slot[index].positiveDiscard(card_pile, card_slot)

func passiveDiscard(card_pile):
	var i = 0
	while i < card_slot.size():
		var card = card_slot[i]
		if not card.passiveDiscard(card_pile, card_slot):
			i += 1

func setCardSlot(card_slot_):
	card_slot = card_slot_
	
func pack():
	var script_tree = ScriptTree.new()

	script_tree.addObjectArray("card_slot", card_slot)

	return script_tree

func loadScript(script_tree):
	card_slot = script_tree.getObjectArray("card_slot", param_type)
