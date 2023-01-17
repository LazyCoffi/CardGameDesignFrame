extends Node

var ScriptTree = load("res://class/entity/ScriptTree.gd")

var global_setting

func _init():
	__initScript()	

func getAttr(attr_name):
	return global_setting[attr_name]

func __initScript():
	var script_tree = ScriptTree.new()
	script_tree.loadFromJson("res://scripts/system/globalSetting.json")
	global_setting = script_tree.getAttr("global_setting")
	

