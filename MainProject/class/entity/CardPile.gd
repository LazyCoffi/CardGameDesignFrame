extends Node
class_name CardPile

var card_pile
var trash_pile
var is_random

var pop_num_filter

func _init():
	card_pile = []
	trash_pile = []
	is_random = true

func randomOn():
	is_random = true

func randomOff():
	is_random = false

func drawCards(cards):
	card_pile.append_array(cards)

func deal(params):
	TypeUnit.isType(pop_num_filter, "Functional")
	var num = pop_num_filter.exec(params)
	return dealCards(num)

func dealCards(num):
	if num > card_pile.size() + trash_pile.size():
		# TODO: 添加warning
		num = card_pile.size() + trash_pile.size()

	var ret = []
	while not card_pile.empty() and num > 0:
		ret.append(card_pile.pop_front())
		num -= 1

	if num > 0:
		card_pile.append_array(trash_pile)
		if is_random:
			randomize()
			card_pile.shuffle()

		trash_pile.clear()

		while not card_pile.empty() and num > 0:
			ret.append(card_pile.pop_front())
			num -= 1
	
	trash_pile.append_array(ret)
	return ret

func dealTrash(num):
	if num > trash_pile.size():
		# TODO: 添加warning
		num = trash_pile.size()
	
	var ret = []
	while num > 0:
		ret.append(trash_pile.pop_front())
	
	return ret

func getAllCards():
	var ret = card_pile.duplicate()
	ret.append_array(trash_pile)
	
	return ret

func shufflePile():
	randomize()
	card_pile.shuffle()
	
func shuffleTrash():
	randomize()
	trash_pile.shuffle()
