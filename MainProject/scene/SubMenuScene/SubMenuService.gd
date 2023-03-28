extends Node
class_name SubMenuService

var scene_ref

func setRef(scene):
	scene_ref = scene

func scene():
	return scene_ref

func model():
	return scene_ref.model()

func resume():
	model().resumeFunction(scene())

func setting():
	model().settingFunction(scene())

func exit():
	model().exitFunction(scene())
