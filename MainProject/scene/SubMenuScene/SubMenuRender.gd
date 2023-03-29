extends "res://scene/BaseRender.gd"
class_name SubMenuRender

func setSceneName():
	var scene_name = scene().getSceneName()
	getResumeButton().setSceneName(scene_name)
	getSettingButton().setSceneName(scene_name)
	getExitButton().setSceneName(scene_name)

func loadResource():
	getResumeButton().loadResource()
	getSettingButton().loadResource()
	getExitButton().loadResource()

func getResumeButton():
	return scene().get_node("SubMenuBackgroundRect/ResumeButton")

func getSettingButton():
	return scene().get_node("SubMenuBackgroundRect/SettingButton")

func getExitButton():
	return scene().get_node("SubMenuBackgroundRect/ExitButton")

func setBackground():
	var scene_name = scene().getSceneName()
	var bg = ResourceUnit.loadRes(scene_name, scene_name, "background_rect")
	scene().get_node("SubMenuBackgroundRect").texture = bg
