extends GutTest

var LinearCharacterCard = TypeUnit.type("LinearCharacterCard")
var LinearSkillCard = TypeUnit.type("LinearSkillCard")
var Attr = TypeUnit.type("Attr")
var HyperFunction = TypeUnit.type("HyperFunction")
var Function = TypeUnit.type("Function")
var FuncGraph = TypeUnit.type("FuncGraph")
var FuncUnit = TypeUnit.type("FuncUnit")
var ParamList = TypeUnit.type("ParamList")
var NullPack = TypeUnit.type("NullPack")
var Integer = TypeUnit.type("Integer")
var FuncGraphNode = TypeUnit.type("FuncGraphNode")
var StringPack = TypeUnit.type("StringPack")
var CardTemplate = TypeUnit.type("CardTemplate")
var AnimationPack = TypeUnit.type("AnimationPack")
var AudioPack = TypeUnit.type("AudioPack")

func before_all():
	GlobalSetting.initScript()
	ResourceUnit.initScript()

func __buildHpGetterFunction():
	var getter_param_node = ParamNode.new()
	getter_param_node.setParamType("NullPack")
	getter_param_node.setParam(NullPack.new())

	var getter_default_params = ParamList.new()
	getter_default_params.addParam(getter_param_node)

	var getter_func_unit = FuncUnit.new()
	getter_func_unit.setFuncSetName("BaseFuncSet")
	getter_func_unit.setFuncName("returnVal")
	getter_func_unit.setDefaultParams(getter_default_params)

	var graph = FuncGraph.new()
	var getter_node = FuncGraphNode.new()
	getter_node.setFuncUnit(getter_func_unit)
	getter_node.setChIndexList([null])
	graph.addNode(getter_node)
	graph.construct()
	
	var getter_function = Function.new()
	getter_function.setGraph(graph)
	getter_function.setMap({"returnVal_0_0" : 0})

	return getter_function

func __buildHpSetterFunction():
	var lower_null_param_node = ParamNode.new()
	lower_null_param_node.setParamType("NullPack")
	lower_null_param_node.setParam(NullPack.new())

	var lower_param_node = ParamNode.new()
	lower_param_node.setParamType("Integer")
	var lower_integer = Integer.new()
	lower_integer.setVal(0)
	lower_param_node.setParam(lower_integer)

	var lower_param_list = ParamList.new()
	lower_param_list.addParam(lower_null_param_node)
	lower_param_list.addParam(lower_param_node)

	var lower_func_unit = FuncUnit.new()
	lower_func_unit.setFuncSetName("MathFuncSet")
	lower_func_unit.setFuncName("lowerBoundInt")
	lower_func_unit.setDefaultParams(lower_param_list)

	var upper_null_param_node = ParamNode.new()
	upper_null_param_node.setParamType("NullPack")
	upper_null_param_node.setParam(NullPack.new())

	var upper_param_node = ParamNode.new()
	upper_param_node.setParamType("Integer")
	var upper_integer = Integer.new()
	upper_integer.setVal(100)
	upper_param_node.setParam(upper_integer)

	var upper_param_list = ParamList.new()
	upper_param_list.addParam(upper_null_param_node)
	upper_param_list.addParam(upper_param_node)

	var upper_func_unit = FuncUnit.new()
	upper_func_unit.setFuncSetName("MathFuncSet")
	upper_func_unit.setFuncName("upperBoundInt")
	upper_func_unit.setDefaultParams(upper_param_list)

	var graph = FuncGraph.new()

	var lower_node = FuncGraphNode.new()
	lower_node.setFuncUnit(lower_func_unit)
	lower_node.setChIndexList([1, null])

	var upper_node = FuncGraphNode.new()
	upper_node.setFuncUnit(upper_func_unit)
	upper_node.setChIndexList([null, null])

	graph.addNode(lower_node)
	graph.addNode(upper_node)
	graph.construct()

	var setter_function = Function.new()
	setter_function.setGraph(graph)
	setter_function.setMap({"upperBoundInt_1_0" : 0})

	return setter_function

func __buildStgFunction():
	var null_param_node = ParamNode.new()
	null_param_node.setParamType("NullPack")
	null_param_node.setParam(NullPack.new())

	var param_list = ParamList.new()
	param_list.addParam(null_param_node)

	var func_unit = FuncUnit.new()
	func_unit.setFuncSetName("BaseFuncSet")
	func_unit.setFuncName("returnVal")
	func_unit.setDefaultParams(param_list)

	var graph = FuncGraph.new()
	var node = FuncGraphNode.new()
	node.setFuncUnit(func_unit)
	node.setChIndexList([null])
	graph.addNode(node)
	graph.construct()
	
	var function = Function.new()
	function.setGraph(graph)
	function.setMap({"returnVal_0_0" : 0})

	return function

func __addBattleCharacterAttr(card):
	var attr = Attr.new()

	var hp_getter_function = __buildHpGetterFunction()
	var hp_setter_function = __buildHpSetterFunction()
	attr.addAttr("hp", "Integer", hp_getter_function, hp_setter_function)

	var stg_getter_function = __buildStgFunction()
	var stg_setter_function = __buildStgFunction()
	attr.addAttr("stg", "Integer", stg_getter_function, stg_setter_function)
	attr.addAttr("stg1", "Integer", stg_getter_function, stg_setter_function)
	attr.addAttr("stg2", "Integer", stg_getter_function, stg_setter_function)
	attr.addAttr("stg3", "Integer", stg_getter_function, stg_setter_function)
	attr.addAttr("stg4", "Integer", stg_getter_function, stg_setter_function)
	attr.addAttr("stg5", "Integer", stg_getter_function, stg_setter_function)
	attr.addAttr("stg6", "Integer", stg_getter_function, stg_setter_function)
	attr.addAttr("stg7", "Integer", stg_getter_function, stg_setter_function)
	attr.addAttr("stg8", "Integer", stg_getter_function, stg_setter_function)
	attr.addAttr("stg9", "Integer", stg_getter_function, stg_setter_function)
	attr.addAttr("stg10", "Integer", stg_getter_function, stg_setter_function)
	attr.addAttr("stg11", "Integer", stg_getter_function, stg_setter_function)
	attr.addAttr("stg12", "Integer", stg_getter_function, stg_setter_function)

	card.setCardAttr(attr)

