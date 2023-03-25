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

func renderSubMenu():
	render().setSceneName()
	render().loadResource()
	render().setBackground()

	emitResumeSignal()
	emitSettingSignal()
	emitExitSignal()

func emitResumeSignal():
	render().getResumeButton().connect("pressed", self, "resume")

func resume():
	service().resume()

func emitSettingSignal():
	render().getSettingButton().connect("pressed", self, "setting")

func setting():
	service().setting()

func emitExitSignal():
	render().getExitButton().connect("pressed", self, "exit")

func exit():
	service().exit()
