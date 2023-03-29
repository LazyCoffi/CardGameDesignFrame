extends "res://scene/BaseScene.gd"
class_name DialogScene

var DialogDispatcher = TypeUnit.type("DialogDispatcher")
var DialogModel = TypeUnit.type("DialogModel")
var DialogRender = TypeUnit.type("DialogRender")
var DialogService = TypeUnit.type("DialogService")

func _init():
	is_registered = false
	scene_dispatcher = DialogDispatcher.new()
	scene_model = null
	scene_render = DialogRender.new()
	scene_service = DialogService.new()
	__setRef()

func isRuntimeType():
	return true

func pack():
	var script_tree = ScriptTree.new()

	script_tree.addAttr("scene_name", scene_name)
	script_tree.addObject("scene_model", scene_model)

	return script_tree

func loadScript(script_tree):
	scene_name = script_tree.getStr("scene_name")
	scene_model = script_tree.getObject("scene_model", DialogModel)