func __buildTrueCondition():
	var param_list = ParamList.new()

	var true_unit = FuncUnit.new()
	true_unit.setFuncSetName("BaseConditionSet")
	true_unit.setFuncName("trueGate")
	true_unit.setDefaultParams(param_list)

	var graph = FuncGraph.new()
	var true_node = FuncGraphNode.new()

	true_node.setFuncUnit(true_unit)
	true_node.setChIndexList([])

	graph.addNode(true_node)
	graph.construct()

	var true_condition = Function.new()	
	true_condition.setGraph(graph)
	true_condition.setMap({})

	return true_condition

func __buildFalseCondition():
	var param_list = ParamList.new()

	var false_unit = FuncUnit.new()
	false_unit.setFuncSetName("BaseConditionSet")
	false_unit.setFuncName("falseGate")
	false_unit.setDefaultParams(param_list)

	var graph = FuncGraph.new()
	var false_node = FuncGraphNode.new()

	false_node.setFuncUnit(false_unit)
	false_node.setChIndexList([])

	graph.addNode(false_node)
	graph.construct()

	var false_condition = Function.new()	
	false_condition.setGraph(graph)
	false_condition.setMap({})

	return false_condition

func __buildExtractFuncUnit():
	var param_node = ParamNode.new()
	param_node.setParamType("NullPack")
	param_node.setParam(NullPack.new())
	var param_list = ParamList.new()
	param_list.addParam(param_node)

	var extract_func_unit = FuncUnit.new()
	extract_func_unit.setFuncSetName("CardFuncSet")
	extract_func_unit.setFuncName("extractAttr")
	extract_func_unit.setDefaultParams(param_list)

	return extract_func_unit

func __buildAttackHyperFunction():
	var attack_node = FuncGraphNode.new()
	attack_node.setFunc("AttrFuncSet", "minusAttrIntOverride")

	var string_pack1 = StringPack.new()
	string_pack1.setVal("hp")
	attack_node.setDefaultParam("StringPack", string_pack1, 1)

	var string_pack2 = StringPack.new()
	string_pack2.setVal("stg")
	attack_node.setDefaultParam("StringPack", string_pack2, 3)
	attack_node.setChIndex(1, 0)
	attack_node.setChIndex(2, 2)

	var extract_func_unit1 = __buildExtractFuncUnit()
	var extract_func_unit2 = __buildExtractFuncUnit()

	var graph = FuncGraph.new()

	var extract_node1 = FuncGraphNode.new()
	extract_node1.setFuncUnit(extract_func_unit1)
	extract_node1.setChIndexList([null])

	var extract_node2 = FuncGraphNode.new()
	extract_node2.setFuncUnit(extract_func_unit2)
	extract_node2.setChIndexList([null])

	graph.addNode(attack_node)
	graph.addNode(extract_node1)
	graph.addNode(extract_node2)
	graph.construct()

	var attack_function = Function.new()
	attack_function.setGraph(graph)
	attack_function.setMap({"extractAttr_1_0" : 0, "extractAttr_2_0" : 1})

	var attack_hyper = HyperFunction.new()
	attack_hyper.addFunction(attack_function)
	attack_hyper.setParamMapIndex(0, 1)
	attack_hyper.setParamMapIndex(1, 2)

	return attack_hyper

func __buildAnimationPack():
	var animation_pack = AnimationPack.new()

	animation_pack.addTexturePath("res://asserts/animation/crop/crop1.png")
	animation_pack.addTexturePath("res://asserts/animation/crop/crop2.png")
	animation_pack.addTexturePath("res://asserts/animation/crop/crop3.png")

	animation_pack.setGap(3)

	return animation_pack

func __buildAudioPack():
	var audio_pack = AudioPack.new()

	audio_pack.setAudioPath("res://asserts/audio/crop.mp3")
	
	return audio_pack

func __buildAttackSkillCard():
	var card = LinearSkillCard.new()
	card.setOffensive()
	card.setPlayCondition(__buildTrueCondition())
	card.setTargetCondition(__buildTrueCondition())
	card.setAnimationPack(__buildAnimationPack())
	card.setAudioPack(__buildAudioPack())
	card.setAutoCondition(__buildFalseCondition())
	card.setEffectFunc(__buildAttackHyperFunction())
	card.setIntroduction("Attack!")
	card.setAvatorName("attack_card")
	card.setOffensive()

	return card

func __buildAiIsActionCondition():
	var not_node = FuncGraphNode.new()
	not_node.setFunc("BaseConditionSet", "notGate")
	not_node.setChIndex(1, 0)

	var action_node = FuncGraphNode.new()
	action_node.setFunc("CharacterCardConditionSet", "isHandCardsEmpty")

	var graph = FuncGraph.new()
	graph.addNode(not_node)
	graph.addNode(action_node)
	graph.construct()
	
	var ai_is_action_condition = Function.new()
	ai_is_action_condition.setGraph(graph)
	ai_is_action_condition.setMap({"isHandCardsEmpty_1_0" : 0})

	return ai_is_action_condition

func __buildAiChooseTargetFunction():
	var oppostie_node = FuncGraphNode.new()
	oppostie_node.setFunc("LinearBattleFuncSet", "getOppositeTeam")

	var get_param_node = FuncGraphNode.new()
	get_param_node.setFunc("ArrayOperFuncSet", "getFront")
	get_param_node.setChIndex(1, 0)

	var graph = FuncGraph.new()
	graph.addNode(get_param_node)
	graph.addNode(oppostie_node)
	graph.construct()

	var ai_choose_target_function = Function.new()
	ai_choose_target_function.setGraph(graph)
	ai_choose_target_function.setMap(
		{
			"getOppositeTeam_1_1" : 0,
			"getOppositeTeam_1_0" : 1
		}
	)

	return ai_choose_target_function

func __buildAiChooseCardFunction():
	var peek_node = FuncGraphNode.new()
	peek_node.setFunc("CharacterCardFuncSet", "peekHandCards")

	var get_node = FuncGraphNode.new()
	get_node.setFunc("ArrayOperFuncSet", "getFront")
	get_node.setChIndex(1, 0)

	var graph = FuncGraph.new()

	graph.addNode(get_node)
	graph.addNode(peek_node)
	graph.construct()

	var ai_choose_card_function = Function.new()
	ai_choose_card_function.setGraph(graph)
	ai_choose_card_function.setMap({"peekHandCards_1_0" : 0})

	return ai_choose_card_function

