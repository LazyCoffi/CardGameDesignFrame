extends Node
class_name ArchiveRender

var scene_ref

func setRef(scene):
	scene_ref = scene

func scene():
	return scene_ref

func model():
	return scene_ref.model()

func vbox():
	return scene().get_node("VBoxContainer")


