extends Node
class_name MainMenuRender

var scene_ref
var model_ref

func setRef(scene):
	scene_ref = scene
	model_ref = scene.model()

func setSceneName():
	scene_ref.$StartButton.setSceneName(scene_name)
	scene_ref.$ContinueButton.setSceneName(scene_name)
	scene_ref.$SettingButton.setSceneName(scene_name)
	scene_ref.$ExitButton.setSceneName(scene_name)

func loadResource():
	scene_ref.$StartButton.loadResource()
	scene_ref.$ContinueButton.loadResource()
	scene_ref.$SettingButton.loadResource()
	scene_ref.$ExitButton.loadResource()
	__setBackground()
	__setTitle()

func setTitle():
	var title = ResourceUnit.loadTexture(scene_name, scene_name, "title")
	scene_ref.$MainMenuTitle.texture = title

func setBackground():
	var bg = ResourceUnit.loadTexture(scene_name, scene_name, "background")
	scene_ref.$MainMenuBackground.texture = bg
