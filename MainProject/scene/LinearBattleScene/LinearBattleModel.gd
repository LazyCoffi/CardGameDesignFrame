extends "res://scene/BaseModel.gd"
class_name LinearBattleModel

var LinearCharacterCard = TypeUnit.type("LinearCharacterCard")
var LinearSkillCard = TypeUnit.type("LinearSkillCard")
var Function = TypeUnit.type("Function")
var PollingBucket = TypeUnit.type("PollingBucket")
var HyperFunction = TypeUnit.type("HyperFunction")

var MAX_GROUP_SIZE = 2
var HAND_CARD_RECT_SIZE = Vector2(135, 240)
var HAND_CARD_FRAME_SIZE = Vector2(150, 270)
var HAND_CARD_MARK_RECT_SIZE = Vector2(150, 24)
var CHARACTER_CARD_RECT_SIZE = Vector2(180, 320)
var CHARACTER_CARD_FRAME_SIZE = Vector2(210, 360)
var CHARACTER_MARK_RECT_SIZE = Vector2(210, 40)
var CARD_STATE_RECT_SIZE = Vector2(360, 540)
var VIEW_RECT_SIZE = Vector2(600, 600)
var ATTR_RECT_SIZE = Vector2(270, 560)
var ATTR_ENTRY_XMARGIN = 5
var ATTR_ENTRY_YMARGIN = 20
var ATTR_ENTRY_HEAD_SIZE = Vector2(120, 40)
var ATTR_ENTRY_CONTENT_SIZE = Vector2(140, 40)
var ATTR_BUTTON_SIZE = Vector2(80, 40)
var INTRODUCTION_RECT_SIZE = Vector2(270, 560)
var INTRODUCTION_TEXT_SIZE = Vector2(250, 540)
var CHOOSE_MOVE_GAP = 50
var HAND_CARDS_UPPER = 10

var own_character_team			# Array
var enemy_character_team		# Array
var order_bucket				# Character_PollingBucket
var own_team_function			# Function
var enemy_team_function			# Function
var draw_num_function			# Function
var is_dead_condition			# Function
var is_victory_condition		# Function
var is_fail_condition			# Function

var before_round_function		# HyperFunction
var after_round_function		# HyperFunction
var sub_menu_function			# HyperFunction
var victory_function			# HyperFunction
var fail_function				# HyperFunction

var action_character			# CharacterCard
var chosen_hand_card			# SkillCard

func _init():
	own_character_team = []
	enemy_character_team = []
	order_bucket = PollingBucket.new()
	order_bucket.setParamType("LinearCharacterCard")
	own_team_function = null
	enemy_team_function = null
	draw_num_function = null
	is_dead_condition = null
	is_victory_condition = null
	victory_function = null
	is_fail_condition = null
	fail_function = null
	sub_menu_function = null
	action_character = null
	chosen_hand_card = null

# const
func getHandCardsUpper():
	return HAND_CARDS_UPPER

func getHandCardRectSize():
	return HAND_CARD_RECT_SIZE

func getHandCardFrameSize():
	return HAND_CARD_FRAME_SIZE

func getCharacterCardRectSize():
	return CHARACTER_CARD_RECT_SIZE

func getCharacterCardFrameSize():
	return CHARACTER_CARD_FRAME_SIZE

func getCharacterMarkRectSize():
	return CHARACTER_MARK_RECT_SIZE

func getHandCardMarkRectSize():
	return HAND_CARD_MARK_RECT_SIZE

func getAttrRectSize():
	return ATTR_RECT_SIZE

func getAttrEntryHeadSize():
	return ATTR_ENTRY_HEAD_SIZE

func getAttrEntryContentSize():
	return ATTR_ENTRY_CONTENT_SIZE

func getAttrEntryXMargin():
	return ATTR_ENTRY_XMARGIN

func getAttrEntryYMargin():
	return ATTR_ENTRY_YMARGIN

func getAttrButtonSize():
	return ATTR_BUTTON_SIZE

func getViewRectSize():
	return VIEW_RECT_SIZE

func getIntroductionRectSize():
	return INTRODUCTION_RECT_SIZE

func getIntroductionTextSize():
	return INTRODUCTION_TEXT_SIZE

func getCardStateRectSize():
	return CARD_STATE_RECT_SIZE

func getChooseMoveGap():
	return CHOOSE_MOVE_GAP

func getCardAttrListSize():
	return int(ATTR_RECT_SIZE[1] / ATTR_ENTRY_HEAD_SIZE[1] - 2)

# own_character_team
func getOwnCharacterTeam():
	return own_character_team

func getOwnCharacterNum():
	return own_character_team.size()

func getOwnCharacterByName(card_name):
	for character_card in own_character_team:
		if character_card.getCardName() == card_name:
			return character_card

	return null

func setOwnCharacterTeam(own_character_team_):
	Logger.assert(own_character_team.size() <= MAX_GROUP_SIZE, "own_character_team's card num exceed limit!")

	own_character_team = own_character_team_

# enemy_character_team
func getEnemyCharacterTeam():
	return enemy_character_team

func getEnemyCharacterNum():
	return enemy_character_team.size()

func getEnemyCharacterByName(card_name):
	for character_card in enemy_character_team:
		if character_card.getCardName() == card_name:
			return character_card
	
	return null

func setEnemyCharacterTeam(enemy_character_team_):
	Logger.assert(own_character_team.size() <= MAX_GROUP_SIZE, "own_character_team's card num exceed limit!")

	enemy_character_team = enemy_character_team_

func getCharacterByName(card_name):
	var ret = getOwnCharacterByName(card_name)
	if ret != null:
		return ret

	ret = getEnemyCharacterByName(card_name)

	if ret != null:
		return ret
	
	return null

