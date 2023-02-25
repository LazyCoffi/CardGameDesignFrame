extends Node
class_name SubMenuDispatcher

var scene_ref

func setRef(scene):
	scene_ref = scene

func scene():
	return scene_ref

func render():
	return scene_ref.render()

func service():
	return scene_ref.service()

func launch():
	renderSubMenu()
	initResumeButton()

func renderSubMenu():
	render().setSceneName()
	render().loadResource()
	render().setBackground()

func initResumeButton():
	var resume_button = render().getResumeButton()
	resume_button.connect("pressed", scene(), "resume")