func __buildInitCardPileFunction():
	var get_node1 = FuncGraphNode.new()
	get_node1.setFunc("CardFuncSet", "createCardWithDefaultName")
	var string_pack1 = StringPack.new()
	string_pack1.setVal("AttackSkillCard")
	get_node1.setDefaultParam("StringPack", string_pack1, 0)
	
	var get_node2 = FuncGraphNode.new()
	get_node2.setFunc("CardFuncSet", "createCardWithDefaultName")
	var string_pack2 = StringPack.new()
	string_pack2.setVal("AttackSkillCard")
	get_node2.setDefaultParam("StringPack", string_pack2, 0)

	var pack_node = FuncGraphNode.new()	
	pack_node.setFunc("ArrayOperFuncSet", "packArray")
	
	var append_node = FuncGraphNode.new()
	append_node.setFunc("ArrayOperFuncSet", "appendVal")

	var init_graph = FuncGraph.new()
	init_graph.addNode(append_node)
	init_graph.addNode(pack_node)
	init_graph.addNode(get_node1)
	init_graph.addNode(get_node2)

	append_node.setChIndex(1, 0)
	append_node.setChIndex(3, 1)
	pack_node.setChIndex(2, 0)

	init_graph.construct()

	var init_function = Function.new()
	init_function.setGraph(init_graph)

	return init_function

func __buildMainCharacterCard():
	var card = LinearCharacterCard.new()
	card.setTemplateName("MainCharacterCard")
	card.setAvatorName("main_character")
	card.setIntroduction("Main character card.")
	
	__addBattleCharacterAttr(card)
	card.setAttr("hp", 100)
	card.setAttr("stg", 25)
	card.setAttr("stg1", 25)
	card.setAttr("stg2", 25)
	card.setAttr("stg3", 25)
	card.setAttr("stg4", 25)
	card.setAttr("stg5", 25)
	card.setAttr("stg6", 25)
	card.setAttr("stg7", 25)
	card.setAttr("stg8", 25)
	card.setAttr("stg9", 25)
	card.setAttr("stg10", 25)
	card.setAttr("stg11", 25)
	card.setAttr("stg12", 25)

	card.setInitCardPileFunction(__buildInitCardPileFunction())
	card.setAiIsActionCondition(__buildFalseCondition())
	card.setAiChooseCardFunction(__buildFalseCondition())
	card.setAiChooseTargetFunction(__buildFalseCondition())
	
	return card

func __buildEnemyCharacterCard():
	var card = LinearCharacterCard.new()
	card.setTemplateName("EnemyCharacterCard")
	card.setAvatorName("enemy_character")
	card.setIntroduction("Enemy character card.")
	
	__addBattleCharacterAttr(card)
	card.setAttr("hp", 50)
	card.setAttr("stg", 50)
	card.setAttr("stg1", 25)
	card.setAttr("stg2", 25)
	card.setAttr("stg3", 25)
	card.setAttr("stg4", 25)
	card.setAttr("stg5", 25)
	card.setAttr("stg6", 25)
	card.setAttr("stg7", 25)
	card.setAttr("stg8", 25)
	card.setAttr("stg9", 25)
	card.setAttr("stg10", 25)
	card.setAttr("stg11", 25)
	card.setAttr("stg12", 25)
	card.setInitCardPileFunction(__buildInitCardPileFunction())
	card.setAiIsActionCondition(__buildAiIsActionCondition())
	card.setAiChooseCardFunction(__buildAiChooseCardFunction())
	card.setAiChooseTargetFunction(__buildAiChooseTargetFunction())
	
	return card

func __buildReviseFunction():
	var param_node = ParamNode.new()
	param_node.setParamType("NullPack")
	param_node.setParam(NullPack.new())

	var param_list = ParamList.new()
	param_list.addParam(param_node)

	var revise_func_unit = FuncUnit.new()
	revise_func_unit.setFuncSetName("BaseFuncSet")
	revise_func_unit.setFuncName("returnVal")
	revise_func_unit.setDefaultParams(param_list)

	var graph = FuncGraph.new()

	var revise_node = FuncGraphNode.new()
	revise_node.setFuncUnit(revise_func_unit)
	revise_node.setChIndexList([null])

	graph.addNode(revise_node)
	graph.construct()

	var revise_function = Function.new()
	revise_function.setGraph(graph)
	revise_function.setMap({"returnVal_0_0" : 0})

	return revise_function

func __buildAttackCardTemplate():
	var attack_card = __buildAttackSkillCard()
	var attack_card_template = CardTemplate.new()
	attack_card_template.setTemplateName("AttackSkillCard")
	attack_card_template.setCardType("LinearSkillCard")
	attack_card_template.setCardTemplate(attack_card)
	attack_card_template.setReviseFunction(__buildReviseFunction())

	return attack_card_template

func __buildMainCharacterTemplate():
	var main_character_card = __buildMainCharacterCard()
	var main_character_template = CardTemplate.new()
	main_character_template.setTemplateName("MainCharacterCard")
	main_character_template.setCardType("LinearCharacterCard")
	main_character_template.setCardTemplate(main_character_card)
	main_character_template.setReviseFunction(__buildReviseFunction())

	return main_character_template

func __buildEnemyCharacterTemplate():
	var enemy_character_card = __buildEnemyCharacterCard()
	var enemy_character_template = CardTemplate.new()
	enemy_character_template.setTemplateName("EnemyCharacterCard")
	enemy_character_template.setCardType("LinearCharacterCard")
	enemy_character_template.setCardTemplate(enemy_character_card)
	enemy_character_template.setReviseFunction(__buildReviseFunction())

	return enemy_character_template

