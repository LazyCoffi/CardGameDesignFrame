extends Node2D

var SwitchTargetTable = TypeUnit.type("SwitchTargetTable")
var SubMenuDispatcher = TypeUnit.type("SubMenuDispatcher")
var SubMenuModel = TypeUnit.type("SubMenuModel")
var SubMenuRender = TypeUnit.type("SubMenuRender")
var SubMenuService = TypeUnit.type("SubMenuService")

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
	scene_dispatcher = SubMenuDispatcher.new()
	scene_model = null
	scene_render = SubMenuRender.new()
	scene_service = SubMenuService.new()
	__setRef()

func _ready():
	scene_dispatcher.launch()

func isRuntimeType():
	return true

# is_registered
func isRegistered():
	return is_registered

func register():
	is_registered = true

func unregister():
	is_registered = false

func switchScene(target_scene_name):
	emit_signal("switchSignal", target_scene_name)

func pushScene(target_scene_name):
	emit_signal("pushSignal", target_scene_name)

func popScene():
	emit_signal("popSignal")

# scene_name
func getSceneName():
	return scene_name

func setSceneName(scene_name_):
	scene_name = scene_name_

# dispatcher
func dispatcher():
	return scene_dispatcher

func setDispatcher(scene_dispatcher_):
	scene_dispatcher = scene_dispatcher_

# model
func model():
	return scene_model

func setModel(scene_model_):
	scene_model = scene_model_

# render
func render():
	return scene_render

func setRender(scene_render_):
	scene_model = scene_render_

# service
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
	scene_model = script_tree.getObject("scene_model", SubMenuModel)

func __setRef():
	scene_dispatcher.setRef(self)
	scene_render.setRef(self)
	scene_service.setRef(self)
