extends Node
class_name MainMenuDispatcher

var scene_ref

func setRef(scene):
	scene_ref = scene

func render():
	return scene_ref.render()

func service():
	return scene_ref.service()

func launch():
	renderMainMenu()

func renderMainMenu():
	render().setSceneName()
	render().loadResource()
	render().setTitle()
	render().setBackground()

	# TODO
