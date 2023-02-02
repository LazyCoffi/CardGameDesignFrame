extends Node
class_name MainMenuRender

var scene_ref
var model_ref

func setRef(scene):
	scene_ref = scene
	model_ref = scene.model()

func setSceneName():
	var scene_name = scene_ref.getSceneName()
	scene_ref.get_node("StartButton").setSceneName(scene_name)
	scene_ref.get_node("ContinueButton").setSceneName(scene_name)
	scene_ref.get_node("SettingButton").setSceneName(scene_name)
	scene_ref.get_node("ExitButton").setSceneName(scene_name)

func loadResource():
	scene_ref.get_node("StartButton").loadResource()
	scene_ref.get_node("ContinueButton").loadResource()
	scene_ref.get_node("SettingButton").loadResource()
	scene_ref.get_node("ExitButton").loadResource()

func setTitle():
	var scene_name = scene_ref.getSceneName()
	var title = ResourceUnit.loadTexture(scene_name, scene_name, "title")
	scene_ref.get_node("MainMenuTitle").texture = title

func setBackground():
	var scene_name = scene_ref.getSceneName()
	var bg = ResourceUnit.loadTexture(scene_name, scene_name, "background")
	scene_ref.get_node("MainMenuBackground").texture = bg
