extends Node

var ScriptTree = load("res://class/entity/ScriptTree.gd")

func _ready():
	pass

func registerScene(scene):
	if scene.isRegistered():
		return

	scene.connect("switchSignal", self, "switch")
	scene.connect("pushSignal", self, "push")
	scene.connect("popSignal", self, "pop")
	scene.register()

func switch(top_scene_name):
	var top_scene = SceneCache.get(top_scene_name).getScene()
			
	while SceneCache.hasScene():
		var former_top_scene = SceneCache.popTopScene()
		remove_child(former_top_scene)
		
	if not top_scene.isRegistered():
		registerScene(top_scene)

	add_child(top_scene)
	SceneCache.pushTopSceneName(top_scene_name)

func push(top_scene_name):
	var top_scene = SceneCache.get(top_scene_name).getScene()

	if not top_scene.isRegistered():
		registerScene(top_scene)
	
	add_child(top_scene)
	SceneCache.pushTopSceneName(top_scene_name)

func pop():
	var top_scene = SceneCache.popTopScene()
	remove_child(top_scene)
