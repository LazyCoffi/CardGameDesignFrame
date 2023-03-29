extends Node

var scene_ref

func setRef(scene):
	scene_ref = scene

func render():
	return scene().render()

func scene():
	return scene_ref

func service():
	return scene().service()

func launch():
	# Interface
	return
