extends Node
class_name BaseRender

var Emitter = TypeUnit.type("Emitter")
var ComponentPack = TypeUnit.type("ComponentPack")

var scene_ref

func setRef(scene):
	scene_ref = scene

func scene():
	return scene_ref

func sceneName():
	return scene().getSceneName()

func model():
	return scene_ref.model()

func service():
	return scene_ref.service()

func dispatcher():
	return scene_ref.dispatcher()

