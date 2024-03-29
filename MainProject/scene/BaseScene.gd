extends Node2D
class_name BaseScene

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

func _ready():
	scene_dispatcher.launch()

func isRuntimeType():
	# Interface
	return

func isRegistered():
	return is_registered

func register():
	is_registered = true

func unregister():
	is_registered = false

func switchScene(next_scene_name):
	emit_signal("switchSignal", next_scene_name)

func pushScene(next_scene_name):
	emit_signal("pushSignal", next_scene_name)

func popScene():
	emit_signal("popSignal")

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

func __setRef():
	scene_dispatcher.setRef(self)
	scene_render.setRef(self)
	scene_service.setRef(self)
