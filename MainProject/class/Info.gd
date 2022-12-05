extends Node

var card_name
var avator
var introduction

func _ready():
	pass

func pack():
	var script = Script.new()
	script.add("card_name", card_name)
	script.add("avator", avator)
	script.add("introduction", introduction)
	
	return script

func loadScript(script):
	Exception.assert(script is Script)
	card_name = script.get("card_name")
	
	# TODO: 处理avator图像

	introduction = script.get("introduction")
