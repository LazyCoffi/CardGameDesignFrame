extends Node2D

var ScriptTree = TypeUnit.type("ScriptTree")
var SwitchTargetTable = TypeUnit.type("SwitchTargetTable")
var MainMenuDispatcher = TypeUnit.type("MainMenuDispatcher")
var MainMenuModel = TypeUnit.type("MainMenuModel")
var MainMenuRender = TypeUnit.type("MainMenuRender")
var MainMenuService = TypeUnit.type("MainMenuService")

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
	scene_dispatcher = MainMenuDispatcher.new()
	scene_model = null
	scene_render = MainMenuRender.new()
	scene_service = MainMenuService.new()
	__setRef()

func _ready():
	__setSwitchConnection()
	scene_dispatcher.launch()

# is_registered
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

# dispatcher
func dispatcher():
	return scene_dispatcher

func setDispatcher(scene_dispatcher_):
	scene_dispatcher = scene_dispatcher_

# model
func model():
	return scene_model

func setModel(scene_model_):
	scene_model = scene_model_

# render
func render():
	return scene_render

func setRender(scene_render_):
	scene_model = scene_render_

# service
func service():
	return scene_service

func setService(scene_service_):
	scene_service = scene_service_

func pack():
	var script_tree = ScriptTree.new()

	script_tree.addAttr("scene_name", scene_name)
	script_tree.addAttr("is_registered", is_registered)
	script_tree.addObject("switch_target_table", switch_target_table)
	script_tree.addObject("scene_model", scene_model)

	return script_tree

func loadScript(script_tree):
	scene_name = script_tree.getStr("scene_name")
	is_registered = script_tree.getBool("is_registered")
	switch_target_table = script_tree.getObject("switch_target_table", SwitchTargetTable)
	scene_model = script_tree.getObject("scene_model", MainMenuModel)

func __setRef():
	scene_dispatcher.setRef(self)
	scene_render.setRef(self)
	scene_service.setRef(self)

func __setSwitchConnection():
	Logger.assert($StartButton.connect("pressed", self, "__startButtonSwitch") == 0, "Signal connect fail!")
	Logger.assert($ContinueButton.connect("pressed", self, "__continueButtonSwitch") == 0, "Signal connect fail!")
	Logger.assert($SettingButton.connect("pressed", self, "__settingButtonSwitch") == 0, "Signal connect fail!")

func __startButtonSwitch():
	var target_scene_name = switch_target_table.getTargetSceneName("StartButton")
	__buttonSwitch(target_scene_name)

func __continueButtonSwitch():
	var target_scene_name = switch_target_table.getTargetSceneName("ContinueButton")
	__buttonSwitch(target_scene_name)

func __settingButtonSwitch():
	var target_scene_name = switch_target_table.getTarget("SettingButton")
	__buttonSwitch(target_scene_name)

func __buttonSwitch(target_scene_name):
	switchScene(target_scene_name)
