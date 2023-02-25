extends Node
class_name ArchiveService

var scene_ref

func setRef(scene):
	scene_ref = scene

func scene():
	return scene_ref

func model():
	return scene_ref.model()

func getArchiveList():
	pass
