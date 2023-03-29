extends "res://scene/BaseDispatcher.gd"
class_name SubMenuDispatcher

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
