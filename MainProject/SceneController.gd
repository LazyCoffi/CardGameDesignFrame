extends Node

var cur_scene

func _ready():
	pass

func registerScene(scene):
	if scene.isRegistered():
		return
	scene.connect("changeSceneSignal", self, "changeScene")
	scene.register()

func changeScene(scene):
	if not scene.isRegistered():
		registerScene(scene)
		
	if cur_scene != null:
		remove_child(cur_scene)
	
	add_child(scene)
	cur_scene = scene
