extends "res://scene/BaseScene.gd"

var MainMenuDispatcher = TypeUnit.type("MainMenuDispatcher")
var MainMenuModel = TypeUnit.type("MainMenuModel")
var MainMenuRender = TypeUnit.type("MainMenuRender")
var MainMenuService = TypeUnit.type("MainMenuService")

func _init():
	is_registered = false
	scene_dispatcher = MainMenuDispatcher.new()
	scene_model = null
	scene_render = MainMenuRender.new()
	scene_service = MainMenuService.new()
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
	scene_model = script_tree.getObject("scene_model", MainMenuModel)
