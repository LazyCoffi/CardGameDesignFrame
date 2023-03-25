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
