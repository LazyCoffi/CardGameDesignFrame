extends Node2D

var ScriptTree = load("res://class/entity/ScriptTree.gd")

signal switchSignal
signal switchWithoutRefreshSignal

var is_registered
var scene_name
var scene_pack

func _init():
	is_registered = false

func _ready():
	__loadResource()

func isRegistered():
	return is_registered

func register():
	is_registered = true

func refreshScenePack(scene_pack_):
	scene_pack = scene_pack_

func switchScene(next_scene_name, scene_pack_):
	emit_signal("switchSignal", next_scene_name, scene_pack_)

func switchSceneWithoutRefresh(next_scene_name, scene_pack_):
	emit_signal("switchWithoutRefreshSignal", next_scene_name, scene_pack_)

func pack():
	var script_tree = ScriptTree.new()

	script_tree.addAttr("scene_name", scene_name)

	return script_tree

func loadScript(script_tree):
	scene_name = script_tree.getAttr("scene_name")

func initScript(script_tree):
	scene_name = script_tree.getAttr("scene_name")

func __loadResource():
	__setBackground()
	__setTitle()
	
	$StartButton.loadResource(scene_name, "StartButton")
	$ContinueButton.loadResource(scene_name, "ContinueButton")
	$SettingButton.loadResource(scene_name, "SettingButton")
	$ExitButton.loadResource(scene_name, "ExitButton")

func __setTitle():
	var title = ResourceUnit.loadTexture(scene_name, scene_name, "title")
	$MainMenuTitle.texture = title

func __setBackground():
	var bg = ResourceUnit.loadTexture(scene_name, scene_name, "background")
	$MainMenuBackground.texture = bg

