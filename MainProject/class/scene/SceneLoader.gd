extends Node
class_name SceneLoader

var SceneIndex = TypeUnit.type("SceneIndex")
var ScriptTree = TypeUnit.type("ScriptTree")
var ScenePack = TypeUnit.type("ScenePack")

var scene_index_table 		# Dict

func _init():
	initSceneLoader()

func initSceneLoader():
	var file = File.new()
	var path = "res://scripts/system/scene_index_table.json"

	if file.file_exists(path):
		var script_tree = ScriptTree.new()
		script_tree.loadFromJson(path)
		scene_index_table = script_tree.getObjectDict("scene_index_table", SceneIndex)
	else:
		scene_index_table = {}

func loadScene(scene_name):
	var scene_index = scene_index_table[scene_name]

	var scene_type_name = scene_index.getType()
	var scene_type = TypeUnit.type(scene_type_name)
	var scene = scene_type.instance()
	scene.setSceneName(scene_name)

	var path = "res://scripts/scene/" + scene_name + ".json"
	var script_tree = ScriptTree.new()
	script_tree.loadFromJson(path)

	scene.loadScript(script_tree)

	var scene_pack = ScenePack.new()
	scene_pack.setType(scene_type_name)
	scene_pack.setSceneName(scene_name)
	scene_pack.setScene(scene)

	return scene_pack