func __buildPlayCondition():
	var ap_pack = StringPack.new()
	ap_pack.setVal("行动点")

	var ap_cosm_pack = StringPack.new()
	ap_cosm_pack.setVal("消耗行动点")

	var extract_self_node = FuncGraphNode.new()
	extract_self_node.setFunc("CardFuncSet", "extractAttr")

	var extract_ch_node = FuncGraphNode.new()
	extract_ch_node.setFunc("CardFuncSet", "extractAttr")

	var is_le_node = FuncGraphNode.new()
	is_le_node.setFunc("AttrConditionSet", "isAttrLessEqualInt")

	is_le_node.setDefaultParam("StringPack", ap_cosm_pack, 1)
	is_le_node.setDefaultParam("StringPack", ap_pack, 3)

	var graph = FuncGraph.new()
	graph.addNode(is_le_node)
	graph.addNode(extract_self_node)
	graph.addNode(extract_ch_node)

	is_le_node.setChIndex(1, 0)
	is_le_node.setChIndex(2, 2)

	graph.construct()

	var condition = Function.new()
	condition.setGraph(graph)

	return condition

func __buildEnemyTargetCondition():
	var target_node = FuncGraphNode.new()	
	target_node.setFunc("LinearBattleConditionSet", "isCardEnemyTeam")
	
	var graph = FuncGraph.new()
	graph.addNode(target_node)
	graph.construct()

	var target_condition = Function.new()
	target_condition.setGraph(graph)

	return target_condition

func __buildCropAnimation():
	var animation_pack = AnimationPack.new()

	animation_pack.addTexturePath("res://asserts/animation/crop/crop1.png")
	animation_pack.addTexturePath("res://asserts/animation/crop/crop2.png")
	animation_pack.addTexturePath("res://asserts/animation/crop/crop3.png")

	animation_pack.setGap(3)

	return animation_pack

func __buildCropAudio():
	var audio_pack = AudioPack.new()

	audio_pack.setAudioPath("res://asserts/audio/crop.mp3")
	
	return audio_pack

func __buildCropHyperFunction():
	var extract_atk_node = FuncGraphNode.new()
	extract_atk_node.setFunc("CardFuncSet", "extractAttr")

	var extract_hp_node = FuncGraphNode.new()
	extract_hp_node.setFunc("CardFuncSet", "extractAttr")

	var extract_arm_node = FuncGraphNode.new()
	extract_arm_node.setFunc("CardFuncSet", "extractAttr")

	var sub_hp_node = FuncGraphNode.new()
	sub_hp_node.setFunc("AttrFuncSet", "minusAttrWithAttrBeforeInt")

	var atk_pack = StringPack.new()
	atk_pack.setVal("物理攻击")

	var hp_pack = StringPack.new()
	hp_pack.setVal("健康值")

	var arm_pack = StringPack.new()
	arm_pack.setVal("物理护甲")

	sub_hp_node.setDefaultParam("StringPack", hp_pack, 1)
	sub_hp_node.setDefaultParam("StringPack", arm_pack, 3)
	sub_hp_node.setDefaultParam("StringPack", atk_pack, 5)

	var graph = FuncGraph.new()
	graph.addNode(sub_hp_node)
	graph.addNode(extract_hp_node)
	graph.addNode(extract_arm_node)
	graph.addNode(extract_atk_node)

	sub_hp_node.setChIndex(1, 0)
	sub_hp_node.setChIndex(2, 2)
	sub_hp_node.setChIndex(3, 4)

	graph.construct()

	var crop_function = Function.new()
	crop_function.setGraph(graph)

	crop_function.setMapIndex("extractAttr_1_0", 1)
	crop_function.setMapIndex("extractAttr_2_0", 2)
	crop_function.setMapIndex("extractAttr_3_0", 0)

	var extract_ap_node = FuncGraphNode.new()
	extract_ap_node.setFunc("CardFuncSet", "extractAttr")

	var extract_ap_coms_node = FuncGraphNode.new()
	extract_ap_coms_node.setFunc("CardFuncSet", "extractAttr")

	var sub_ap_node = FuncGraphNode.new()
	sub_ap_node.setFunc("AttrFuncSet", "minusAttrIntOverride")

	var ap_pack = StringPack.new()
	ap_pack.setVal("行动点")

	var ap_coms_pack = StringPack.new()
	ap_coms_pack.setVal("消耗行动点")

	sub_ap_node.setDefaultParam("StringPack", ap_pack, 1)
	sub_ap_node.setDefaultParam("StringPack", ap_coms_pack, 3)

	var ap_graph = FuncGraph.new()
	ap_graph.addNode(sub_ap_node)
	ap_graph.addNode(extract_ap_node)
	ap_graph.addNode(extract_ap_coms_node)

	sub_ap_node.setChIndex(1, 0)
	sub_ap_node.setChIndex(2, 2)

	ap_graph.construct()

	var ap_function = Function.new()
	ap_function.setGraph(ap_graph)

	var hyper = HyperFunction.new()
	hyper.addFunction(crop_function)
	hyper.addFunction(ap_function)

	hyper.setParamMapIndex(0, 0)
	hyper.setParamMapIndex(1, 1)
	hyper.setParamMapIndex(2, 1)
	hyper.setParamMapIndex(3, 2)
	hyper.setParamMapIndex(4, 0)

	return hyper

func __buildCropSkillCard():
	var card = LinearSkillCard.new()
	var attr = Attr.new()

	attr.addAttr("物理攻击", "Integer", __dummyGetterSetter(), __dummyGetterSetter())
	attr.addAttr("消耗行动点", "Integer", __dummyGetterSetter(), __dummyGetterSetter())

	card.setCardAttr(attr)

	card.setAttr("物理攻击", 2)
	card.setAttr("消耗行动点", 1)
	card.setOffensive()
	card.setPlayCondition(__buildPlayCondition())
	card.setTargetCondition(__buildEnemyTargetCondition())
	card.setAnimationPack(__buildCropAnimation())
	card.setAudioPack(__buildCropAudio())
	card.setAutoCondition(__buildFalseCondition())
	card.setEffectFunc(__buildCropHyperFunction())
	card.setIntroduction("使用长剑劈砍敌人，造成两点物理伤害")
	card.setAvatorName("crop_card")
	
	return card

func __buildCropCardTemplate():
	var crop_card_template = CardTemplate.new()
	crop_card_template.setTemplateName("CropSkillCard")
	crop_card_template.setCardType("LinearSkillCard")
	crop_card_template.setCardTemplate(__buildCropSkillCard())
	crop_card_template.setReviseFunction(__buildReviseFunction())

	return crop_card_template

