extends Node2D

var ScriptTree = TypeUnit.type("ScriptTree")
var SwitchTargetTable = TypeUnit.type("SwitchTargetTable")
var LinearBattleDispatcher = TypeUnit.type("LinearBattleDispatcher")
var LinearBattleModel = TypeUnit.type("LinearBattleModel")
var LinearBattleRender = TypeUnit.type("LinearBattleRender")
var LinearBattleService = TypeUnit.type("LinearBattleService")

signal switchSignal
signal pushSignal
signal popSignal

var is_registered
var scene_name
var switch_target_table

var scene_dispatcher
var scene_model
var scene_render
var scene_service

func _init():
	is_registered = false
	scene_dispatcher = LinearBattleDispatcher.new()
	scene_model = null
	scene_render = LinearBattleRender.new()
	scene_service = LinearBattleService.new()
	__setRef()

func _ready():
	scene_dispatcher.launch()

func isRegistered():
	return is_registered

func register():
	is_registered = true

func switchScene(next_scene_name):
	emit_signal("switchSignal", next_scene_name)

func pushScene(next_scene_name):
	emit_signal("pushSignal", next_scene_name)

func popSignal():
	emit_signal("popSignal")

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

# scene_dispatcher
func dispatcher():
	return scene_dispatcher

func setDispatcher(scene_dispatcher_):
	scene_dispatcher = scene_dispatcher_

# scene_model
func model():
	return scene_model

func setSceneModel(scene_model_):
	scene_model = scene_model_

# scene_render
func render():
	return scene_render

func setSceneRender(scene_render_):
	scene_render = scene_render_

# scene_service
func service():
	return scene_service

func setSceneService(scene_service_):
	scene_service = scene_service_

func battleOverSwitch():
	var target_scene_name = switch_target_table.getTargetSceneName("BattleOver")
	switchScene(target_scene_name)

func pack():
	var script_tree = ScriptTree.new()

	script_tree.addAttr("scene_name", scene_name)
	script_tree.addObject("switch_target_table", switch_target_table)
	script_tree.addObject("scene_model", scene_model)

	return script_tree

func loadScript(script_tree):
	scene_name = script_tree.getStr("scene_name")
	switch_target_table = script_tree.getObject("switch_target_table", SwitchTargetTable)
	scene_model = script_tree.getObject("scene_model", LinearBattleModel)

func __setRef():
	scene_dispatcher.setRef(self)
	scene_render.setRef(self)
	scene_service.setRef(self)
