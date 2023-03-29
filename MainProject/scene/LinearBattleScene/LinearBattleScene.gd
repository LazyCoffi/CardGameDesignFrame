extends "res://scene/BaseScene.gd"

var LinearBattleDispatcher = TypeUnit.type("LinearBattleDispatcher")
var LinearBattleModel = TypeUnit.type("LinearBattleModel")
var LinearBattleRender = TypeUnit.type("LinearBattleRender")
var LinearBattleService = TypeUnit.type("LinearBattleService")

func _init():
	is_registered = false
	scene_dispatcher = LinearBattleDispatcher.new()
	scene_model = null
	scene_render = LinearBattleRender.new()
	scene_service = LinearBattleService.new()
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
	scene_model = script_tree.getObject("scene_model", LinearBattleModel)
