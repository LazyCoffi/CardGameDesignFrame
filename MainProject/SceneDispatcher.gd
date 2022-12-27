extends Node

var cur_scene

func _ready():
	pass

func registerScene(scene):
	if scene.isRegistered():
		return
	scene.connect("switchSceneSignal", self, "switchScene")
	scene.register()

func switch(scene_name):
	if cur_scene != null:
		SceneCache.store(cur_scene)
	
	__switchScene(scene_name)

func switchWithoutRefresh(scene_name):
	__switchScene(scene_name)

func __switchScene(scene_name):
	var scene_node = SceneCache.getScene(scene_name)
	var	scene = scene_node["scene"]

	if not scene.isRegistered():
		registerScene(scene)
		
	if cur_scene != null:
		remove_child(cur_scene)

	add_child(scene)
	cur_scene = scene
