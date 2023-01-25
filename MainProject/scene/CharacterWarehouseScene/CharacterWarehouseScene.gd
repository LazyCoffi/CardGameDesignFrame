extends Node2D

var ScriptTree = load("res://class/entity/ScriptTree.gd")
var SwitchTargetTable = load("res://class/entity/SwitchTargetTable.gd")

var is_registered
var switch_target_table

var scene_name
var scene_model
var scene_service

func _ready():
	pass

func isRegistered():
	return is_registered

func register():
	is_registered = true

func switchScene(signal_name, next_scene_name):
	emit_signal(signal_name, next_scene_name)

func model():
	return scene_model

func service():
	return scene_service

func getSceneName():
	return scene_name
