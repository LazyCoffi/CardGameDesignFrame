extends Node2D

var ScriptTree = load("res://class/entity/ScriptTree.gd")
var SwitchTargetTable = load("res://class/entity/SwitchTargetTable.gd")
var LinearBattleModel = load("res://scene/LinearBattleScene/LinearBattleModel.gd")
var LinearBattleService = load("res://scene/LinearBattleScene/LinearBattleService.gd")
var LinearBattleDispatcher = load("res://scene/LinearBattleScene/LinearBattleDispatcher.gd")
var BattleCharacterCard = load("res://class/entity/BattleCharacterCard.gd")

signal switchSignal
signal switchWithoutRefreshSignal
signal switchWithCleanSignal

var is_registered
var switch_target_table

var scene_name
var scene_model
var scene_service
var scene_dispatcher

func _init():
	pass

func _ready():
	pass

func isRegistered():
	return is_registered

func register():
	is_registered = true

func switchScene(signal_name, next_scene_name):
	emit_signal(signal_name, next_scene_name)

func setRef(scene):
	scene_service.setRef(scene)
	scene_dispatcher.setRef(scene)

# scene_name
func getSceneName():
	return scene_name

func setSceneName(scene_name_):
	scene_name = scene_name_

# switch_target_table
func getSwitchTargetTable():
	return switch_target_table

func setSwitchTargetTable(switch_target_table_):
	switch_target_table = switch_target_table_	

# scene_model
func model():
	return scene_model

func setSceneModel(scene_model_):
	scene_model = scene_model_

# scene_service
func service():
	return scene_service

func setSceneService(scene_service_):
	scene_service = scene_service_

# scene_dispatcher
func dispatcher():
	return scene_dispatcher

func setDispatcher(scene_dispatcher_):
	scene_dispatcher = scene_dispatcher_

func pack():
	var script_tree = ScriptTree.new()

	script_tree.addAttr("scene_name", scene_name)
	script_tree.addObject("switch_target_table", switch_target_table)
	script_tree.addObject("scene_model", scene_model)
	script_tree.addObject("scene_service", scene_service)

	return script_tree

func loadScript(script_tree):
	scene_name = script_tree.getStr("scene_name")
	scene_model = script_tree.getObject("scene_model", LinearBattleModel)
	scene_service = script_tree.getObject("scene_service", LinearBattleService)
