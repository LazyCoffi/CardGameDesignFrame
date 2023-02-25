extends Node2D

var ScriptTree = TypeUnit.type("ScriptTree")
var SwitchTargetTable = TypeUnit.type("SwitchTargetTable")

var CardTemplateDispatcher = TypeUnit.type("CardTemplateDispatcher")
var CardTemplateModel = TypeUnit.type("CardTemplateModel")
var CardTemplateRender = TypeUnit.type("CardTemplateRender")
var CardTemplateService = TypeUnit.type("CardTemplateService")

var is_registered
var scene_name
var switch_target_table

var scene_dispatcher 
var scene_model
var scene_render
var scene_service

func _init():
	switch_target_table = SwitchTargetTable.new()
	scene_dispatcher = CardTemplateDispatcher.new()
	scene_model = CardTemplateModel.new()
	scene_render = CardTemplateRender.new()
	scene_service = CardTemplateService.new()

func _ready():
	pass

func isRuntimeType():
	return false

func dispatcher():
	return scene_dispatcher

func model():
	return scene_model

func render():
	return scene_render

func service():
	return scene_service
