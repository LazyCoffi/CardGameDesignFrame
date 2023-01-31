extends Node2D

var ScriptTree = TypeUnit.type("ScriptTree")
var SwitchTargetTable = TypeUnit.type("SwitchTargetTable")
var MainMenuDispatcher = TypeUnit.type("MainMenuDispatcher")
var MainMenuModel = TypeUnit.type("MainMenuModel")
var MainMenuRender = TypeUnit.type("MainMenuRender")
var MainMenuService = TypeUnit.type("MainMenuService")

signal switchSignal
signal switchWithoutRefreshSignal
signal switchWithCleanSignal

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
	scene_model = MainMenuModel.new()
	scene_render = MainMenuRender.new()
	scene_service = MainMenuService.new()
	__setRef()

func _ready():
	scene_dispatcher.launch()

# is_registered
func isRegistered():
	return is_registered

func register():
	is_registered = true

func switchScene(signal_name, next_scene_name):
	emit_signal(signal_name, next_scene_name)

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
	scene_model = script_tree.getObject("model", MainMenuModel)

func __setRef():
	scene_render.setRef(self)
	scene_service.setRef(self)

func __setSwitchConnection():
	Exception.assert($StartButton.connect("pressed", self, "__startButtonSwitch") == 0, "Signal connect fail!")
	Exception.assert($ContinueButton.connect("pressed", self, "__continueButtonSwitch") == 0, "Signal connect fail!")
	Exception.assert($SettingButton.connect("pressed", self, "__settingButtonSwitch") == 0, "Signal connect fail!")

func __startButtonSwitch():
	var target_pack = switch_target_table.getTarget("StartButton")
	__buttonSwitch(target_pack)

func __continueButtonSwitch():
	var target_pack = switch_target_table.getTarget("ContinueButton")
	__buttonSwitch(target_pack)

func __settingButtonSwitch():
	var target_pack = switch_target_table.getTarget("SettingButton")
	__buttonSwitch(target_pack)

func __buttonSwitch(target_pack):
	var signal_name = target_pack.getSignalName() 
	var next_scene_name = target_pack.getSceneName()
	switchScene(signal_name, next_scene_name)