func __buildOwnTargetCondition():
	var target_node = FuncGraphNode.new()	
	target_node.setFunc("LinearBattleConditionSet", "isCardOwnTeam")
	
	var graph = FuncGraph.new()
	graph.addNode(target_node)
	graph.construct()

	var target_condition = Function.new()
	target_condition.setGraph(graph)

	return target_condition

func __buildStabHyperFunction():
	var extract_atk_node = FuncGraphNode.new()
	extract_atk_node.setFunc("CardFuncSet", "extractAttr")

	var extract_hp_node = FuncGraphNode.new()
	extract_hp_node.setFunc("CardFuncSet", "extractAttr")

	var extract_arm_node = FuncGraphNode.new()
	extract_arm_node.setFunc("CardFuncSet", "extractAttr")

	var sub_hp_node = FuncGraphNode.new()
	sub_hp_node.setFunc("AttrFuncSet", "minusAttrWithAttrBeforeInt")

	var atk_pack = StringPack.new()
	atk_pack.setVal("物理攻击")

	var hp_pack = StringPack.new()
	hp_pack.setVal("健康值")

	var arm_pack = StringPack.new()
	arm_pack.setVal("物理护甲")

	sub_hp_node.setDefaultParam("StringPack", hp_pack, 1)
	sub_hp_node.setDefaultParam("StringPack", arm_pack, 3)
	sub_hp_node.setDefaultParam("StringPack", atk_pack, 5)

	var graph = FuncGraph.new()
	graph.addNode(sub_hp_node)
	graph.addNode(extract_hp_node)
	graph.addNode(extract_arm_node)
	graph.addNode(extract_atk_node)

	sub_hp_node.setChIndex(1, 0)
	sub_hp_node.setChIndex(2, 2)
	sub_hp_node.setChIndex(3, 4)

	graph.construct()

	var crop_function = Function.new()
	crop_function.setGraph(graph)

	crop_function.setMapIndex("extractAttr_1_0", 1)
	crop_function.setMapIndex("extractAttr_2_0", 2)
	crop_function.setMapIndex("extractAttr_3_0", 0)

	var extract_ap_node = FuncGraphNode.new()
	extract_ap_node.setFunc("CardFuncSet", "extractAttr")

	var extract_ap_coms_node = FuncGraphNode.new()
	extract_ap_coms_node.setFunc("CardFuncSet", "extractAttr")

	var sub_ap_node = FuncGraphNode.new()
	sub_ap_node.setFunc("AttrFuncSet", "minusAttrIntOverride")

	var ap_pack = StringPack.new()
	ap_pack.setVal("行动点")

	var ap_coms_pack = StringPack.new()
	ap_coms_pack.setVal("消耗行动点")

	sub_ap_node.setDefaultParam("StringPack", ap_pack, 1)
	sub_ap_node.setDefaultParam("StringPack", ap_coms_pack, 3)

	var ap_graph = FuncGraph.new()
	ap_graph.addNode(sub_ap_node)
	ap_graph.addNode(extract_ap_node)
	ap_graph.addNode(extract_ap_coms_node)

	sub_ap_node.setChIndex(1, 0)
	sub_ap_node.setChIndex(2, 2)

	ap_graph.construct()

	var ap_function = Function.new()
	ap_function.setGraph(ap_graph)

	var hyper = HyperFunction.new()
	hyper.addFunction(crop_function)
	hyper.addFunction(ap_function)

	hyper.setParamMapIndex(0, 0)
	hyper.setParamMapIndex(1, 1)
	hyper.setParamMapIndex(2, 1)
	hyper.setParamMapIndex(3, 2)
	hyper.setParamMapIndex(4, 0)

	return hyper

func __buildStabAnimation():
	var animation_pack = AnimationPack.new()

	animation_pack.addTexturePath("res://asserts/animation/stab/1.png")
	animation_pack.addTexturePath("res://asserts/animation/stab/2.png")

	animation_pack.setGap(2)

	return animation_pack

func __buildStabAudio():
	var audio_pack = AudioPack.new()

	audio_pack.setAudioPath("res://asserts/audio/crop.mp3")
	
	return audio_pack

func __buildStabSkillCard():
	var card = LinearSkillCard.new()
	
	var attr = Attr.new()

	attr.addAttr("物理攻击", "Integer", __dummyGetterSetter(), __dummyGetterSetter())
	attr.addAttr("消耗行动点", "Integer", __dummyGetterSetter(), __dummyGetterSetter())

	card.setCardAttr(attr)
	card.setAttr("物理攻击", 1)
	card.setAttr("消耗行动点", 1)
	card.setOffensive()
	card.setPlayCondition(__buildTrueCondition())
	card.setTargetCondition(__buildOwnTargetCondition())
	card.setAnimationPack(__buildStabAnimation())
	card.setAudioPack(__buildStabAudio())
	card.setAutoCondition(__buildFalseCondition())
	card.setEffectFunc(__buildStabHyperFunction())
	card.setIntroduction("使用匕首劈砍敌人，造成一点物理伤害")
	card.setAvatorName("stab_card")
	
	return card

func __buildStabCardTemplate():
	var stab_card_template = CardTemplate.new()
	stab_card_template.setTemplateName("StabSkillCard")
	stab_card_template.setCardType("LinearSkillCard")
	stab_card_template.setCardTemplate(__buildStabSkillCard())
	stab_card_template.setReviseFunction(__buildReviseFunction())

	return stab_card_template

