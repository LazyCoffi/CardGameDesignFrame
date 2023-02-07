extends Node

var ScriptTree = load("res://class/entity/ScriptTree.gd")
var SettingTable = load("res://class/entity/SettingTable.gd")

var setting

func _init():
	setting = null

func getAttr(attr_name):
	return setting.getAttr(attr_name)

func setSetting(setting_):
	setting = setting_

func pack():
	var script_tree = ScriptTree.new()

	script_tree.addObject("setting", SettingTable)

	return script_tree

func loadScript(script_tree):
	setting = script_tree.getObject("setting", SettingTable)

func initScript():
	var path = "res://scripts/system/global_setting.json"
	var file = File.new()
	if file.file_exists(path):
		var script_tree = ScriptTree.new()
		script_tree.loadFromJson(path)
		loadScript(script_tree)
