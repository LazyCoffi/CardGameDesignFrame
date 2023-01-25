extends GutTest

var ScriptTree = load("res://class/entity/ScriptTree.gd")

func test_loadFromJson():
	var path = "res://test/testFile/sample_json.json"
	var script_tree = ScriptTree.new()
	script_tree.loadFromJson(path)
	pass_test("Json load success")

func test_getAttr():
	var path = "res://test/testFile/sample_json.json"
	var script_tree = ScriptTree.new()
	script_tree.loadFromJson(path)
	assert_eq(script_tree.getAttr("true"), true)
	assert_eq(script_tree.getAttr("false"), false)
	assert_eq(script_tree.getAttr("number"), 123)
	assert_eq(script_tree.getAttr("string"), "hello")
	assert_eq(script_tree.getAttr("array"), [1, 2, 3])
	assert_eq(script_tree.getAttr("object"), {"1" : 1, "2": 2, "3" : 3})
