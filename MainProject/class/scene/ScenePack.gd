extends Node
class_name ScenePack

var type
var scene_name
var scene

func getType():
	return type

func setType(type_):
	type = type_

func getSceneName():
	return scene_name

func setSceneName(scene_name_):
	scene_name = scene_name_

func getScene():
	return scene

func setScene(scene_):
	scene = scene_

func pack():
	var script_tree = ScriptTree.new()

	script_tree.addAttr("type", type)
	script_tree.addAttr("scene_name", scene_name)
	script_tree.addObject("scene", scene)
	
	return script_tree

func loadScript(script_tree):
	type = script_tree.getStr("type")
	var scene_type = TypeUnit.type(type)
	scene_name = script_tree.getStr("scene_name")
	scene = script_tree.getObject("scene", scene_type)
