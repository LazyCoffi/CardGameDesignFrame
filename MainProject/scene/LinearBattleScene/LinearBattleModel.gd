extends Node
class_name LinearBattleModel

var Heap = load("res://class/dataStruct/Heap.gd")
var ScriptTree = load("res://class/entity/ScriptTree")
var BattleCharacterCard = load("res://class/entity/BattleCharacterCard.gd")
var BattleSkillCard = load("res://class/entity/BattleSkillCard.gd")
var Filter = load("res://class/functionalSystem/Filter.gd")
var DictArray = load("res://class/dataStruct/DictArray.gd")

var MAX_GROUP_SIZE = 4

var param_map				# Dict

var setting					# Dict
var character_groups		# Character_DictArray_Array
var order_queue				# Character_Heap
var order_filter			# Filter
var character_deal_filter	# Filter
var cur_character_card		# CharacterCard
var hand_cards				# SkillCard_DictArray_Dict
var total_round				# int

var character_rect_groups	# TextureRect_DictArray_Array
var hand_card_rect_group	# TextureRect_DictArray

func _init():
	__setParamMap()

func getParam(param_name):
	Exception.assert(param_map.has(param_name))
	return param_map[param_name]

func getSettingAttr(attr_name):
	return setting[attr_name]

func setCharacterGroup(groups):
	# TODO: 添加Warning警告，单组group暂时最多4Card

	Exception.assert(groups[0] <= MAX_GROUP_SIZE)
	Exception.assert(groups[1] <= MAX_GROUP_SIZE)

	character_groups = groups

	for index in 2:
		for card in groups[index].values():
			var order = order_filter.exec(card)
			order_queue.append(card, order)

func setCurCharacterCard(cur_character_card_):
	cur_character_card = cur_character_card_

func setCharacterRectGroups(character_rect_groups_):
	character_rect_groups = character_rect_groups_

func setHandCardRectGroup(hand_card_rect_group_):
	hand_card_rect_group = hand_card_rect_group_


func getCharacterGroups():
	return character_groups

func getCharcterNum():
	return [character_groups[0].size(), character_groups[1].size()]

func getCurCharacterCard():
	return cur_character_card

func popCurRoundCard():
	return order_queue.pop()

func peekCurRoundCard():
	return order_queue.top()

func pushCurRoundCard(character_card):
	var order = order_filter.exec([character_card])
	order_queue.append(character_card, order)

func addHandCard(character_name, new_hand_card):
	if hand_cards.has(character_name):
		hand_cards[character_name].append(character_name, new_hand_card)
	else:
		var dict_array = DictArray.new()
		dict_array.append(character_name, new_hand_card)
		hand_cards[character_name] = dict_array

func addHandCards(character_name, new_hand_cards):
	if hand_cards.has(character_name):
		hand_cards.append_array(new_hand_cards)
	else:
		var dict_array = DictArray.new()
		dict_array.loadFromArray(new_hand_cards)
		hand_cards[character_name] = dict_array
	
func getHandCards(character_name):
	Exception.assert(hand_cards.has(character_name))
	return hand_cards[character_name]

func getHandCardsNum(character_name):
	Exception.assert(hand_cards.has(character_name))
	return hand_cards[character_name].size()

func resetTotalRound():
	total_round = 0

func nextRound():
	total_round += 1

func getTotoalRound():
	return total_round

func getScenePack():
	return scene_pack

func getCharacterDealFilter():
	return character_deal_filter

func getHandCardRectGroup():
	return hand_card_rect_group

func pack():
	var script_tree = ScriptTree.new()

	script_tree.addAttr("setting", setting)
	script_tree.addContainerArray("character_groups", character_groups)
	script_tree.addContainer("order_queue", heap)
	script_tree.addObject("order_filter", order_filter)
	script_tree.addObject("character_deal_filter", character_deal_filter)
	script_tree.addObject("cur_character_card", cur_character_card)
	script_tree.addContainerDict("hand_cards", hand_cards)
	script_tree.addAttr("total_round", total_round)

	return script_tree

func loadScript(script_tree):
	setting = script_tree.getAttr("setting")
	character_groups = script_tree.getContainerArray("character_groups", DictArray, BattleCharacterCard)
	order_queue = script_tree.getContainer("order_queue", Heap, BattleCharacterCard)
	order_filter = script_tree.getObject("order_filter", Filter)
	character_deal_filter = script_tree.getObject("character_deal_filter", Filter)
	cur_character_card = script_tree.getObject("cur_character_card", BattleCharacterCard)
	hand_cards = script_tree.getContainerDict("hand_cards", DictArray, SkillCard)
	total_round = script_tree.getAttr("total_round")

func initScript(script_tree):
	setting = script_tree.getAttr("setting")
	character_groups = []
	order_queue = Heap.new()
	order_filter = script_tree.getObject("order_filter", Filter)
	character_deal_filter = script_tree.getObject("character_deal_filter", Filter)
	cur_character_card = null
	hand_cards = {}
	total_round = 0

func __setParamMap():
	__addParam("setting", setting)
	__addParam("character_groups", character_groups)
	__addParam("order_queue", order_queue)
	__addParam("order_filter", order_filter)
	__addParam("character_rect_groups", character_rect_groups)
	__addParam("character_deal_filter", character_deal_filter)
	__addParam("cur_character_card", cur_character_card)
	__addParam("hand_cards", hand_cards)
	__addParam("hand_card_rect_group", hand_card_rect_group)
	__addParam("total_round", total_round)

func __addParam(param_name, param):
	param_map[param_name] = param
