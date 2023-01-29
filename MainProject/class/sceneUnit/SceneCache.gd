extends Node

var SceneFactory = load("res://class/sceneUnit/SceneFactory.gd")
var ScriptTree = load("res://class/entity/ScriptTree.gd")

var scene_cache		# SceneNode_Dict
var cur_scene_name	# String
var scene_factory	# SceneFactory

class SceneNode:
	var type
	var scene_name
	var scene

	func getType():
		return type
	
	func getSceneName():
		return scene_name
	
	func getScene():
		return scene
	
	func setType(type_):
		type = type_
	
	func setSceneName(scene_name_):
		scene_name = scene_name_
	
	func setScene(scene_):
		scene = scene_

	func pack():
		var script_tree = ScriptTree.new()

		script_tree.addAttr("type", type)
		script_tree.addAttr("scene_name", scene_name)
		script_tree.addObject("scene", scene)
		
		return script_tree
	
	func loadScript(script_tree):
		type = script_tree.getAttr("type")
		var scene_type = TypeUnit.getTypeByName(type)
		scene_name = script_tree.getAttr("scene_name")
		scene = script_tree.getObject("scene", scene_type)
	
	func initScript(script_tree):
		loadScript(script_tree)

func _init():
	scene_cache = {}
	scene_factory = SceneFactory.new()

func genSceneNode(type, scene_name, scene):
	var scene_node = SceneNode.new()	
	scene_node.type = type
	scene_node.scene_name = scene_name
	scene_node.scene = scene

	return scene_node

func hasCurScene():
	return cur_scene_name != null

func getCurSceneName():
	return cur_scene_name

func getCurScene():
	return scene_cache[cur_scene_name].getScene()

func getCurSceneType():
	return scene_cache[cur_scene_name].getType()

func setCurScene(scene_name):
	cur_scene_name = scene_name

func store(scene_node):
	var scene_name = scene_node.getSceneName()
	if scene_cache.has(scene_name):
		delete(scene_name)
	
	scene_cache[scene_name] = scene_node

func delete(scene_name):
	if not scene_cache.has(scene_name):
		return

	scene_cache[scene_name].getScene().free()
	scene_cache.erase(scene_name)

func get(scene_name):
	if not scene_cache.has(scene_name):
		create(scene_name)

	return scene_cache[scene_name]
		
func create(scene_name):
	scene_cache[scene_name] = scene_factory.getSceneNode(scene_name)

func fetchParam(scene_name, param_name):
	var scene = get(scene_name)
	return scene.model().getParam(param_name)

func callService(scene_name, func_name, params):
	var scene = get(scene_name)
	return scene.service().callv(func_name, params)

func pack():
	var script_tree = ScriptTree.new()

	script_tree.addObjectDict("scene_cache", scene_cache)
	script_tree.addAttr("cur_scene_name", cur_scene_name)

	return script_tree

func loadScript(script_tree):
	scene_cache = script_tree.getObjectDict("scene_cache", SceneNode)
	cur_scene_name = script_tree.getStr("cur_scene_name")