func __buildSlashHyperFunction():
	var extract_atk_node = FuncGraphNode.new()
	extract_atk_node.setFunc("CardFuncSet", "extractAttr")

	var extract_hp_node = FuncGraphNode.new()
	extract_hp_node.setFunc("CardFuncSet", "extractAttr")

	var extract_arm_node = FuncGraphNode.new()
	extract_arm_node.setFunc("CardFuncSet", "extractAttr")

	var sub_hp_node = FuncGraphNode.new()
	sub_hp_node.setFunc("AttrFuncSet", "minusAttrWithAttrBeforeInt")

	var atk_pack = StringPack.new()
	atk_pack.setVal("物理攻击")

	var hp_pack = StringPack.new()
	hp_pack.setVal("健康值")

	var arm_pack = StringPack.new()
	arm_pack.setVal("物理护甲")

	sub_hp_node.setDefaultParam("StringPack", hp_pack, 1)
	sub_hp_node.setDefaultParam("StringPack", arm_pack, 3)
	sub_hp_node.setDefaultParam("StringPack", atk_pack, 5)

	var graph = FuncGraph.new()
	graph.addNode(sub_hp_node)
	graph.addNode(extract_hp_node)
	graph.addNode(extract_arm_node)
	graph.addNode(extract_atk_node)

	sub_hp_node.setChIndex(1, 0)
	sub_hp_node.setChIndex(2, 2)
	sub_hp_node.setChIndex(3, 4)

	graph.construct()

	var crop_function = Function.new()
	crop_function.setGraph(graph)

	crop_function.setMapIndex("extractAttr_1_0", 1)
	crop_function.setMapIndex("extractAttr_2_0", 2)
	crop_function.setMapIndex("extractAttr_3_0", 0)

	var extract_ap_node = FuncGraphNode.new()
	extract_ap_node.setFunc("CardFuncSet", "extractAttr")

	var extract_ap_coms_node = FuncGraphNode.new()
	extract_ap_coms_node.setFunc("CardFuncSet", "extractAttr")

	var sub_ap_node = FuncGraphNode.new()
	sub_ap_node.setFunc("AttrFuncSet", "minusAttrIntOverride")

	var ap_pack = StringPack.new()
	ap_pack.setVal("行动点")

	var ap_coms_pack = StringPack.new()
	ap_coms_pack.setVal("消耗行动点")

	sub_ap_node.setDefaultParam("StringPack", ap_pack, 1)
	sub_ap_node.setDefaultParam("StringPack", ap_coms_pack, 3)

	var ap_graph = FuncGraph.new()
	ap_graph.addNode(sub_ap_node)
	ap_graph.addNode(extract_ap_node)
	ap_graph.addNode(extract_ap_coms_node)

	sub_ap_node.setChIndex(1, 0)
	sub_ap_node.setChIndex(2, 2)

	ap_graph.construct()

	var ap_function = Function.new()
	ap_function.setGraph(ap_graph)

	var hyper = HyperFunction.new()
	hyper.addFunction(crop_function)
	hyper.addFunction(ap_function)

	hyper.setParamMapIndex(0, 0)
	hyper.setParamMapIndex(1, 1)
	hyper.setParamMapIndex(2, 1)
	hyper.setParamMapIndex(3, 2)
	hyper.setParamMapIndex(4, 0)

	return hyper

func __buildSlashAnimation():
	var animation_pack = AnimationPack.new()

	animation_pack.addTexturePath("res://asserts/animation/slash/1.png")
	animation_pack.addTexturePath("res://asserts/animation/slash/2.png")
	animation_pack.addTexturePath("res://asserts/animation/slash/3.png")
	animation_pack.addTexturePath("res://asserts/animation/slash/4.png")
	animation_pack.addTexturePath("res://asserts/animation/slash/5.png")
	animation_pack.setGap(3)

	return animation_pack

func __buildSlashAudio():
	var audio_pack = AudioPack.new()

	audio_pack.setAudioPath("res://asserts/audio/crop.mp3")
	
	return audio_pack

func __buildSlashSkillCard():
	var card = LinearSkillCard.new()
	
	var attr = Attr.new()

	attr.addAttr("物理攻击", "Integer", __dummyGetterSetter(), __dummyGetterSetter())
	attr.addAttr("消耗行动点", "Integer", __dummyGetterSetter(), __dummyGetterSetter())

	card.setCardAttr(attr)
	card.setAttr("物理攻击", 5)
	card.setAttr("消耗行动点", 3)
	card.setOffensive()
	card.setPlayCondition(__buildTrueCondition())
	card.setTargetCondition(__buildEnemyTargetCondition())
	card.setAnimationPack(__buildSlashAnimation())
	card.setAudioPack(__buildSlashAudio())
	card.setAutoCondition(__buildFalseCondition())
	card.setEffectFunc(__buildSlashHyperFunction())
	card.setIntroduction("使出全力重击敌人，造成五点物理伤害")
	card.setAvatorName("slash_card")
	
	return card

func __buildSlashCardTemplate():
	var slash_card_template = CardTemplate.new()
	slash_card_template.setTemplateName("SlashSkillCard")
	slash_card_template.setCardType("LinearSkillCard")
	slash_card_template.setCardTemplate(__buildSlashSkillCard())
	slash_card_template.setReviseFunction(__buildReviseFunction())

	return slash_card_template

func __buildShieldHyperFunction():
	var extract_ch_node = FuncGraphNode.new()
	extract_ch_node.setFunc("CardFuncSet", "extractAttr")

	var extract_sh_node = FuncGraphNode.new()
	extract_sh_node.setFunc("CardFuncSet", "extractAttr")

	var sub_node = FuncGraphNode.new()
	sub_node.setFunc("AttrFuncSet", "plusAttrIntOverride")

	var sh_pack = StringPack.new()
	sh_pack.setVal("物理护甲")

	sub_node.setDefaultParam("StringPack", sh_pack, 1)
	sub_node.setDefaultParam("StringPack", sh_pack, 3)

	var sh_graph = FuncGraph.new()
	sh_graph.addNode(sub_node)
	sh_graph.addNode(extract_ch_node)
	sh_graph.addNode(extract_sh_node)

	sub_node.setChIndex(1, 0)
	sub_node.setChIndex(2, 2)

	sh_graph.construct()

	var sh_function = Function.new()
	sh_function.setGraph(sh_graph)

	var extract_ap_node = FuncGraphNode.new()
	extract_ap_node.setFunc("CardFuncSet", "extractAttr")

	var extract_ap_coms_node = FuncGraphNode.new()
	extract_ap_coms_node.setFunc("CardFuncSet", "extractAttr")

	var sub_ap_node = FuncGraphNode.new()
	sub_ap_node.setFunc("AttrFuncSet", "minusAttrIntOverride")

	var ap_pack = StringPack.new()
	ap_pack.setVal("行动点")

	var ap_coms_pack = StringPack.new()
	ap_coms_pack.setVal("消耗行动点")

	sub_ap_node.setDefaultParam("StringPack", ap_pack, 1)
	sub_ap_node.setDefaultParam("StringPack", ap_coms_pack, 3)

	var ap_graph = FuncGraph.new()
	ap_graph.addNode(sub_ap_node)
	ap_graph.addNode(extract_ap_node)
	ap_graph.addNode(extract_ap_coms_node)

	sub_ap_node.setChIndex(1, 0)
	sub_ap_node.setChIndex(2, 2)

	ap_graph.construct()

	var ap_function = Function.new()
	ap_function.setGraph(ap_graph)

	var hyper = HyperFunction.new()
	hyper.addFunction(sh_function)
	hyper.addFunction(ap_function)

	hyper.setParamMapIndex(0, 2)
	hyper.setParamMapIndex(1, 0)
	hyper.setParamMapIndex(2, 2)	
	hyper.setParamMapIndex(3, 0)	

	return hyper

