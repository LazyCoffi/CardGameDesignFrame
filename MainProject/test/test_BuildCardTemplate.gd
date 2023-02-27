extends GutTest

var LinearCharacterCard = TypeUnit.type("LinearCharacterCard")
var LinearSkillCard = TypeUnit.type("LinearSkillCard")
var Attr = TypeUnit.type("Attr")
var HyperFunction = TypeUnit.type("HyperFunction")
var Function = TypeUnit.type("Function")
var FuncGraph = TypeUnit.type("FuncGraph")
var FuncUnit = TypeUnit.type("FuncUnit")

func before_all():
	GlobalSetting.initScript()
	ResourceUnit.initScript()

func __buildHpGetterFunction():
	var getter_func_unit = FuncUnit.new()
	getter_func_unit.setFuncSetName("BaseFuncSet")
	getter_func_unit.setFuncName("returnVal")
	getter_func_unit.initDefaultParams()

	var graph = FuncGraph.new()
	var getter_node = graph.genNode(getter_func_unit)
	graph.setRoot(getter_node)
	
	var getter_function = Function.new()
	getter_function.setGraph(graph)
	getter_function.initParamMap()

	return getter_function

func __buildHpSetterFunction():
	var lower_func_unit = FuncUnit.new()
	lower_func_unit.setFuncSetName("MathFuncSet")
	lower_func_unit.setFuncName("lowerBoundInt")
	lower_func_unit.initDefaultParams()
	lower_func_unit.setDefaultParam("Integer", 0, 1)

	var upper_func_unit = FuncUnit.new()
	upper_func_unit.setFuncSetName("MathFuncSet")
	upper_func_unit.setFuncName("upperBoundInt")
	upper_func_unit.initDefaultParams()
	upper_func_unit.setDefaultParam("Integer", 100, 1)

	var graph = FuncGraph.new()
	var lower_node = graph.genNode(lower_func_unit)
	var upper_node = graph.genNode(upper_func_unit)
	upper_node.connectNode(lower_node, 0)
	
	graph.setRoot(upper_node)

	var setter_function = Function.new()
	setter_function.setGraph(graph)
	setter_function.initParamMap()

	return setter_function

func __buildStgFunction():
	var func_unit = FuncUnit.new()
	func_unit.setFuncSetName("BaseFuncSet")
	func_unit.setFuncName("returnVal")
	func_unit.initDefaultParams()

	var graph = FuncGraph.new()
	var node = graph.genNode(func_unit)
	graph.setRoot(node)
	
	var function = Function.new()
	function.setGraph(graph)
	function.initParamMap()

	return function

func __addBattleCharacterAttr(card):
	var hp_getter_function = __buildHpGetterFunction()
	var hp_setter_function = __buildHpSetterFunction()
	card.addAttr("hp", "Integer", hp_getter_function, hp_setter_function)

	var stg_getter_function = __buildStgFunction()
	var stg_setter_function = __buildStgFunction()
	card.addAttr("stg", "Integer", stg_getter_function, stg_setter_function)

func __buildTrueCondition():
	var true_unit = FuncUnit.new()
	true_unit.setFuncSetName("BaseConditionSet")
	true_unit.setFuncName("trueGate")
	true_unit.initDefaultParams()

	var graph = FuncGraph.new()
	var true_node = graph.genNode(true_unit)
	graph.setRoot(true_node)

	var true_condition = Function.new()	
	true_condition.setGraph(graph)
	true_condition.initParamMap()

	return true_condition

func __buildFalseCondition():
	var false_unit = FuncUnit.new()
	false_unit.setFuncSetName("BaseConditionSet")
	false_unit.setFuncName("falseGate")
	false_unit.initDefaultParams()

	var graph = FuncGraph.new()
	var false_node = graph.genNode(false_unit)
	graph.setRoot(false_node)

	var false_condition = Function.new()	
	false_condition.setGraph(graph)
	false_condition.initParamMap()

	return false_condition

func __buildExtractFuncUnit():
	var extract_func_unit = FuncUnit.new()
	extract_func_unit.setFuncSetName("CardFuncSet")
	extract_func_unit.setFuncName("extractAttr")
	extract_func_unit.initDefaultParams()

	return extract_func_unit

func __buildAttackHyperFunction():
	var extract_func_unit1 = __buildExtractFuncUnit()
	var extract_func_unit2 = __buildExtractFuncUnit()
	
	var attack_func_unit = FuncUnit.new()
	attack_func_unit.setFuncSetName("AttrFuncSet")
	attack_func_unit.setFuncName("minusAttrIntOverride")
	attack_func_unit.initDefaultParams()
	attack_func_unit.setDefaultParam("StringPack", "hp", 1)
	attack_func_unit.setDefaultParam("StringPack", "stg", 3)

	var graph = FuncGraph.new()
	var extract_node1 = graph.genNode(extract_func_unit1)
	var extract_node2 = graph.genNode(extract_func_unit2)
	var attack_node = graph.genNode(attack_func_unit)

	attack_node.connectNode(extract_node1, 0)
	attack_node.connectNode(extract_node2, 2)

	graph.setRoot(attack_node)

	var attack_function = Function.new()
	attack_function.setGraph(graph)
	attack_function.initParamMap()

	var attack_hyper = HyperFunction.new()
	attack_hyper.addFunction(attack_function)
	attack_hyper.initParamMap()
	attack_hyper.initRetMap()

	return attack_hyper

