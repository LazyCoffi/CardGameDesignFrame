extends "res://scene/BaseService.gd"
class_name MainMenuService

func start():
	model().startFunction(scene())

func continue():
	model().continueFunction(scene())

func setting():
	model().settingFunction(scene())

func exit():
	model().exitFunction(scene())
