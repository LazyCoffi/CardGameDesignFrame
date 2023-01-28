extends Node
class_name CardPile

var ScriptTree = load("res://class/entity/ScriptTree.gd")
var Filter = load("res://class/functionalSystem/Filter.gd")

var card_pile			# Array
var trash_pile			# Array
var is_random			# bool
var pop_num_filter		# Filter

var param_type

func _init():
	card_pile = []
	trash_pile = []
	is_random = true

func setParamType(param_type_):
	param_type = param_type_

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

func pack():
	var script_tree = ScriptTree.new()

	script_tree.addObjectArray("card_pile", card_pile)
	script_tree.addObjectArray("trash_pile", trash_pile)
	script_tree.addAttr("is_random", is_random)
	script_tree.addObject("pop_num_filter", pop_num_filter)

	return script_tree

func loadScript(script_tree):
	script_tree.getObjectArray("card_pile", param_type)
	script_tree.getObjectArray("trash_pile", param_type)
	script_tree.getBool("is_random")
	script_tree.getObject("pop_num_filter", Filter)
