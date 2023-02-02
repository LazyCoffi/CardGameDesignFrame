extends Node

var ScriptTree = load("res://class/entity/ScriptTree.gd")
var SettingTable = load("res://class/entity/SettingTable.gd")

var setting

func _init():
	__initSetting()	

func getAttr(attr_name):
	return setting.getAttr(attr_name)

func pack():
	var script_tree = ScriptTree.new()

	script_tree.addObject("setting", SettingTable)

	return script_tree

func __initSetting():
	var script_tree = ScriptTree.new()
	script_tree.loadFromJson("res://scripts/system/global_setting.json")
	setting = script_tree.getObject("setting", SettingTable)
