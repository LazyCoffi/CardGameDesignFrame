extends Node2D

var ScriptTree = load("res://class/entity/ScriptTree.gd")
var SwitchTargetTable = load("res://class/entity/SwitchTargetTable.gd")
var CharacterWarehouseModel = load("res://scene/CharacterWarehouseScene/CharacterWarehouseModel.gd")
var CharacterWarehouseService = load("res://scene/CharacterWarehouseScene/CharacterWarehouseService.gd")

var is_registered
var switch_target_table

var scene_name			# String
var scene_model			# CharacterWarehouseModel
var scene_service		# CharacterWarehouseService

func _init():
	scene_model = CharacterWarehouseModel.new()
	scene_service = CharacterWarehouseService.new()

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
