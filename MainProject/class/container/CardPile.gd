extends Node
class_name CardPile

var ScriptTree = TypeUnit.type("ScriptTree")

var card_pile			# Array
var trash_pile			# Array
var is_random			# bool

var param_type

func _init():
	card_pile = []
	trash_pile = []
	is_random = true

func copy():
	var ret = TypeUnit.type("CardPile").new()
	
	ret.card_pile = []
	for card in card_pile:
		ret.card_pile.append(card.copy())
	
	ret.trash_pile = []
	for card in trash_pile:
		ret.trash_pile.append(card.copy())
	
	ret.is_random = is_random

	ret.param_type = param_type

	return ret

func setParamType(param_type_):
	param_type = param_type_

# is_random
func randomOn():
	is_random = true

func randomOff():
	is_random = false
	
# card_pile
func getCardsNum():
	return card_pile.size()

func getTrashCardsNum():
	return trash_pile.size()

func getAllCards():
	var ret = card_pile.duplicate()
	ret.append_array(trash_pile)
	
	return ret

func getCardPile():
	return card_pile.duplicate()

func setCardPile(card_pile_):
	card_pile = card_pile_

func getTrashPile():
	return trash_pile.duplicate()

func setTrashPile(trash_pile_):
	trash_pile = trash_pile_

func deal(num):
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
	
	# trash_pile.append_array(ret)
	return ret

func dealTrash(num):
	if num > trash_pile.size():
		# TODO: 添加warning
		num = trash_pile.size()
	
	var ret = []
	while num > 0:
		ret.append(trash_pile.pop_front())
	
	return ret

func pushFront(card):
	card_pile.push_front(card)

func pushBack(card):
	card_pile.push_back(card)

func pushTrashFront(card):
	trash_pile.push_front(card)

func pushTrashBack(card):
	trash_pile.push_back(card)

func clearPile():
	card_pile.clear()
	trash_pile.clear()

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

	return script_tree

func loadScript(script_tree):
	card_pile = script_tree.getObjectArray("card_pile", param_type)
	trash_pile = script_tree.getObjectArray("trash_pile", param_type)
	is_random = script_tree.getBool("is_random")