func __buildAttackSkillCard(index):
	var card = LinearSkillCard.new()
	card.setPositive()
	card.setPlayCondition(__buildTrueCondition())
	card.setTargetCondition(__buildTrueCondition())
	card.setAutoCondition(__buildFalseCondition())
	card.setEffectFunc(__buildAttackHyperFunction())
	card.setCardName("attack" + str(index))
	card.setIntroduction("Attack!")
	card.setAvatorName("attack_card")
	card.setPositive()

	return card

func __buildAiIsActionCondition():
	var not_unit = FuncUnit.new()
	not_unit.setFuncSetName("BaseConditionSet")
	not_unit.setFuncName("notGate")
	not_unit.initDefaultParams()

	var empty_unit = FuncUnit.new()
	empty_unit.setFuncSetName("CharacterCardConditionSet")
	empty_unit.setFuncName("isHandCardsEmpty")
	empty_unit.initDefaultParams()

	var graph = FuncGraph.new()
	var not_node = graph.genNode(not_unit)
	var empty_node = graph.genNode(empty_unit)

	not_node.connectNode(empty_node, 0)
	graph.setRoot(not_node)
	
	var ai_is_action_condition = Function.new()
	ai_is_action_condition.setGraph(graph)
	ai_is_action_condition.initParamMap()

	return ai_is_action_condition

func __buildAiChooseTargetFunction():
	var opposite_unit = FuncUnit.new()
	opposite_unit.setFuncSetName("LinearBattleFuncSet")
	opposite_unit.setFuncName("getOppositeTeam")
	opposite_unit.initDefaultParams()

	var get_unit = FuncUnit.new()
	get_unit.setFuncSetName("ArrayOperFuncSet")
	get_unit.setFuncName("getFront")
	get_unit.initDefaultParams()

	var graph = FuncGraph.new()
	var opposite_node = graph.genNode(opposite_unit)
	var get_node = graph.genNode(get_unit)
	get_node.connectNode(opposite_node, 0)
	graph.setRoot(get_node)

	var ai_choose_target_function = Function.new()
	ai_choose_target_function.setGraph(graph)
	ai_choose_target_function.initParamMap()
	ai_choose_target_function.setMap(
		[
			"getOppositeTeam_2_1",
			"getOppositeTeam_2_0"
		]
	)

	return ai_choose_target_function

func __buildAiChooseCardFunction():
	var peek_unit = FuncUnit.new()
	peek_unit.setFuncSetName("CharacterCardFuncSet")
	peek_unit.setFuncName("peekHandCards")
	peek_unit.initDefaultParams()

	var get_unit = FuncUnit.new()
	get_unit.setFuncSetName("ArrayOperFuncSet")
	get_unit.setFuncName("getFront")
	get_unit.initDefaultParams()

	var graph = FuncGraph.new()
	var peek_node = graph.genNode(peek_unit)
	var get_node = graph.genNode(get_unit)
	get_node.connectNode(peek_node, 0)
	graph.setRoot(get_node)

	var ai_choose_card_function = Function.new()
	ai_choose_card_function.setGraph(graph)
	ai_choose_card_function.initParamMap()

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
	var revise_func_unit = FuncUnit.new()
	revise_func_unit.setFuncSetName("BaseFuncSet")
	revise_func_unit.setFuncName("returnVal")
	revise_func_unit.initDefaultParams()

	var graph = FuncGraph.new()
	var revise_node = graph.genNode(revise_func_unit)
	graph.setRoot(revise_node)

	var revise_function = Function.new()
	revise_function.setGraph(graph)
	revise_function.initParamMap()

	return revise_function

func test_buildCardCache():
	var main_character_card = __buildMainCharacterCard()
	CardCache.addTemplate("LinearCharacterCard", main_character_card, __buildReviseFunction(), ["CharacterCard", "LinearCharacterCard"])
	var enemy_character_card = __buildEnemyCharacterCard()
	CardCache.addTemplate("LinearCharacterCard", enemy_character_card, __buildReviseFunction(), ["CharacterCard", "LinearCharacterCard"])

	var script_tree = CardCache.pack()
	script_tree.exportAsJson("res://test/scripts/card_templates.json")

	pass_test("Create cardCache script success")

func test_isBuildSuccess():
	CardCache.initScript()
	var card = CardCache.getCardWithDefaultName("MainCharacterCard")
	var attack_card = card.peekCardPile()
	assert_eq(4, attack_card.size())
