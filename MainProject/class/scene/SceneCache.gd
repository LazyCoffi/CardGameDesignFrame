extends Node

var ScriptTree = TypeUnit.type("ScriptTree")
var ScenePack = TypeUnit.type("ScenePack")

var cache				# ScenePack_Dict
var scene_stack			# Array

func _init():
	cache = {}
	scene_stack = []

func empty():
	return scene_stack.empty()

func peek():
	return scene_stack.duplicate()

func top():
	return scene_stack.back()

func push(scene_name):
	scene_stack.push_back(scene_name)

func pop():
	var top_scene_name = scene_stack.pop_back()
	var top_scene = cache[top_scene_name].getScene()
	if top_scene.isRuntimeType():
		delete(top_scene_name)
	
	return top_scene_name

func store(scene_pack):
	var scene_name = scene_pack.getSceneName()
	if cache.has(scene_name):
		delete(scene_name)
	
	cache[scene_name] = scene_pack

func delete(scene_name):
	if not cache.has(scene_name):
		return

	cache.erase(scene_name)

func get(scene_name):
	return cache[scene_name]

func has(scene_name):
	return cache.has(scene_name)

func pack():
	var archive_cache = {}
	var archive_scene_stack = []
	
	for scene_name in cache.keys():
		var scene_pack = get(scene_name)
		var scene = scene_pack.getScene()
		if not scene.isRuntimeType():
			archive_cache[scene_name] = scene_pack

	for scene_name in scene_stack:
		var scene_pack = get(scene_name)
		var scene = scene_pack.getScene()
		if not scene.isRuntimeType():
			archive_scene_stack.append(scene_name)

	var script_tree = ScriptTree.new()

	script_tree.addObjectDict("cache", archive_cache)
	script_tree.addAttr("scene_stack", archive_scene_stack)

	return script_tree

func loadScript(script_tree):
	cache = script_tree.getObjectDict("cache", ScenePack)
	scene_stack = script_tree.getStrArray("scene_stack")
