extends GutTest

var Function = TypeUnit.type("Function")
var FuncGraph = TypeUnit.type("FuncGraph")
var FuncUnit = TypeUnit.type("FuncUnit")
var ArrangeMap = TypeUnit.type("ArrangeMap")
var DictMap = TypeUnit.type("DictMap")
var HyperFunction = TypeUnit.type("HyperFunction")
var ParamList = TypeUnit.type("ParamList")
var ScriptTree = TypeUnit.type("ScriptTree")

func before_all():
	CardCache.initScript()
	GlobalSetting.initScript()
	ResourceUnit.initScript()

func test_graphTest1():
	var random_func_unit = FuncUnit.new()
	random_func_unit.setFuncSetName("MathFuncSet")
	random_func_unit.setFuncName("randInt")
	random_func_unit.initDefaultParams()

	var graph = FuncGraph.new()

	var func_graph_node = graph.genNode(random_func_unit)

	graph.setRoot(func_graph_node)

	pass_test("Graph run success")

func test_graphTest2():
	var const_func_unit = FuncUnit.new()
	const_func_unit.setFuncSetName("MathFuncSet")
	const_func_unit.setFuncName("constVal")
	const_func_unit.initDefaultParams()
	const_func_unit.setDefaultParam("Integer", 4, 0)

	var const_func_unit_ = FuncUnit.new()
	const_func_unit_.setFuncSetName("MathFuncSet")
	const_func_unit_.setFuncName("constVal")
	const_func_unit_.initDefaultParams()
	const_func_unit_.setDefaultParam("Integer", 3, 0)

	var mul_func_unit = FuncUnit.new()
	mul_func_unit.setFuncSetName("MathFuncSet")
	mul_func_unit.setFuncName("mulInt")
	mul_func_unit.initDefaultParams()

	var graph = FuncGraph.new()

	var mul_graph_node = graph.genNode(mul_func_unit)
	var const_graph_node = graph.genNode(const_func_unit)
	var const_graph_node_ = graph.genNode(const_func_unit_)

	mul_graph_node.connectNode(const_graph_node, 0)
	mul_graph_node.connectNode(const_graph_node_, 1)

	graph.setRoot(mul_graph_node)

	assert_eq(graph.exec({}), 12)

func test_graphPackTest():
	var graph = __getTestGraph2()
	var script_tree = graph.pack()
	script_tree.exportAsJson("res://test/testFile/graphPack.json")

	pass_test("Create graphPack success")

func test_buildGraphTest():
	var script_tree = ScriptTree.new()
	script_tree.loadFromJson("res://test/testFile/graphPack.json")

	var graph = FuncGraph.new()
	graph.loadScript(script_tree)

	var function = Function.new()
	function.setGraph(graph)
	function.setMap([
		"plusInt_2_0",
		"plusInt_2_1",
		"mulInt_3_0",
		"mulInt_3_1"
	])

	assert_eq(function.exec([2, 10, 2, 4]), 4)
	assert_eq(function.exec([2, 3, 2, 6]), -7)


func test_functionTest1():
	var graph = __getTestGraph1()
	
	var function = Function.new()
	function.setGraph(graph)
	function.initParamMap()

	assert_eq(function.exec({}), 7)

func test_functionTest2():
	var graph = __getTestGraph2()
	
	var function = Function.new()
	function.setGraph(graph)
	function.setMap([
		"plusInt_2_0",
		"plusInt_2_1",
		"mulInt_3_0",
		"mulInt_3_1"
	])

	assert_eq(function.exec([2, 10, 2, 4]), 4)
	assert_eq(function.exec([2, 3, 2, 6]), -7)

func test_hyperFunction():
	var graph1 = __getTestGraph2()
	var graph2 = __getTestGraph3()

	var function1 = Function.new()
	
	function1.setGraph(graph1)
	function1.setMap([
		"plusInt_2_0",
		"plusInt_2_1",
		"mulInt_3_0",
		"mulInt_3_1"
	])

	var function2 = Function.new()
	
	function2.setGraph(graph2)
	function2.setMap([
		"plusInt_1_1",
		"plusInt_1_0"
	])

	var hyper_function = HyperFunction.new()
	hyper_function.addFunction(function1)
	hyper_function.addFunction(function2)

	hyper_function.setParamMap([5, 4, 3, 2, 1, 0])
	hyper_function.setRetMap([1, 0])

	assert_eq(hyper_function.exec([1, 2, 3, 4, 5, 6]), [3, -1])

func __getTestGraph1():
	var const_func_unit = FuncUnit.new()
	const_func_unit.setFuncSetName("MathFuncSet")
	const_func_unit.setFuncName("constVal")
	const_func_unit.initDefaultParams()
	const_func_unit.setDefaultParam("Integer", 4, 0)

	var const_func_unit_ = FuncUnit.new()
	const_func_unit_.setFuncSetName("MathFuncSet")
	const_func_unit_.setFuncName("constVal")
	const_func_unit_.initDefaultParams()
	const_func_unit_.setDefaultParam("Integer", 3, 0)

	var plus_func_unit = FuncUnit.new()
	plus_func_unit.setFuncSetName("MathFuncSet")
	plus_func_unit.setFuncName("plusInt")
	plus_func_unit.initDefaultParams()

	var graph = FuncGraph.new()

	var plus_graph_node = graph.genNode(plus_func_unit)
	var const_graph_node = graph.genNode(const_func_unit)
	var const_graph_node_ = graph.genNode(const_func_unit_)

	plus_graph_node.connectNode(const_graph_node, 0)
	plus_graph_node.connectNode(const_graph_node_, 1)

	graph.setRoot(plus_graph_node)

	return graph

func __getTestGraph2():
	var plus_func_unit = FuncUnit.new()
	plus_func_unit.setFuncSetName("MathFuncSet")
	plus_func_unit.setFuncName("plusInt")
	plus_func_unit.initDefaultParams()

	var mul_func_unit = FuncUnit.new()
	mul_func_unit.setFuncSetName("MathFuncSet")
	mul_func_unit.setFuncName("mulInt")
	mul_func_unit.initDefaultParams()

	var minus_func_unit = FuncUnit.new()
	minus_func_unit.setFuncSetName("MathFuncSet")
	minus_func_unit.setFuncName("minusInt")
	minus_func_unit.initDefaultParams()

	var graph = FuncGraph.new()

	var plus_node = graph.genNode(plus_func_unit)
	var mul_node = graph.genNode(mul_func_unit)
	var minus_node = graph.genNode(minus_func_unit)

	minus_node.connectNode(plus_node, 0)
	minus_node.connectNode(mul_node, 1)

	graph.setRoot(minus_node)

	return graph	

func __getTestGraph3():
	var plus_func_unit = FuncUnit.new()
	plus_func_unit.setFuncSetName("MathFuncSet")
	plus_func_unit.setFuncName("plusInt")
	plus_func_unit.initDefaultParams()

	var graph = FuncGraph.new()
	var plus_node = graph.genNode(plus_func_unit)
	graph.setRoot(plus_node)

	return graph

