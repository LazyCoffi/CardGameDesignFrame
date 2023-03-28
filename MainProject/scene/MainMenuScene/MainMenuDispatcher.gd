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
	render().renderTitle()
	render().renderBackground()

	emitStartSignal()
	emitContinueSignal()
	emitSettingSignal()
	emitExitSignal()

func emitStartSignal():
	render().getStartButton().connect("pressed", self, "start")

func start():
	service().start()

func emitContinueSignal():
	render().getContinueButton().connect("pressed", self, "continue")

func continue():
	service().continue()

func emitSettingSignal():
	render().getSettingButton().connect("pressed", self, "setting")

func setting():
	service().setting()

func emitExitSignal():
	render().getExitButton().connect("pressed", self, "exit")

func exit():
	service().exit()
