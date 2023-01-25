extends Node

## 作为Bootloader， 在此初始化SceneController，
## 创建主菜单场景，并将控制权交给主菜单场景

var ScriptTree = load("res://class/entity/ScriptTree.gd")

var init_scene_name

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
	init_scene_name = GlobalSetting.getAttr("init_scene_name")
	gameStart()

func gameStart():
	$SceneDispatcher.switch(init_scene_name)

func loadScript():
	var script_tree = ScriptTree.new()
	script_tree.loadFromJson("res://scripts/system/main.json")

	init_scene_name = script_tree.getAttr("init_scene_name")

func quit():
	get_tree().quit()