# order_bucket
func getOrderBucket():
	return order_bucket

func orderBucketAdd(card):
	order_bucket.append(card.getCardName(), card)

func orderBucketWalk():
	order_bucket.walk()

func orderBucketDel(card_name):
	order_bucket.del(card_name)

func setOrderBucket(order_bucket_):
	order_bucket = order_bucket_

func setBucketInitShuffleFunction(function_):
	order_bucket.setInitShuffleFunction(function_)

func setBucketRegularShuffleFunction(function_):
	order_bucket.setRegularShuffleFunction(function_)

# own_team_function
func deployOwnTeam():
	own_character_team = own_team_function.exec([])
	for character in own_character_team:
		var cards = character.initCardPileFunction()
		for card in cards:
			character.pushCardPileFront(card)

func setOwnTeamFunction(own_team_function_):
	own_team_function = own_team_function_

# enemy_team_function
func deployEnemyTeam():
	enemy_character_team = enemy_team_function.exec([])
	for character in enemy_character_team:
		var cards = character.initCardPileFunction()
		for card in cards:
			character.pushCardPileFront(card)

func setEnemyTeamFunction(enemy_team_function_):
	enemy_team_function = enemy_team_function_

# action_character
func getActionCharacter():
	return action_character

func getActionHandCards():
	return action_character.peekHandCards()

func getActionCharacterName():
	return action_character.getCardName()

func setActionCharacter(action_character_):
	action_character = action_character_

func resetActionCharacter():
	action_character = null

# draw_num_function
func getDrawNum(scene_name):
	return draw_num_function.exec([action_character, scene_name])

func setDrawNumFunction(draw_num_function_):
	draw_num_function = draw_num_function_

# is_dead_condition
func isDeadCondition(card, scene_name):
	return is_dead_condition.exec([card, scene_name])

func setIsDeadCondition(is_dead_condition_):
	is_dead_condition = is_dead_condition_

# before_round_function
func beforeRoundFunction(card, scene_name):
	return before_round_function.exec([card, scene_name])

func setBeforeRoundFunction(before_round_function_):
	before_round_function = before_round_function_

# after_round_function
func afterRoundFunction(card, scene_name):
	return after_round_function.exec([card, scene_name])

func setAfterRoundFunction(after_round_function_):
	after_round_function = after_round_function_

# is_victory_condition
func isVictoryCondition(scene_name):
	return is_victory_condition.exec([scene_name])

func setIsVictoryCondition(is_victory_condition_):
	is_victory_condition = is_victory_condition_ 

# victory_function
func victoryFunction(scene_ref):
	victory_function.exec([scene_ref])

func setVictoryFunction(victory_function_):
	victory_function = victory_function_

# is_fail_condition
func isFailCondition(scene_ref):
	return is_fail_condition.exec([scene_ref])

func setIsFailCondition(is_fail_condition_):
	is_fail_condition = is_fail_condition_ 

# fail_function
func failFunction(scene_ref):
	fail_function.exec([scene_ref])

func setFailFunction(fail_function_):
	fail_function = fail_function_

# sub_menu_function
func subMenuFunction(scene_ref):
	sub_menu_function.exec([scene_ref])

func setSubMenuFunction(sub_menu_function_):
	sub_menu_function = sub_menu_function_
	
# chosen_hand_card
func getChosenHandCard():
	return chosen_hand_card

func getChosenHandCardName():
	return chosen_hand_card.getCardName()

func setChosenHandCardByName(card_name):
	var hand_cards = action_character.peekHandCards()
	for hand_card in hand_cards:
		if hand_card.getCardName() == card_name:
			chosen_hand_card = hand_card
			return
	
	Logger.assert(false, "Action Character doesn't have the \"" + card_name + "\"!")

func resetChosenHandCard():
	chosen_hand_card = null

func getActionHandCardByName(card_name):
	var hand_cards = action_character.peekHandCards()
	for hand_card in hand_cards:
		if hand_card.getCardName() == card_name:
			return hand_card
	
	return null

func pack():
	var script_tree = ScriptTree.new()

	script_tree.addTypeObject("order_bucket", order_bucket)
	script_tree.addObject("own_team_function", own_team_function)
	script_tree.addObject("enemy_team_function", enemy_team_function)
	script_tree.addObject("draw_num_function", draw_num_function)
	script_tree.addObject("is_dead_condition", is_dead_condition)
	script_tree.addObject("is_victory_condition", is_victory_condition)
	script_tree.addObject("is_fail_condition", is_fail_condition)
	script_tree.addObject("before_round_function", before_round_function)
	script_tree.addObject("after_round_function", after_round_function)
	script_tree.addObject("victory_function", victory_function)
	script_tree.addObject("fail_function", fail_function)
	script_tree.addObject("sub_menu_function", sub_menu_function)

	return script_tree

func loadScript(script_tree):
	order_bucket = script_tree.getTypeObject("order_bucket", PollingBucket, LinearCharacterCard)
	own_team_function = script_tree.getObject("own_team_function", Function)
	enemy_team_function = script_tree.getObject("enemy_team_function", Function)
	draw_num_function = script_tree.getObject("draw_num_function", Function)
	is_dead_condition = script_tree.getObject("is_dead_condition", Function)
	is_victory_condition = script_tree.getObject("is_victory_condition", Function)
	is_fail_condition = script_tree.getObject("is_fail_condition", Function)

	before_round_function = script_tree.getObject("before_round_function", HyperFunction)
	after_round_function = script_tree.getObject("after_round_function", HyperFunction)
	victory_function = script_tree.getObject("victory_function", HyperFunction)
	fail_function = script_tree.getObject("fail_function", HyperFunction)
	sub_menu_function = script_tree.getObject("sub_menu_function", HyperFunction)
