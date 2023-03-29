extends "res://scene/BaseService.gd"
class_name SubMenuService

func resume():
	model().resumeFunction(scene())

func setting():
	model().settingFunction(scene())

func exit():
	model().exitFunction(scene())
