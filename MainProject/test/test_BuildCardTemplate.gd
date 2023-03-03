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
	getter_function.setMap(["returnVal_0_0"])

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
	setter_function.setMap(["upperBoundInt_1_0"])

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
	function.setMap(["returnVal_0_0"])

	return function

func __addBattleCharacterAttr(card):
	var hp_attr = AttrNode.new()
	hp_attr.setAttrName("hp")
	hp_attr.setAttrType("Integer")
	var hp_getter_function = __buildHpGetterFunction()
	var hp_setter_function = __buildHpSetterFunction()
	hp_attr.setGetterFunction(hp_getter_function)
	hp_attr.setSetterFunction(hp_setter_function)
	card.addAttr(hp_attr)

	var stg_attr = AttrNode.new()
	stg_attr.setAttrName("stg")
	stg_attr.setAttrType("Integer")
	var stg_getter_function = __buildStgFunction()
	var stg_setter_function = __buildStgFunction()
	stg_attr.setGetterFunction(stg_getter_function)
	stg_attr.setSetterFunction(stg_setter_function)
	
	card.addAttr(stg_attr)

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
	true_condition.setMap([])

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
	false_condition.setMap([])

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
	
	var param_node0 = ParamNode.new()
	param_node0.setParamType("NullPack")
	param_node0.setParam(NullPack.new())

	var param_node1 = ParamNode.new()
	param_node1.setParamType("StringPack")
	var string_pack1 = StringPack.new()
	string_pack1.setVal("hp")
	param_node1.setParam(string_pack1)

	var param_node2 = ParamNode.new()
	param_node2.setParamType("NullPack")
	param_node2.setParam(NullPack.new())

	var param_node3 = ParamNode.new()
	param_node3.setParamType("StringPack")
	var string_pack3 = StringPack.new()
	string_pack3.setVal("stg")
	param_node3.setParam(string_pack1)

	var param_list = ParamList.new()

	param_list.addParam(param_node0)
	param_list.addParam(param_node1)
	param_list.addParam(param_node2)
	param_list.addParam(param_node3)
	
	var attack_func_unit = FuncUnit.new()
	attack_func_unit.setFuncSetName("AttrFuncSet")
	attack_func_unit.setFuncName("minusAttrIntOverride")
	attack_func_unit.setDefaultParams(param_list)

	var extract_func_unit1 = __buildExtractFuncUnit()
	var extract_func_unit2 = __buildExtractFuncUnit()

	var graph = FuncGraph.new()

	var extract_node1 = FuncGraphNode.new()
	extract_node1.setFuncUnit(extract_func_unit1)
	extract_node1.setChIndexList([null])

	var extract_node2 = FuncGraphNode.new()
	extract_node2.setFuncUnit(extract_func_unit2)
	extract_node2.setChIndexList([null])

	var attack_node = FuncGraphNode.new()
	attack_node.setFuncUnit(attack_func_unit)
	attack_node.setChIndexList([1, null, 2, null])

	graph.addNode(attack_node)
	graph.addNode(extract_node1)
	graph.addNode(extract_node2)
	graph.construct()

	var attack_function = Function.new()
	attack_function.setGraph(graph)
	attack_function.setMap(["extractAttr_1_0", "extractAttr_2_0"])

	var attack_hyper = HyperFunction.new()
	attack_hyper.addFunction(attack_function)
	attack_hyper.setParamMap([0, 1])
	attack_hyper.setRetMap([0])

	return attack_hyper

func __buildAttackSkillCard(index):
	var card = LinearSkillCard.new()
	card.setOffensive()
	card.setPlayCondition(__buildTrueCondition())
	card.setTargetCondition(__buildTrueCondition())
	card.setAutoCondition(__buildFalseCondition())
	card.setEffectFunc(__buildAttackHyperFunction())
	card.setCardName("attack" + str(index))
	card.setIntroduction("Attack!")
	card.setAvatorName("attack_card")
	card.setOffensive()

	return card

func __buildAiIsActionCondition():
	var not_param_node = ParamNode.new()
	not_param_node.setParamType("NullPack")
	not_param_node.setParam(NullPack.new())

	var not_param_list = ParamList.new()
	not_param_list.addParam(not_param_node)

	var not_unit = FuncUnit.new()
	not_unit.setFuncSetName("BaseConditionSet")
	not_unit.setFuncName("notGate")
	not_unit.setDefaultParams(not_param_list)

	var empty_param_node = ParamNode.new()
	empty_param_node.setParamType("NullPack")
	empty_param_node.setParam(NullPack.new())

	var empty_param_list = ParamList.new()
	empty_param_list.addParam(empty_param_node)

	var empty_unit = FuncUnit.new()
	empty_unit.setFuncSetName("CharacterCardConditionSet")
	empty_unit.setFuncName("isHandCardsEmpty")
	empty_unit.setDefaultParams(empty_param_list)

	var graph = FuncGraph.new()

	var not_node = FuncGraphNode.new()
	not_node.setFuncUnit(not_unit)
	not_node.setChIndexList([1])

	var empty_node = FuncGraphNode.new()
	empty_node.setFuncUnit(empty_unit)
	empty_node.setChIndexList([null])

	graph.addNode(not_node)
	graph.addNode(empty_node)
	graph.construct()
	
	var ai_is_action_condition = Function.new()
	ai_is_action_condition.setGraph(graph)
	ai_is_action_condition.setMap(["isHandCardsEmpty_1_0"])

	return ai_is_action_condition

