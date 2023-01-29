extends Node

var ScriptTree = load("res://class/entity/ScriptTree.gd")

func _ready():
	pass

func registerScene(scene):
	if scene.isRegistered():
		return

	scene.connect("switchSignal", self, "switch")
	scene.connect("switchWithoutRefreshSignal", self, "switchWithoutRefresh")
	scene.connect("switchWithCleanSignal", self, "switchWithClean")

	scene.register()

func switch(scene_name):
	if not SceneCache.hasCurScene():
		SceneCache.setCurScene(scene_name)
	
	__switchScene(scene_name)

func switchWithoutRefresh(scene_name):
	__switchScene(scene_name)

func switchWithClean(scene_name):
	SceneCache.delete(scene_name)

	__switchScene(scene_name)

func __switchScene(scene_name):
	var scene_node = SceneCache.get(scene_name)
	var	scene = scene_node.getScene()

	if not scene.isRegistered():
		registerScene(scene)
		
	if SceneCache.hasCurScene():
		var cur_scene = SceneCache.getCurScene()
		remove_child(cur_scene)

	add_child(scene)
	SceneCache.setCurScene(scene_name)