func __buildShieldAnimation():
	var animation_pack = AnimationPack.new()

	animation_pack.addTexturePath("res://asserts/animation/shield/1.png")
	animation_pack.addTexturePath("res://asserts/animation/shield/2.png")
	animation_pack.addTexturePath("res://asserts/animation/shield/3.png")
	animation_pack.addTexturePath("res://asserts/animation/shield/4.png")
	animation_pack.addTexturePath("res://asserts/animation/shield/5.png")
	animation_pack.addTexturePath("res://asserts/animation/shield/6.png")
	animation_pack.addTexturePath("res://asserts/animation/shield/7.png")
	animation_pack.addTexturePath("res://asserts/animation/shield/8.png")
	animation_pack.addTexturePath("res://asserts/animation/shield/9.png")
	animation_pack.setGap(5)

	return animation_pack

func __buildShieldAudio():
	var audio_pack = AudioPack.new()

	audio_pack.setAudioPath("res://asserts/audio/heal.mp3")
	
	return audio_pack

func __buildShieldSkillCard():
	var card = LinearSkillCard.new()
	
	var attr = Attr.new()

	attr.addAttr("物理护甲", "Integer", __dummyGetterSetter(), __dummyGetterSetter())
	attr.addAttr("消耗行动点", "Integer", __dummyGetterSetter(), __dummyGetterSetter())

	card.setCardAttr(attr)
	card.setAttr("物理护甲", 4)
	card.setAttr("消耗行动点", 3)
	card.setOffensive()
	card.setPlayCondition(__buildTrueCondition())
	card.setTargetCondition(__buildOwnTargetCondition())
	card.setAnimationPack(__buildShieldAnimation())
	card.setAudioPack(__buildShieldAudio())
	card.setAutoCondition(__buildFalseCondition())
	card.setEffectFunc(__buildShieldHyperFunction())
	card.setIntroduction("举起盾牌抵御攻击，获得四点物护盾")
	card.setAvatorName("shield_card")
	
	return card

func __buildShieldCardTemplate():
	var shield_card_template = CardTemplate.new()
	shield_card_template.setTemplateName("ShieldSkillCard")
	shield_card_template.setCardType("LinearSkillCard")
	shield_card_template.setCardTemplate(__buildShieldSkillCard())
	shield_card_template.setReviseFunction(__buildReviseFunction())

	return shield_card_template

func __dummyGetterSetter():
	var dummy_node = FuncGraphNode.new()
	dummy_node.setFunc("BaseFuncSet", "returnVal")

	var graph = FuncGraph.new()
	graph.addNode(dummy_node)
	graph.construct()

	var dummy_function = Function.new()
	dummy_function.setGraph(graph)

	return dummy_function

func __buildInitKnightCardPileFunction():
	var get_node1 = FuncGraphNode.new()
	get_node1.setFunc("CardFuncSet", "createCardWithDefaultName")
	var string_pack1 = StringPack.new()
	string_pack1.setVal("CropSkillCard")
	get_node1.setDefaultParam("StringPack", string_pack1, 0)
	
	var get_node2 = FuncGraphNode.new()
	get_node2.setFunc("CardFuncSet", "createCardWithDefaultName")
	var string_pack2 = StringPack.new()
	string_pack2.setVal("CropSkillCard")
	get_node2.setDefaultParam("StringPack", string_pack2, 0)

	var get_node3 = FuncGraphNode.new()
	get_node3.setFunc("CardFuncSet", "createCardWithDefaultName")
	var string_pack3 = StringPack.new()
	string_pack3.setVal("CropSkillCard")
	get_node3.setDefaultParam("StringPack", string_pack3, 0)

	var get_node4 = FuncGraphNode.new()
	get_node4.setFunc("CardFuncSet", "createCardWithDefaultName")
	var string_pack4 = StringPack.new()
	string_pack4.setVal("CropSkillCard")
	get_node4.setDefaultParam("StringPack", string_pack4, 0)

	var get_node5 = FuncGraphNode.new()
	get_node5.setFunc("CardFuncSet", "createCardWithDefaultName")
	var string_pack5 = StringPack.new()
	string_pack5.setVal("SlashSkillCard")
	get_node5.setDefaultParam("StringPack", string_pack5, 0)

	var get_node6 = FuncGraphNode.new()
	get_node6.setFunc("CardFuncSet", "createCardWithDefaultName")
	var string_pack6 = StringPack.new()
	string_pack6.setVal("ShieldSkillCard")
	get_node6.setDefaultParam("StringPack", string_pack6, 0)

	var pack_node = FuncGraphNode.new()	
	pack_node.setFunc("ArrayOperFuncSet", "packArray")
	
	var append_node1 = FuncGraphNode.new()
	append_node1.setFunc("ArrayOperFuncSet", "appendVal")

	var append_node2 = FuncGraphNode.new()
	append_node2.setFunc("ArrayOperFuncSet", "appendVal")

	var append_node3 = FuncGraphNode.new()
	append_node3.setFunc("ArrayOperFuncSet", "appendVal")

	var append_node4 = FuncGraphNode.new()
	append_node4.setFunc("ArrayOperFuncSet", "appendVal")

	var append_node5 = FuncGraphNode.new()
	append_node5.setFunc("ArrayOperFuncSet", "appendVal")

	var init_graph = FuncGraph.new()
	init_graph.addNode(append_node1)
	init_graph.addNode(append_node2)
	init_graph.addNode(append_node3)
	init_graph.addNode(append_node4)
	init_graph.addNode(append_node5)
	init_graph.addNode(pack_node)
	init_graph.addNode(get_node1)
	init_graph.addNode(get_node2)
	init_graph.addNode(get_node3)
	init_graph.addNode(get_node4)
	init_graph.addNode(get_node5)
	init_graph.addNode(get_node6)

	append_node1.setChIndex(1, 0)
	append_node2.setChIndex(2, 0)
	append_node3.setChIndex(3, 0)
	append_node4.setChIndex(4, 0)
	append_node5.setChIndex(5, 0)
	pack_node.setChIndex(6, 0)
	append_node1.setChIndex(7, 1)
	append_node2.setChIndex(8, 1)
	append_node3.setChIndex(9, 1)
	append_node4.setChIndex(10, 1)
	append_node5.setChIndex(11, 1)

	init_graph.construct()

	var init_function = Function.new()
	init_function.setGraph(init_graph)

	return init_function

