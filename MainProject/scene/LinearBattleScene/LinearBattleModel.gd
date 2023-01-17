extends Node
class_name LinearBattleModel

var Heap = load("res://class/dataStruct/Heap.gd")
var ScriptTree = load("res://class/entity/ScriptTree")
var BattleCharacterCard = load("res://class/entity/BattleCharacterCard.gd")
var Filter = load("res://class/functionalSystem/Filter.gd")

class RectPack:
	var rect_name
	var rect

var MAX_GROUP_SIZE = 4

var param_map				# Dict

var setting					# Dict
var character_groups		# Character_Dict_Array

var order_queue				# Heap
var order_filter			# Filter

var character_rect_groups	# TextureRect_2DArray
var character_deal_filter	# Filter

var cur_character_card		# CharacterCard

var hand_cards				# SkillCard_Array_Dict
var hand_card_rect_group	# TextureRect_Array

var total_round				# int

var scene_pack				# Object_Dict

func _init():
	character_groups = [{}, {}]
	character_rect_groups = [[], []]
	hand_cards = {}
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

	for index in 2:
		for card in groups:
			var card_name = card.getCardName()
			character_groups[index][card_name] = card

			var order = order_filter.exec(card)
			order_queue.append(card, order)

func getCharacterGroups():
	return character_groups

func getCharcterNum():
	return [character_groups[0].size(), character_groups[1].size()]

func getCurCharacterCard():
	return cur_character_card

func setCurCharacterCard(cur_character_card_):
	cur_character_card = cur_character_card_

func popCurRoundCard():
	return order_queue.pop()

func peekCurRoundCard():
	return order_queue.top()

func pushCurRoundCard(character_card):
	var order = order_filter.exec([character_card])
	order_queue.append(character_card, order)

func addHandCard(character_name, new_hand_card):
	if hand_cards.has(character_name):
		hand_cards[character_name].append(new_hand_card)
	else:
		hand_cards[character_name] = [new_hand_card]

func addHandCards(character_name, new_hand_cards):
	if hand_cards.has(character_name):
		hand_cards[character_name].append_array(new_hand_cards)
	else:
		hand_cards[character_name] = new_hand_cards
	
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

func setCharacterRectGroups(character_rect_groups_):
	character_rect_groups = character_rect_groups_

func getHandCardRectGroup():
	return hand_card_rect_group

func setHandCardRectGroup(hand_card_rect_group_):
	hand_card_rect_group = hand_card_rect_group_

func pack():
	var script_tree = ScriptTree.new()

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
