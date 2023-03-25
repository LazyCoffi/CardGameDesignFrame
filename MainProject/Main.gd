extends Node

## 作为Bootloader， 在此初始化SceneDispatcher，
## 创建主菜单场景，并将控制权交给主菜单场景

var ScriptTree = load("res://class/entity/ScriptTree.gd")

func _init():
	__initUnit()

func _ready():
	gameInit()

func gameInit():
	__gameStart()
	add_child(AudioPlayer.getBgmPlayer())
	add_child(AudioPlayer.getSoundPlayer())

func __initUnit():
	Logger.log("Global unit load script.")
	CardCache.initScript()
	GlobalSetting.initScript()
	ResourceUnit.initScript()

func __gameStart():
	Logger.log("Game start! Switch to the first scene.")
	var init_scene_name = GlobalSetting.getInitSceneName()
	$SceneDispatcher.switch(init_scene_name)

func quit():
	get_tree().quit()
