extends Node

## 作为Bootloader， 在此初始化SceneController，
## 创建主菜单场景，并将控制权交给主菜单场景

var ScriptTree = load("res://class/entity/ScriptTree.gd")

func debug():
	var Debug = load("res://class/Test.gd")
	var debug_runner = Debug.new()
	debug_runner.run()
	
func gameEarlyInit():
	pass

func _init():
	debug()

func _ready():
	gameInit()

func gameInit():
	preloadScene()
	gameStart()

func preloadScene():
	var preload_scene_list = GlobalSetting.getAttr("preload_scene_list")
	for scene_name in preload_scene_list:
		SceneCache.create(scene_name)

func gameStart():
	var init_scene_name = GlobalSetting.getAttr("init_scene_name")
	$SceneDispatcher.switch(init_scene_name)

func quit():
	get_tree().quit()
