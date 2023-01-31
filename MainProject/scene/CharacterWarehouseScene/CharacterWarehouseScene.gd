extends Node2D

var ScriptTree = TypeUnit.type("ScriptTree")
var SwitchTargetTable = TypeUnit.type("SwitchTargetTable")

var CharacterWarehouseDispather = TypeUnit.type("CharacterWarehouseDispather")
var CharacterWarehouseModel = TypeUnit.type("CharacterWarehouseModel")
var CharacterWarehouseRender = TypeUnit.type("CharacterWarehouseRender")
var CharacterWarehouseService = TypeUnit.type("CharacterWarehouseService")

var is_registered
var scene_name
var switch_target_table

var scene_dispatcher
var scene_model
var scene_render
var scene_service

func _init():
	switch_target_table = SwitchTargetTable.new()
	scene_dispatcher = CharacterWarehouseDispather.new()
	scene_model = CharacterWarehouseModel.new()
	scene_render = CharacterWarehouseRender
	scene_service = CharacterWarehouseService.new()

func isRegistered():
	return is_registered

func register():
	is_registered = true

func switchScene(signal_name, next_scene_name):
	emit_signal(signal_name, next_scene_name)
func getSceneName():
	return scene_name

func setSceneName(scene_name_):
	scene_name = scene_name_

func dispatcher():
	return scene_dispatcher

func model():
	return scene_model

func render():
	return scene_render

func service():
	return scene_service


