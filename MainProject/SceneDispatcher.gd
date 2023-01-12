extends Node

var cur_scene

func _ready():
	pass

func registerScene(scene):
	if scene.isRegistered():
		return
	scene.connect("switchSignal", self, "switch")
	scene.connect("switchWithoutRefreshSignal", self, "switchWithoutRefresh")
	scene.register()

func switch(scene_name, scene_pack):
	if cur_scene != null:
		SceneCache.store(cur_scene)
	
	__switchScene(scene_name, scene_pack)

func switchWithoutRefresh(scene_name, scene_pack):
	__switchScene(scene_name, scene_pack)

func __switchScene(scene_name, scene_pack):
	var scene_node = SceneCache.getScene(scene_name)
	var	scene = scene_node["scene"]
	scene.refreshScenePack(scene_pack)

	if not scene.isRegistered():
		registerScene(scene)
		
	if cur_scene != null:
		remove_child(cur_scene)

	add_child(scene)
	cur_scene = scene
