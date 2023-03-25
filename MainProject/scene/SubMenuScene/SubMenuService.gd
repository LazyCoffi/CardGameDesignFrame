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
	model().resumeFunction()

func setting():
	model().settingFunction()

func exit():
	model().exitFunction()
