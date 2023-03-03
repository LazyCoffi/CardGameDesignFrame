extends Node

var ScriptTree = load("res://class/entity/ScriptTree.gd")

var init_scene_name		# String 
var screen_size			# Array

func _init():
	init_scene_name = ""
	screen_size = []

func getInitSceneName():
	return init_scene_name

func setInitSceneName(init_scene_name_):
	init_scene_name = init_scene_name_

func getScreenSize():
	return screen_size

func setScreenSize(screen_size_):
	screen_size = screen_size_

func pack():
	var script_tree = ScriptTree.new()

	script_tree.addAttr("init_scene_name", init_scene_name)
	script_tree.addAttr("screen_size", screen_size)

	return script_tree

func loadScript(script_tree):
	init_scene_name = script_tree.getStr("init_scene_name")
	screen_size = script_tree.getIntArray("screen_size")

func initScript():
	var path = "res://scripts/system/global_setting.json"
	var file = File.new()
	if file.file_exists(path):
		var script_tree = ScriptTree.new()
		script_tree.loadFromJson(path)
		loadScript(script_tree)
