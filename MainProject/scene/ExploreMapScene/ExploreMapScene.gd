extends Node2D

var ExploreMapDispatcher = TypeUnit.type("ExploreMapDispatcher")
var ExploreMapModel = TypeUnit.type("ExploreMapModel")
var ExploreMapRender = TypeUnit.type("ExploreMapRender")
var ExploreMapService = TypeUnit.type("ExploreMapService")
var SwitchTargetTable = TypeUnit.type("SwitchTargetTable")
var ScriptTree = TypeUnit.type("ScriptTree")

signal switchSignal
signal pushSignal
signal popSignal

var is_registered
var scene_name

var scene_dispatcher
var scene_model
var scene_render
var scene_service

func _init():
	is_registered = false
	scene_dispatcher = ExploreMapDispatcher.new()
	scene_model = null
	scene_render = ExploreMapRender.new()
	scene_service = ExploreMapService.new()
	__setRef()

func _ready():
	dispatcher().launch()

func switchScene(next_scene_name):
	emit_signal("switchSignal", next_scene_name)

func pushScene(next_scene_name):
	emit_signal("pushSignal", next_scene_name)

func popScene():
	emit_signal("popSignal")

func isRuntimeType():
	return false

func isRegistered():
	return is_registered

func register():
	is_registered = true

func unregister():
	is_registered = false

# scene_name
func getSceneName():
	return scene_name

func setSceneName(scene_name_):
	scene_name = scene_name_

# scene_dispatcher
func dispatcher():
	return scene_dispatcher

func setDispatcher(scene_dispatcher_):
	scene_dispatcher = scene_dispatcher_

# scene_model
func model():
	return scene_model

func setModel(scene_model_):
	scene_model = scene_model_

# scene_render
func render():
	return scene_render

func setRender(scene_render_):
	scene_render = scene_render_

# scene_service
func service():
	return scene_service

func setService(scene_service_):
	scene_service = scene_service_

func pack():
	var script_tree = ScriptTree.new()

	script_tree.addAttr("scene_name", scene_name)
	script_tree.addObject("scene_model", scene_model)

	return script_tree

func loadScript(script_tree):
	scene_name = script_tree.getStr("scene_name")
	scene_model = script_tree.getObject("scene_model", ExploreMapModel)

func __setRef():
	scene_dispatcher.setRef(self)
	scene_render.setRef(self)
	scene_service.setRef(self)
