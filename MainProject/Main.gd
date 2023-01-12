extends Node

## 作为Bootloader， 在此初始化SceneController，
## 创建主菜单场景，并将控制权交给主菜单场景

## TODO:
## 1. 继续推进LinearBattleScene
## 2. 为需要的实体添加initScript()函数，与loadScript()区分。loadScript用于存档与复原，initScript用于初始化
## 3. 完善Interface, 设计LinearBattleInterface
## 4. 推进LinearBattleScene的SceneDispatcher
## 5. 现有基础上完成MainMenuScene到LinearBattleScene的跳转，并实现卡牌的展示
## 6. 添加Log

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
