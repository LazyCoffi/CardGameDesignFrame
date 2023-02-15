extends "res://class/entity/CharacterCard.gd"
class_name LinearCharacterCard

var CardPile = TypeUnit.type("CardPile")
var LinearSkillCard = TypeUnit.type("LinearSkillCard")

var card_pile 					# CardPile
var ai_is_action_condition		# Function
var ai_choose_target_function	# Function
var ai_choose_card_function		# Function

func _init():
	hand_card_slot.setParamType(LinearSkillCard)
	card_pile = CardPile.new()
	card_pile.setParamType(LinearSkillCard)

	ai_is_action_condition = null
	ai_choose_card_function = null
	ai_choose_target_function = null

func copy():
	var ret = TypeUnit.type("LinearCharacterCard").new()

	ret.card_name = card_name
	ret.avator_name = avator_name
	ret.introduction = introduction
	ret.template_name = template_name
	ret.card_attr = card_attr.copy()

	ret.equipment_set = {}
	for key in equipment_set.keys():
		ret.equipment_set[key] = equipment_set[key].copy()
	ret.buff_set = {}
	for key in buff_set:
		ret.buff_set[key] = buff_set[key].copy()

	ret.card_pile = card_pile.copy() 
	ret.ai_is_action_condition = ai_is_action_condition.copy()
	ret.ai_choose_card_function = ai_choose_card_function.copy()
	ret.ai_choose_target_function = ai_choose_target_function.copy()

	return ret

# card_pile
func peekCardPile():
	return card_pile.getCardPile()

func peekTrashPile():
	return card_pile.getTrashPile()

func pileRandomOn():
	card_pile.randomOn()

func pileRandomOff():
	card_pile.randomOff()

func pushCardPileFront(card):
	card_pile.pushFront(card)

func pushCardPileBack(card):
	card_pile.pushBack(card)

func pushTrashPileFront(card):
	card_pile.pushTrashFront(card)

func pushTrashPileBack(card):
	card_pile.pushTrashBack(card)

func shufflePile():
	card_pile.shufflePile()

func shuffleTrash():
	card_pile.shuffleTrash()

func getCardPile():
	return card_pile

# ai_is_action_condition
func aiIsActionCondition(scene_name):
	return ai_is_action_condition.exec([self, scene_name])

func setAiIsActionCondition(ai_is_action_condition_):
	ai_is_action_condition = ai_is_action_condition_

# ai_choose_card_function
func aiChooseCardFunction(scene_name):
	return ai_choose_card_function.exec([self, scene_name])

func setAiChooseCardFunction(ai_choose_card_function_):
	 ai_choose_card_function = ai_choose_card_function_

# ai_choose_target_function
func aiChooseTargetFunction(scene_name):
	return ai_choose_target_function.exec([self, scene_name])

func setAiChooseTargetFunction(ai_choose_target_function_):
	ai_choose_target_function = ai_choose_target_function_

func pack():
	var script_tree = .pack()

	script_tree.addTypeObject("hand_card_slot", hand_card_slot)
	script_tree.addTypeObject("card_pile", card_pile)
	script_tree.addObject("ai_is_action_condition", ai_is_action_condition)
	script_tree.addObject("ai_choose_card_function", ai_choose_card_function)
	script_tree.addObject("ai_choose_target_function", ai_choose_target_function)

	return script_tree

func loadScript(script_tree):
	.loadScript(script_tree)
	hand_card_slot = script_tree.getTypeObject("hand_card_slot", HandCardSlot, LinearSkillCard)
	card_pile = script_tree.getTypeObject("card_pile", CardPile, LinearSkillCard)
	ai_is_action_condition = script_tree.getObject("ai_is_action_condition", Function)
	ai_choose_card_function = script_tree.getObject("ai_choose_card_function", Function)
	ai_choose_target_function = script_tree.getObject("ai_choose_target_function", Function)

