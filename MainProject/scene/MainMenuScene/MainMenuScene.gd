extends Node2D

signal changeSceneSignal

var is_registered
var scene_name

func _init():
	is_registered = false

func loadResource():
	setBackground()
	setTitle()
	
	var siz = self.get_child_count()
	for index in range(siz):
		var child = self.get_child(index)
		child.loadResource(scene_name, child.name)

func isRegistered():
	return is_registered

func register():
	is_registered = true

func setTitle():
	var title = ResourceUnit.loadTexture(scene_name, scene_name, "title")
	$MainMenuTitle.texture = title

func setBackground():
	var bg = ResourceUnit.loadTexture(scene_name, scene_name, "background")
	$MainMenuBackground.texture = bg

