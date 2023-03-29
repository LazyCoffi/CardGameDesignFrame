extends "res://scene/BaseScene.gd"

var SubMenuDispatcher = TypeUnit.type("SubMenuDispatcher")
var SubMenuModel = TypeUnit.type("SubMenuModel")
var SubMenuRender = TypeUnit.type("SubMenuRender")
var SubMenuService = TypeUnit.type("SubMenuService")

func _init():
	is_registered = false
	scene_dispatcher = SubMenuDispatcher.new()
	scene_model = null
	scene_render = SubMenuRender.new()
	scene_service = SubMenuService.new()
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
	scene_model = script_tree.getObject("scene_model", SubMenuModel)