func __buildAiChooseTargetFunction():
	var opposite_param_node0 = ParamNode.new()
	opposite_param_node0.setParamType("NullPack")
	opposite_param_node0.setParam(NullPack.new())

	var opposite_param_node1 = ParamNode.new()
	opposite_param_node1.setParamType("NullPack")
	opposite_param_node1.setParam(NullPack.new())

	var opposite_param_list = ParamList.new()
	opposite_param_list.addParam(opposite_param_node0)
	opposite_param_list.addParam(opposite_param_node1)

	var opposite_unit = FuncUnit.new()
	opposite_unit.setFuncSetName("LinearBattleFuncSet")
	opposite_unit.setFuncName("getOppositeTeam")
	opposite_unit.setDefaultParams(opposite_param_list)

	var get_param_node = ParamNode.new()
	get_param_node.setParamType("NullPack")
	get_param_node.setParam(NullPack.new())

	var get_param_list = ParamList.new()
	get_param_list.addParam(get_param_node)

	var get_unit = FuncUnit.new()
	get_unit.setFuncSetName("ArrayOperFuncSet")
	get_unit.setFuncName("getFront")
	get_unit.setDefaultParams(get_param_list)

	var graph = FuncGraph.new()
	var opposite_node = FuncGraphNode.new()
	opposite_node.setFuncUnit(opposite_unit)
	opposite_node.setChIndexList([null, null])

	var get_node = FuncGraphNode.new()	
	get_node.setFuncUnit(get_unit)
	get_node.setChIndexList([1])

	graph.addNode(get_node)
	graph.addNode(opposite_node)
	graph.construct()

	var ai_choose_target_function = Function.new()
	ai_choose_target_function.setGraph(graph)
	ai_choose_target_function.setMap(
		[
			"getOppositeTeam_1_1",
			"getOppositeTeam_1_0"
		]
	)

	return ai_choose_target_function

func __buildAiChooseCardFunction():
	var peek_param_node = ParamNode.new()
	peek_param_node.setParamType("NullPack")
	peek_param_node.setParam(NullPack.new())

	var peek_param_list = ParamList.new()
	peek_param_list.addParam(peek_param_node)

	var peek_unit = FuncUnit.new()
	peek_unit.setFuncSetName("CharacterCardFuncSet")
	peek_unit.setFuncName("peekHandCards")
	peek_unit.setDefaultParams(peek_param_list)

	var get_param_node = ParamNode.new()
	get_param_node.setParamType("NullPack")
	get_param_node.setParam(NullPack.new())

	var get_param_list = ParamList.new()
	get_param_list.addParam(get_param_node)

	var get_unit = FuncUnit.new()
	get_unit.setFuncSetName("ArrayOperFuncSet")
	get_unit.setFuncName("getFront")
	get_unit.setDefaultParams(get_param_list)

	var graph = FuncGraph.new()

	var peek_node = FuncGraphNode.new()
	peek_node.setFuncUnit(peek_unit)
	peek_node.setChIndexList([null])

	var get_node = FuncGraphNode.new()
	get_node.setFuncUnit(get_unit)
	get_node.setChIndexList([1])

	graph.addNode(get_node)
	graph.addNode(peek_node)
	graph.construct()

	var ai_choose_card_function = Function.new()
	ai_choose_card_function.setGraph(graph)
	ai_choose_card_function.setMap(["peekHandCards_1_0"])

	return ai_choose_card_function

func __buildMainCharacterCard():
	var card = LinearCharacterCard.new()
	card.setTemplateName("MainCharacterCard")
	card.setAvatorName("main_character")
	card.setIntroduction("Main character card.")
	
	__addBattleCharacterAttr(card)
	card.setAttr("hp", 100)
	card.setAttr("stg", 25)

	for index in 4:
		card.pushCardPileFront(__buildAttackSkillCard(index))
	
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
	card.setAttr("stg", 10)

	for index in 4:
		card.pushCardPileFront(__buildAttackSkillCard(index + 4))
	
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
	revise_function.setMap(["returnVal_0_0"])

	return revise_function

func test_buildCardCache():
	var main_character_card = __buildMainCharacterCard()
	CardCache.addTemplate("LinearCharacterCard", main_character_card, __buildReviseFunction(), ["CharacterCard", "LinearCharacterCard"])
	var enemy_character_card = __buildEnemyCharacterCard()
	CardCache.addTemplate("LinearCharacterCard", enemy_character_card, __buildReviseFunction(), ["CharacterCard", "LinearCharacterCard"])

	var script_tree = CardCache.pack()
	script_tree.exportAsJson("res://test/scripts/card_templates.json")

	pass_test("Create cardCache script success")
