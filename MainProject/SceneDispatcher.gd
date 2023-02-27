extends Node
var ScriptTree = load("res://class/entity/ScriptTree.gd")

func registerScene(scene):
	if scene.isRegistered():
		return

	scene.connect("switchSignal", self, "switch")
	scene.connect("pushSignal", self, "push")
	scene.connect("popSignal", self, "pop")
	scene.register()

func unregisterScene(scene):
	if not scene.isRegistered():
		return
	
	scene.disconnect("switchSignal", self, "switch")
	scene.disconnect("pushSignal", self, "push")
	scene.disconnect("popSignal", self, "pop")
	scene.unregister()

func loadArchive(archive_name):
	while SceneManager.hasScene():
		var former_scene = SceneManager.popScene()
		unregisterScene(former_scene)
		remove_child(former_scene)
	
	SceneManager.loadArchive(archive_name)

	var scene_stack = SceneManager.peekSceneStack()
	for scene in scene_stack:
		registerScene(scene)
		add_child(scene)
	
func switch(scene_name):
	while SceneManager.hasScene():
		var former_scene = SceneManager.popScene()
		unregisterScene(former_scene)
		remove_child(former_scene)
		
	var scene = SceneManager.getScene(scene_name)
	if not scene.isRegistered():
		registerScene(scene)

	add_child(scene)
	SceneManager.pushScene(scene_name)

func push(scene_name):
	var scene = SceneManager.getScene(scene_name)

	if not scene.isRegistered():
		registerScene(scene)
	
	add_child(scene)
	SceneManager.pushScene(scene_name)

func pop():
	var scene = SceneManager.popScene()
	unregisterScene(scene)
	remove_child(scene)
