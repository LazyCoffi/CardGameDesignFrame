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

func isType(val, type_name):
	match type_name:
		"all":	
			return true
		"int":
			return val is int
		"float":
			return val is float
		"bool":
			return val is bool
		"null":
			return val == null
		"Number":
			return val is int or val is float
		"String":
			return val is String
		"Array":
			return val is Array
		"Dictionary":
			return val is Dictionary
	
	var types = type_name.split("_")
	if types.size() == 2:
		if types[1] == "Array":
			for val_ in val:
				if not isType(val_, types[0]):
					return false
		elif types[1] == "Dictionary":
			for val_ in val.values():
				if not isType(val_, types[0]):
					return false
		else:
			return false

		return true
	elif types.size() > 2:
		return false

	return val is type(type_name)

func isAdaptable(val, type_name):
	if isType(val, type_name):
		return true

	match type_name:
		"int":
			return isType(val, "float")
		"float":
			return isType(val, "int")
		"int_Array":
			return isType(val, "float_Array")
		"float_Array":
			return isType(val, "int_Array")
		"int_Dictionary":
			return isType(val, "float_Dictionary")
		"float_Dictionary":
			return isType(val, "int_Dictionary")
	
	return false

func verifyParamsType(params, params_form):
	Exception.assert(params.size() == params_form.size())
	var siz = params.size()
	for index in range(siz):
		if not isType(params[index], params_form[index]):
			return false
	
	return true

func verifyParamsAdaptable(params, params_form):
	Exception.assert(params.size() == params_form.size())
	var siz = params.size()
	for index in range(siz):
		if not isAdaptable(params[index], params_form[index]):
			return false
	
	return true

func __initTypeTable():
	type_table = {}
	__addType("container", "CardPile")
	__addType("container", "DictArray")
	__addType("container", "Heap")
	__addType("container", "PollingBucket")
	__addType("entity", "ArrangeMap")
	__addType("entity", "Attr")
	__addType("entity", "BattleCharacterCard")
	__addType("entity", "BattleSkillCard")
	__addType("entity", "BuffCard")
	__addType("entity", "Card")
	__addType("entity", "CategoryTree")
	__addType("entity", "DictMap")
	__addType("entity", "EquipmentCard")
	__addType("entity", "Float")
	__addType("entity", "Info")
	__addType("entity", "Integer")
	__addType("entity", "NullPack")
	__addType("entity", "ParamList")
	__addType("entity", "ScriptTree")
	__addType("entity", "SettingTable")
	__addType("entity", "StringPack")
	__addType("entity", "SwitchTargetTable")
	__addType("entity", "TriggerTimer")
	__addType("entity", "ValRange")
	__addType("functional", "ArrayOperFunctionSet")
	__addType("functional", "AttrConditionSet")
	__addType("functional", "AttrFunctionSet")
	__addType("functional", "BaseConditionSet")
	__addType("functional", "BaseFunctionSet")
	__addType("functional", "BattleFunctionSet")
	__addType("functional", "CardOperFunctionSet")
	__addType("functional", "Filter")
	__addType("functional", "Function")
	__addType("functional", "FunctionalGraph")
	__addType("functional", "FunctionalSet")
	__addType("functional", "LocalFunction")
	__addType("functional", "MathFunctionSet")
	__addType("functional", "SceneOperFunctionSet")
	__addType("scene", "SceneFactory")
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
