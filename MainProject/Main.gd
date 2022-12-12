extends Node

## 作为Bootloader， 在此初始化SceneController，
## 创建主菜单场景，并将控制权交给主菜单场景

func debug():
	var Debug = load("res://class/Test.gd")
	var debug_runner = Debug.new()
	debug_runner.run("ScriptTreeTest")
	debug_runner.run("IsTest")
	
	
func gameEarlyInit():
	pass
	
func gameInit():
	Exception.setSceneTree(get_tree())

func _init():
	pass

func _ready():
	gameInit()
	debug()

func quit():
	get_tree().quit()
