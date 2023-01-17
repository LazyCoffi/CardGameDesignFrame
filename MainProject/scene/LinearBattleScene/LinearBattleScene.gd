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

func switchScene(signal_name, next_scene_name, scene_pack_):
	emit_signal(signal_name, next_scene_name, scene_pack_)

func setRef(scene):
	scene_service.setRef(scene)
	scene_dispatcher.setRef(scene)

func model():
	return scene_model

func service():
	return scene_service

func dispatcher():
	return scene_dispatcher

func getSceneName():
	return scene_name

func pack():
	var script_tree = ScriptTree.new()

	script_tree.addAttr("scene_name", scene_name)
	script_tree.addObject("switch_target_table", switch_target_table)
	script_tree.addObject("scene_model", scene_model)
	script_tree.addObject("scene_service", scene_service)

	return script_tree

func loadScript(script_tree):
	scene_name = script_tree.getAttr("scene_name")
	scene_model = script_tree.getObject("scene_model", LinearBattleModel)
	scene_service = script_tree.getObject("scene_service", LinearBattleService)

func initScript(script_tree):
	scene_name = script_tree.getAttr("scene_name")
	switch_target_table = script_tree.getObject("switch_target_table", SwitchTargetTable)

	scene_model = LinearBattleModel.new()
	scene_service = LinearBattleService.new()
	scene_dispatcher = LinearBattleDispatcher.new()
