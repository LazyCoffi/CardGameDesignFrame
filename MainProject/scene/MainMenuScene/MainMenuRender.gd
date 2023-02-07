extends Node
class_name MainMenuRender

var scene_ref

func setRef(scene):
	scene_ref = scene

func scene():
	return scene_ref

func model():
	return scene_ref.model()

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

func setTitle():
	var scene_name = scene().getSceneName()
	var title = ResourceUnit.loadRes(scene_name, scene_name, "title")
	scene().get_node("MainMenuTitle").texture = title

func setBackground():
	var scene_name = scene().getSceneName()
	var bg = ResourceUnit.loadRes(scene_name, scene_name, "background")
	scene().get_node("MainMenuBackground").texture = bg
