extends Node

## 作为Bootloader， 在此初始化SceneDispatcher，
## 创建主菜单场景，并将控制权交给主菜单场景

var ScriptTree = load("res://class/entity/ScriptTree.gd")

func _init():
	__initUnit()

func _ready():
	gameInit()

func gameInit():
	__preloadScene()
	__gameStart()

func __initUnit():
	Logger.log("Global unit load script.")
	CardCache.initScript()
	GlobalSetting.initScript()
	ResourceUnit.initScript()

func __preloadScene():
	Logger.log("Preload scene.")
	var preload_scene_list = GlobalSetting.getAttr("preload_scene_list")
	for scene_name in preload_scene_list:
		SceneCache.create(scene_name)

func __gameStart():
	Logger.log("Game start! Switch to the first scene.")
	var init_scene_name = GlobalSetting.getAttr("init_scene_name")
	$SceneDispatcher.switch(init_scene_name)

func quit():
	get_tree().quit()
