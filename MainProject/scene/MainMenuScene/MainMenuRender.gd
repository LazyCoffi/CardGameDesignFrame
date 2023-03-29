extends "res://scene/BaseRender.gd"
class_name MainMenuRender

func setSceneName():
	var scene_name = scene().getSceneName()
	scene().get_node("StartButton").setSceneName(scene_name)
	scene().get_node("ContinueButton").setSceneName(scene_name)
	scene().get_node("SettingButton").setSceneName(scene_name)
	scene().get_node("ExitButton").setSceneName(scene_name)

func loadResource():
	scene().get_node("StartButton").loadResource()
	scene().get_node("ContinueButton").loadResource()
	scene().get_node("SettingButton").loadResource()
	scene().get_node("ExitButton").loadResource()

func getStartButton():
	return scene().get_node("StartButton")

func getContinueButton():
	return scene().get_node("ContinueButton")

func getSettingButton():
	return scene().get_node("SettingButton")

func getExitButton():
	return scene().get_node("ExitButton")

func renderTitle():
	var scene_name = scene().getSceneName()
	var title = ResourceUnit.loadRes(scene_name, scene_name, "title")
	scene().get_node("MainMenuTitle").texture = title

func renderBackground():
	var scene_name = scene().getSceneName()
	var background = ResourceUnit.loadRes(scene_name, scene_name, "background")
	scene().get_node("MainMenuBackground").texture = background
