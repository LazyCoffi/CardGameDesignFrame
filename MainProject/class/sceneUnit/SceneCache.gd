extends Node

var SceneFactory = load("res://class/sceneUnit/SceneFactory.gd")

var scene_container
var cur_scene
var scene_factory

##	INFO: scene_node内部结构
##	{
##		"type",
##		"scene_name",
##		"scene"
##	}

func _init():
	scene_container = {}
	scene_factory = SceneFactory.new()

func storeScene(scene_node):
	var scene_name = scene_node["scene_name"]
	if scene_container.has(scene_name):
		deleteScene(scene_name)
	
	scene_container[scene_name] = scene_node

func deleteScene(scene_name):
	if not scene_container.has(scene_name):
		return

	scene_container[scene_name]["scene"].free()
	scene_container.erase(scene_name)

func getScene(scene_name):
	if not scene_container.has(scene_name):
		loadScene(scene_name)

	return scene_container[scene_name]
		
func loadScene(scene_name):
	scene_container[scene_name] = scene_factory.getSceneNode(scene_name)
