extends Node
class_name MainMenuService

var scene_ref
var model_ref

func setRef(scene):
	scene_ref = scene
	model_ref = scene.model()
