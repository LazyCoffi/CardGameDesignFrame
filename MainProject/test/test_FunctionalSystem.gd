extends GutTest

var Filter = TypeUnit.type("Filter")
var FunctionalGraph = TypeUnit.type("FunctionalGraph")
var Function = TypeUnit.type("Function")
var ArrangeMap = TypeUnit.type("ArrangeMap")
var DictMap = TypeUnit.type("DictMap")
var LocalFunction = TypeUnit.type("LocalFunction")
var ParamList = TypeUnit.type("ParamList")

func test_graphTest1():
	var random_function = Function.new()
	random_function.setFuncSetName("MathFunctionSet")
	random_function.setFuncName("randInt")
	random_function.initDefaultParams()

	var graph = FunctionalGraph.new()

	var func_graph_node = graph.genNode(random_function)

	graph.setRoot(func_graph_node)

	print(graph.exec({"randInt_1_0" : 1, "randInt_1_1" : 10}))
	print(graph.exec({"randInt_1_0" : 2, "randInt_1_1" : 9}))

	pass_test("Graph run success")

func test_graphTest2():
	var const_function = Function.new()
	const_function.setFuncSetName("MathFunctionSet")
	const_function.setFuncName("constVal")
	const_function.initDefaultParams()
	const_function.setDefaultParam(0, "Integer", 4)

	var const_function_ = Function.new()
	const_function_.setFuncSetName("MathFunctionSet")
	const_function_.setFuncName("constVal")
	const_function_.initDefaultParams()
	const_function_.setDefaultParam(0, "Integer", 3)

	var mul_function = Function.new()
	mul_function.setFuncSetName("MathFunctionSet")
	mul_function.setFuncName("mulInt")
	mul_function.initDefaultParams()

	var graph = FunctionalGraph.new()

	var mul_graph_node = graph.genNode(mul_function)
	var const_graph_node = graph.genNode(const_function)
	var const_graph_node_ = graph.genNode(const_function_)

	mul_graph_node.connectNode(const_graph_node, 0)
	mul_graph_node.connectNode(const_graph_node_, 1)

	graph.setRoot(mul_graph_node)

	assert_eq(graph.exec({}), 12)

func __getTestGraph1():
	var const_function = Function.new()
	const_function.setFuncSetName("MathFunctionSet")
	const_function.setFuncName("constVal")
	const_function.initDefaultParams()
	const_function.setDefaultParam(0, "Integer", 4)

	var const_function_ = Function.new()
	const_function_.setFuncSetName("MathFunctionSet")
	const_function_.setFuncName("constVal")
	const_function_.initDefaultParams()
	const_function_.setDefaultParam(0, "Integer", 3)

	var plus_function = Function.new()
	plus_function.setFuncSetName("MathFunctionSet")
	plus_function.setFuncName("plusInt")
	plus_function.initDefaultParams()

	var graph = FunctionalGraph.new()

	var plus_graph_node = graph.genNode(plus_function)
	var const_graph_node = graph.genNode(const_function)
	var const_graph_node_ = graph.genNode(const_function_)

	plus_graph_node.connectNode(const_graph_node, 0)
	plus_graph_node.connectNode(const_graph_node_, 1)

	graph.setRoot(plus_graph_node)

	return graph

func __getTestGraph2():
	var plus_function = Function.new()
	plus_function.setFuncSetName("MathFunctionSet")
	plus_function.setFuncName("plusInt")
	plus_function.initDefaultParams()

	var mul_function = Function.new()
	mul_function.setFuncSetName("MathFunctionSet")
	mul_function.setFuncName("mulInt")
	mul_function.initDefaultParams()

	var minus_function = Function.new()
	minus_function.setFuncSetName("MathFunctionSet")
	minus_function.setFuncName("minusInt")
	minus_function.initDefaultParams()

	var graph = FunctionalGraph.new()

	var plus_node = graph.genNode(plus_function)
	var mul_node = graph.genNode(mul_function)
	var minus_node = graph.genNode(minus_function)

	minus_node.connectNode(plus_node, 0)
	minus_node.connectNode(mul_node, 1)

	graph.setRoot(minus_node)

	return graph	

func __getTestGraph3():
	var plus_function = Function.new()
	plus_function.setFuncSetName("MathFunctionSet")
	plus_function.setFuncName("plusInt")
	plus_function.initDefaultParams()

	var graph = FunctionalGraph.new()
	var plus_node = graph.genNode(plus_function)
	graph.setRoot(plus_node)

	return graph

func test_filterTest1():
	var graph = __getTestGraph1()
	
	var filter = Filter.new()
	filter.setGraph(graph)

	assert_eq(filter.exec({}), 7)

func test_filterTest2():
	var graph = __getTestGraph2()
	
	var filter = Filter.new()
	filter.setGraph(graph)

	var dict_map = DictMap.new()
	dict_map.setMap([
		"plusInt_2_0",
		"plusInt_2_1",
		"mulInt_3_0",
		"mulInt_3_1"
	])

	filter.setParamMap(dict_map)
	assert_eq(filter.exec([2, 10, 2, 4]), 4)
	assert_eq(filter.exec([2, 3, 2, 6]), -7)

func test_localFunction():
	var graph1 = __getTestGraph2()
	var graph2 = __getTestGraph3()

	var filter1 = Filter.new()
	var dict_map1 = DictMap.new()
	dict_map1.setMap([
		"plusInt_2_0",
		"plusInt_2_1",
		"mulInt_3_0",
		"mulInt_3_1"
	])
	filter1.setParamMap(dict_map1)
	filter1.setGraph(graph1)

	var filter2 = Filter.new()
	var dict_map2 = DictMap.new()
	dict_map2.setMap([
		"plusInt_1_1",
		"plusInt_1_0"
	])
	filter2.setParamMap(dict_map2)
	filter2.setGraph(graph2)

	var local_function = LocalFunction.new()
	local_function.addFilter(filter1)
	local_function.addFilter(filter2)

	var param_map = ArrangeMap.new()
	param_map.setMap([5, 4, 3, 2, 1, 0])

	local_function.setParamMap(param_map)

	var ret_map = ArrangeMap.new()
	ret_map.setMap([1, 0])

	local_function.setRetMap(ret_map)

	assert_eq(local_function.exec([1, 2, 3, 4, 5, 6]), [3, -1])
