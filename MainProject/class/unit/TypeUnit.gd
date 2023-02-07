extends Node

var type_table

func _init():
	__initTypeTable()

func type(type_name):
	Exception.assert(type_table.has(type_name))
	return type_table[type_name]

func packBaseParam(val):
	var ret
	if val is int:
		ret = type("Integer").new()
		ret.setVal(val)
	elif val is float:
		ret = type("Float").new()
		ret.setVal(val)
	elif val is String:
		ret = type("StringPack").new()
		ret.setVal(val)
	elif val == null:
		ret = type("NullPack").new()
	else:
		ret = val
	
	return ret

func __initTypeTable():
	type_table = {}
	__addType("container", "CardPile")
	__addType("container", "DictArray")
	__addType("container", "HandCardSlot")
	__addType("container", "Heap")
	__addType("container", "PollingBucket")
	__addType("entity", "ArrangeMap")
	__addType("entity", "Attr")
	__addType("entity", "SkillCard")
	__addType("entity", "BitFlag")
	__addType("entity", "BuffCard")
	__addType("entity", "Card")
	__addType("entity", "CategoryTree")
	__addType("entity", "CharacterCard")
	__addType("entity", "DictMap")
	__addType("entity", "EquipmentCard")
	__addType("entity", "Float")
	__addType("entity", "Integer")
	__addType("entity", "LinearCharacterCard")
	__addType("entity", "LinearSkillCard")
	__addType("entity", "NullPack")
	__addType("entity", "ParamList")
	__addType("entity", "ScriptTree")
	__addType("entity", "SettingTable")
	__addType("entity", "StringPack")
	__addType("entity", "SwitchTargetTable")
	__addType("entity", "TriggerTimer")
	__addType("entity", "ValRange")
	__addType("functional", "ArrayOperFuncSet")
	__addType("functional", "AttrConditionSet")
	__addType("functional", "AttrFuncSet")
	__addType("functional", "BaseConditionSet")
	__addType("functional", "BaseFuncSet")
	__addType("functional", "BattleFuncSet")
	__addType("functional", "CardFuncSet")
	__addType("functional", "Function")
	__addType("functional", "FuncUnit")
	__addType("functional", "FuncGraph")
	__addType("functional", "FuncSet")
	__addType("functional", "HyperFunction")
	__addType("functional", "MathFuncSet")
	__addType("functional", "SceneOperFuncSet")
	__addType("unit", "SceneFactory")
	__addType("unit", "SceneCache")
	__addType("unit", "CardCache")
	__addType("unit", "Exception")
	__addType("unit", "GlobalSetting")
	__addType("unit", "MathUnit")
	__addType("unit", "ResourceUnit")
	__addType("unit", "TypeUnit")

	__addSceneType("MainMenuScene", "MainMenuDispatcher")
	__addSceneType("MainMenuScene", "MainMenuModel")
	__addSceneType("MainMenuScene", "MainMenuRender")
	__addSceneType("MainMenuScene", "MainMenuService")
	__addSceneType("LinearBattleScene", "LinearBattleDispatcher")
	__addSceneType("LinearBattleScene", "LinearBattleModel")
	__addSceneType("LinearBattleScene", "LinearBattleRender")
	__addSceneType("LinearBattleScene", "LinearBattleService")
	__addSceneType("CharacterWarehouseScene", "CharacterWarehouseModel")

	__addSceneInstance("MainMenuScene")
	__addSceneInstance("LinearBattleScene")
	__addSceneInstance("CharacterWarehouseScene")

func __addType(dict, type_name):
	var type = load("res://class/" + dict + "/" + type_name + ".gd")
	type_table[type_name] = type

func __addSceneType(dict, type_name):
	var type = load("res://scene/" + dict + "/" + type_name + ".gd")
	type_table[type_name] = type

func __addSceneInstance(type_name):
	var type = load("res://scene/" + type_name + "/" + type_name + ".tscn")
	type_table[type_name] = type
