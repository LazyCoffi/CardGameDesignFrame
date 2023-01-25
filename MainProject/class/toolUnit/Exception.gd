extends Node

var scene_tree 

func setSceneTree(scene_tree_):
	scene_tree = scene_tree_

func assert(flag, msg := ""):
	if flag == true:
		return
	push_error("Exception error: " + msg)
	print_debug("Stack trace")
