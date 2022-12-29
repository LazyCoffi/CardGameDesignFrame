extends Node2D

signal switchSignal
signal switchWithoutRefreshSignal

var is_registered
var scene_name

func _init():
	is_registered = false

func _ready():
	__loadResource()

func isRegistered():
	return is_registered

func register():
	is_registered = true

func pack():
	pass

func loadScript(script_tree):
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