func __addKnightCharacterAttr(card):
	var attr = Attr.new()

	attr.addAttr("健康值", "Integer", __dummyGetterSetter(), __dummyGetterSetter())
	attr.addAttr("物理护甲", "Integer", __dummyGetterSetter(), __dummyGetterSetter())
	attr.addAttr("行动点", "Integer", __dummyGetterSetter(), __dummyGetterSetter())
	attr.addAttr("手牌上限", "Integer", __dummyGetterSetter(), __dummyGetterSetter())

	card.setCardAttr(attr)

func __setKnightCharacterAttr(card):
	card.setAttr("健康值", 10)
	card.setAttr("物理护甲", 0)
	card.setAttr("行动点", 0)
	card.setAttr("手牌上限", 4)

func __buildKnightCharacterCard():
	var card = LinearCharacterCard.new()
	card.setTemplateName("KnightCharacterCard")
	card.setAvatorName("knight_character")
	card.setIntroduction("注重防御的重装职业")
	
	__addKnightCharacterAttr(card)
	__setKnightCharacterAttr(card)

	card.setInitCardPileFunction(__buildInitKnightCardPileFunction())
	card.setAiIsActionCondition(__buildFalseCondition())
	card.setAiChooseCardFunction(__buildFalseCondition())
	card.setAiChooseTargetFunction(__buildFalseCondition())

	return card

func __buildKnightCardTemplate():
	var knight_character_card = __buildKnightCharacterCard()
	var knight_character_template = CardTemplate.new()
	knight_character_template.setTemplateName("KnightCharacterCard")
	knight_character_template.setCardType("LinearCharacterCard")
	knight_character_template.setCardTemplate(knight_character_card)
	knight_character_template.setReviseFunction(__buildReviseFunction())

	return knight_character_template

func __buildInitRobberCardPileFunction():
	var get_node1 = FuncGraphNode.new()
	get_node1.setFunc("CardFuncSet", "createCardWithDefaultName")
	var string_pack1 = StringPack.new()
	string_pack1.setVal("StabSkillCard")
	get_node1.setDefaultParam("StringPack", string_pack1, 0)
	
	var get_node2 = FuncGraphNode.new()
	get_node2.setFunc("CardFuncSet", "createCardWithDefaultName")
	var string_pack2 = StringPack.new()
	string_pack2.setVal("StabSkillCard")
	get_node2.setDefaultParam("StringPack", string_pack2, 0)

	var pack_node = FuncGraphNode.new()	
	pack_node.setFunc("ArrayOperFuncSet", "packArray")
	
	var append_node = FuncGraphNode.new()
	append_node.setFunc("ArrayOperFuncSet", "appendVal")

	var init_graph = FuncGraph.new()
	init_graph.addNode(append_node)
	init_graph.addNode(pack_node)
	init_graph.addNode(get_node1)
	init_graph.addNode(get_node2)

	append_node.setChIndex(1, 0)
	append_node.setChIndex(3, 1)
	pack_node.setChIndex(2, 0)

	init_graph.construct()

	var init_function = Function.new()
	init_function.setGraph(init_graph)

	return init_function

func __addRobberCharacterAttr(card):
	var attr = Attr.new()

	attr.addAttr("健康值", "Integer", __dummyGetterSetter(), __dummyGetterSetter())
	attr.addAttr("物理护甲", "Integer", __dummyGetterSetter(), __dummyGetterSetter())
	attr.addAttr("行动点", "Integer", __dummyGetterSetter(), __dummyGetterSetter())
	attr.addAttr("手牌上限", "Integer", __dummyGetterSetter(), __dummyGetterSetter())

	card.setCardAttr(attr)

func __setRobberCharacterAttr(card):
	card.setAttr("健康值", 4)
	card.setAttr("物理护甲", 0)
	card.setAttr("行动点", 0)
	card.setAttr("手牌上限", 2)

func __buildRobberCharacterCard():
	var card = LinearCharacterCard.new()
	card.setTemplateName("RobberCharacterCard")
	card.setAvatorName("robber_character")
	card.setIntroduction("遭遇的山野强盗")
	
	__addRobberCharacterAttr(card)
	__setRobberCharacterAttr(card)

	card.setInitCardPileFunction(__buildInitRobberCardPileFunction())
	card.setAiIsActionCondition(__buildAiIsActionCondition())
	card.setAiChooseCardFunction(__buildAiChooseCardFunction())
	card.setAiChooseTargetFunction(__buildAiChooseTargetFunction())

	return card

func __buildRobberCardTemplate():
	var robber_character_card = __buildRobberCharacterCard()
	var robber_character_template = CardTemplate.new()
	robber_character_template.setTemplateName("RobberCharacterCard")
	robber_character_template.setCardType("LinearCharacterCard")
	robber_character_template.setCardTemplate(robber_character_card)
	robber_character_template.setReviseFunction(__buildReviseFunction())

	return robber_character_template

func test_buildCardCache():
	CardCache.addTemplate(__buildAttackCardTemplate())
	CardCache.addTemplate(__buildMainCharacterTemplate())
	CardCache.addTemplate(__buildEnemyCharacterTemplate())
	CardCache.addTemplate(__buildKnightCardTemplate())
	CardCache.addTemplate(__buildCropCardTemplate())
	CardCache.addTemplate(__buildRobberCardTemplate())
	CardCache.addTemplate(__buildStabCardTemplate())
	CardCache.addTemplate(__buildSlashCardTemplate())
	CardCache.addTemplate(__buildShieldCardTemplate())

	var script_tree = CardCache.pack()
	script_tree.exportAsJson("res://test/scripts/card_templates.json")

	pass_test("Create card cache script success")
