extends Node
class_name MainMenuDispatcher

var render_ref
var service_ref

func setRef(scene):
	render_ref = scene.render()
	service_ref = scene.service()

func launch():
	renderMainMenu()

func renderMainMenu():
	render_ref.setSceneName()
	render_ref.loadResource()
	render_ref.setTitle()
	render_ref.setBackground()

	# TODO
