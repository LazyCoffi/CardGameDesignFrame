extends GutTest

var ScriptTree = TypeUnit.type("ScriptTree")

func before_all():
	CardCache.initScript()
	GlobalSetting.initScript()
	ResourceUnit.initScript()

func test_loadFromJson():
	var path = "res://test/testFile/sample_json.json"
	var script_tree = ScriptTree.new()
	script_tree.loadFromJson(path)
	pass_test("Json load success")

func test_getAttr():
	var path = "res://test/testFile/sample_json.json"
	var script_tree = ScriptTree.new()
	script_tree.loadFromJson(path)
	assert_eq(script_tree.getBool("true"), true)
	assert_eq(script_tree.getBool("false"), false)
	assert_eq(script_tree.getInt("int"), 123)
	assert_eq(script_tree.getFloat("float"), 123.456)
	assert_eq(script_tree.getStr("string"), "hello")
	assert_eq(script_tree.getIntArray("int_array"), [1, 2, 3])
	assert_eq(script_tree.getFloatArray("float_array"), [1.1, 2.2, 3.3])
	assert_eq_deep(script_tree.getIntDict("object"), {"1" : 1, "2": 2, "3" : 3})

func test_addAttr():
	var script_tree = ScriptTree.new()
	script_tree.addAttr("true", true)
	script_tree.addAttr("false", false)
	script_tree.addAttr("int", 1)
	script_tree.addAttr("float", 1.1)
	script_tree.addAttr("string", "hello")
	script_tree.addAttr("int_array", [1, 2, 3])
	script_tree.addAttr("object", {"1" : 1, "2" : 2, "3" : 3})

	script_tree.exportAsJson("res://test/testFile/sample_json_output.json")

	pass_test("Json export success")

class InnerClass:
	var int_attr
	var str_attr

	func pack():
		var script_tree = ScriptTree.new()

		script_tree.addAttr("int_attr", int_attr)
		script_tree.addAttr("str_attr", str_attr)
	
		return script_tree
	
	func loadScript(script_tree):
		int_attr = script_tree.getInt("int_attr")
		str_attr = script_tree.getStr("str_attr")
	
class TypeClass:
	var inner_class
	var param_type

	func setParamType(param_type_):
		param_type = param_type_
	
	func pack():
		var script_tree = ScriptTree.new()

		script_tree.addObject("inner_class", inner_class)
		
		return script_tree
	
	func loadScript(script_tree):
		inner_class = script_tree.getObject("inner_class", param_type)

class TestClass:
	var int_attr
	var float_attr
	var str_attr
	var inner_attr
	var type_attr

	func pack():
		var script_tree = ScriptTree.new()

		script_tree.addAttr("int_attr", int_attr)
		script_tree.addAttr("float_attr", float_attr)
		script_tree.addAttr("str_attr", str_attr)
		script_tree.addObject("inner_attr", inner_attr)
		script_tree.addTypeObject("type_attr", type_attr)

		return script_tree
	
	func loadScript(script_tree):
		int_attr = script_tree.getInt("int_attr")
		float_attr = script_tree.getFloat("float_attr")
		str_attr = script_tree.getStr("str_attr")
		inner_attr = script_tree.getObject("inner_attr", InnerClass)
		type_attr = script_tree.getTypeObject("type_attr", TypeClass, InnerClass)

func test_objectLoad():
	var test_class = TestClass.new()

	test_class.int_attr = 1
	test_class.float_attr = 1.1
	test_class.str_attr = "hello"
	
	var inner_class_a = InnerClass.new()
	inner_class_a.int_attr = 2
	inner_class_a.str_attr = "echo"

	test_class.inner_attr = inner_class_a
	
	var inner_class_b = InnerClass.new()
	inner_class_b.int_attr = 3
	inner_class_b.str_attr = "fly"

	var type_class = TypeClass.new()
	type_class.param_type = InnerClass

	type_class.inner_class = inner_class_b

	test_class.type_attr = type_class

	var script_tree = test_class.pack()

	script_tree.exportAsJson("res://test/testFile/object_json_output.json")

	assert_eq(script_tree.getInt("int_attr"), 1)
	assert_eq(script_tree.getFloat("float_attr"), 1.1)
	assert_eq(script_tree.getStr("str_attr"), "hello")
	assert_eq_deep(script_tree.getRawAttr("inner_attr"), {"int_attr" : 2, "str_attr" : "echo"})
	assert_eq_deep(script_tree.getRawAttr("type_attr"), {"inner_class" : {"int_attr" : 3, "str_attr" : "fly"}})

func test_getObject():
	var script_tree = ScriptTree.new()
	script_tree.loadFromJson("res://test/testFile/sample_object_json.json")

	var test_class = TestClass.new()
	test_class.loadScript(script_tree)

	assert_eq(test_class.int_attr, 1)
	assert_eq(test_class.float_attr, 1.1)
	assert_eq(test_class.str_attr, "hello")
	assert_eq(test_class.inner_attr.int_attr, 2)
	assert_eq(test_class.inner_attr.str_attr, "echo")
	assert_eq(test_class.type_attr.inner_class.int_attr, 3)
	assert_eq(test_class.type_attr.inner_class.str_attr, "fly")
