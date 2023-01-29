extends Node
class_name LinearBattleModel

var Heap = load("res://class/dataStruct/Heap.gd")
var ScriptTree = load("res://class/entity/ScriptTree.gd")
var BattleCharacterCard = load("res://class/entity/BattleCharacterCard.gd")
var BattleSkillCard = load("res://class/entity/BattleSkillCard.gd")
var Filter = load("res://class/functionalSystem/Filter.gd")
var DictArray = load("res://class/dataStruct/DictArray.gd")
var SettingTable = load("res://class/entity/SettingTable.gd")

var MAX_GROUP_SIZE = 4

var param_table				# Dict

var setting					# SettingTable
var character_groups		# Character_DictArray_Array
var order_queue				# Character_Heap
var order_filter			# Filter
var character_deal_filter	# Filter
var cur_character_card		# CharacterCard
var hand_cards_table				# SkillCard_DictArray_Dict
var total_round				# int

var character_rect_groups	# TextureRect_DictArray_Array
var hand_card_rect_group	# TextureRect_DictArray

func _init():
	setting = SettingTable.new()
	character_groups = []
	order_queue = Heap.new()
	order_queue.setParamType(BattleCharacterCard)
	order_filter = Filter.new()
	character_deal_filter = Filter.new()
	cur_character_card = BattleCharacterCard.new()
	hand_cards_table = {}
	character_rect_groups = []
	__setParamTable()

# param_table
func getParam(param_name):
	Exception.assert(param_table.has(param_name))
	return param_table[param_name]

# setting
func getSettingAttr(attr_name):
	return setting[attr_name]

func setSetting(setting_):
	setting = setting_

# character_groups
func getCharacterGroups():
	return character_groups

func setCharacterGroups(character_groups_):
	# TODO: 添加Warning警告，单组group暂时最多4Card

	Exception.assert(character_groups_[0] <= MAX_GROUP_SIZE)
	Exception.assert(character_groups_[1] <= MAX_GROUP_SIZE)

	character_groups = character_groups_

# order_queue
func getOrderQueue():
	return order_queue

func setOrderQueue(order_queue_):
	order_queue = order_queue_

# order_filter
func getOrder(card):
	return order_filter.exec([card])

func setOrderFilter(order_filter_):
	order_filter = order_filter_

# character_deal_filter
func dealCharacter():
	return character_deal_filter.exec([])

func setCharacterDealFilter(character_deal_filter_):
	character_deal_filter = character_deal_filter_

# cur_character_card
func getCurCharacterCard():
	return cur_character_card

func getCurCharacterName():
	return cur_character_card.getCardName()

func setCurCharacterCard(cur_character_card_):
	cur_character_card = cur_character_card_

# hand_cards_table
func getHandCardsTable():
	return hand_cards_table

func setHandCardsTable(hand_cards_table_):
	hand_cards_table = hand_cards_table_

func getHandCards(character_name):
	return hand_cards_table[character_name]

func getCurHandCards():
	return hand_cards_table[cur_character_card.getCardName()]

func getHandCardsNum(character_name):
	return hand_cards_table[character_name].size()

func getCurHandCardsNum():
	return hand_cards_table[cur_character_card.getCardName()].size()

func setHandCards(character_name, hand_cards):
	hand_cards_table[character_name] = hand_cards

# total
func resetTotalRound():
	total_round = 0

func nextRound():
	total_round += 1

func getTotalRound():
	return total_round

# character_rect_groups
func getCharacterRectGroups():
	return character_rect_groups

func setCharacterRectGroups(character_rect_groups_):
	character_rect_groups = character_rect_groups_

# hand_card_rect_group
func getHandCardRectGroup():
	return hand_card_rect_group

func setHandCardRectGroup(hand_card_rect_group_):
	hand_card_rect_group = hand_card_rect_group_


func pack():
	var script_tree = ScriptTree.new()

	script_tree.addObject("setting", setting)
	script_tree.addTypeObjectArray("character_groups", character_groups)
	script_tree.addTypeObject("order_queue", order_queue)
	script_tree.addObject("order_filter", order_filter)
	script_tree.addObject("character_deal_filter", character_deal_filter)
	script_tree.addObject("cur_character_card", cur_character_card)
	script_tree.addTypeObjectDict("hand_cards_table", hand_cards_table)
	script_tree.addAttr("total_round", total_round)

	return script_tree

func loadScript(script_tree):
	setting = script_tree.getObject("setting", SettingTable)
	character_groups = script_tree.getTypeObjectArray("character_groups", DictArray, BattleCharacterCard)
	order_queue = script_tree.getTypeObject("order_queue", Heap, BattleCharacterCard)
	order_filter = script_tree.getObject("order_filter", Filter)
	character_deal_filter = script_tree.getObject("character_deal_filter", Filter)
	cur_character_card = script_tree.getObject("cur_character_card", BattleCharacterCard)
	hand_cards_table = script_tree.getTypeObjectDict("hand_cards_table", DictArray, SkillCard)
	total_round = script_tree.getInt("total_round")

func __setParamTable():
	param_table = {}
	__addParam("setting", setting)
	__addParam("character_groups", character_groups)
	__addParam("order_queue", order_queue)
	__addParam("order_filter", order_filter)
	__addParam("character_rect_groups", character_rect_groups)
	__addParam("character_deal_filter", character_deal_filter)
	__addParam("cur_character_card", cur_character_card)
	__addParam("hand_cards_table", hand_cards_table)
	__addParam("hand_card_rect_group", hand_card_rect_group)
	__addParam("total_round", total_round)

func __addParam(param_name, param):
	param_table[param_name] = param
