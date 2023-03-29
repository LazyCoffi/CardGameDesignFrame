extends "res://scene/BaseScene.gd"

var ExploreMapDispatcher = TypeUnit.type("ExploreMapDispatcher")
var ExploreMapModel = TypeUnit.type("ExploreMapModel")
var ExploreMapRender = TypeUnit.type("ExploreMapRender")
var ExploreMapService = TypeUnit.type("ExploreMapService")


func _init():
	is_registered = false
	scene_dispatcher = ExploreMapDispatcher.new()
	scene_model = null
	scene_render = ExploreMapRender.new()
	scene_service = ExploreMapService.new()
	__setRef()

func isRuntimeType():
	return false

func pack():
	var script_tree = ScriptTree.new()

	script_tree.addAttr("scene_name", scene_name)
	script_tree.addObject("scene_model", scene_model)

	return script_tree

func loadScript(script_tree):
	scene_name = script_tree.getStr("scene_name")
	scene_model = script_tree.getObject("scene_model", ExploreMapModel)
