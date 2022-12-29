extends Node

## 作为Bootloader， 在此初始化SceneController，
## 创建主菜单场景，并将控制权交给主菜单场景

## TODO:
## 1. 修改脚本，尝试启动MainMenuScene
## 2. 添加BattleScene

func debug():
	var Debug = load("res://class/Test.gd")
	var debug_runner = Debug.new()
	debug_runner.run()
	
func gameEarlyInit():
	pass
	
func gameInit():
	Exception.setSceneTree(get_tree())

func _init():
	debug()

func _ready():
	gameInit()
	$SceneDispatcher.switch("main_menu_1")

func quit():
	get_tree().quit()
