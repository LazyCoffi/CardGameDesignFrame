extends Node
class_name SubMenuRender

var scene_ref

func setRef(scene):
	scene_ref = scene

func scene():
	return scene_ref

func model():
	return scene_ref.model()

func setSceneName():
	var scene_name = scene().getSceneName()
	scene().get_node("ResumeButton").setSceneName(scene_name)
	scene().get_node("LoadButton").setSceneName(scene_name)
	scene().get_node("SettingButton").setSceneName(scene_name)
	scene().get_node("MainMenuButton").setSceneName(scene_name)

func loadResource():
	scene().get_node("ResumeButton").loadResource()
	scene().get_node("LoadButton").loadResource()
	scene().get_node("SettingButton").loadResource()
	scene().get_node("MainMenuButton").loadResource()

func getResumeButton():
	return scene().get_node("ResumeButton")

func setBackground():
	var scene_name = scene().getSceneName()
	var bg = ResourceUnit.loadRes(scene_name, scene_name, "background_rect")
	scene().get_node("SubMenuBackgroundRect").texture = bg

