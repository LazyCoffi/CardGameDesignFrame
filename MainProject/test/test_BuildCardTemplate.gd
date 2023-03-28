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
	attack_hyper.setParamMap([0, 1])
	attack_hyper.setRetMap([0])

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

func test_buildCardCache():
	var attack_card = __buildAttackSkillCard()
	var attack_card_template = CardTemplate.new()
	attack_card_template.setTemplateName("AttackSkillCard")
	attack_card_template.setCardType("LinearSkillCard")
	attack_card_template.setCardTemplate(attack_card)
	attack_card_template.setReviseFunction(__buildReviseFunction())
	CardCache.addTemplate(attack_card_template)

	var main_character_card = __buildMainCharacterCard()
	var main_character_template = CardTemplate.new()
	main_character_template.setTemplateName("MainCharacterCard")
	main_character_template.setCardType("LinearCharacterCard")
	main_character_template.setCardTemplate(main_character_card)
	main_character_template.setReviseFunction(__buildReviseFunction())
	CardCache.addTemplate(main_character_template)

	var enemy_character_card = __buildEnemyCharacterCard()
	var enemy_character_template = CardTemplate.new()
	enemy_character_template.setTemplateName("EnemyCharacterCard")
	enemy_character_template.setCardType("LinearCharacterCard")
	enemy_character_template.setCardTemplate(enemy_character_card)
	enemy_character_template.setReviseFunction(__buildReviseFunction())
	CardCache.addTemplate(enemy_character_template)

	var script_tree = CardCache.pack()
	script_tree.exportAsJson("res://test/scripts/card_templates.json")

	pass_test("Create cardCache script success")
