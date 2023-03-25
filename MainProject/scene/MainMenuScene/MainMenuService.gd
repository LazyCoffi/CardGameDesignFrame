extends Node
class_name MainMenuService

var scene_ref

func setRef(scene):
	scene_ref = scene

func scene():
	return scene_ref

func model():
	return scene_ref.model()

func start():
	model().startFunction(scene())

func continue():
	model().continueFunction(scene())

func setting():
	model().settingFunction(scene())

func exit():
	model().exitFunction(scene())
