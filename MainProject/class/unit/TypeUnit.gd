extends Node

enum {
	ENTITY,
	SCENE_TYPE,
	SCENE_INSTANCE,
	FACTORY,
	DESIGNER
}

var type_table

func _init():
	__initTypeTable()

func type(type_name):
	Logger.assert(type_table.has(type_name), "Table doesn't have " + type_name + "!")
	return type_table[type_name]["type"]

func filter(class_type):
	var ret = {}
	for type_name in type_table.keys():
		if type_table[type_name]["class_type"] == class_type:
			ret[type_name] = type_table[type_name]["type"]
	
	return ret

func has(type_name):
	return type_table.has(type_name)

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
	__addType("container", "HandCardSlot")
	__addType("container", "Heap")
	__addType("container", "PollingBucket")
	__addType("entity", "AnimationPack")
	__addType("entity", "ArrangeMap")
	__addType("entity", "Attr")
	__addType("entity", "AttrNode")
	__addType("entity", "AudioPack")
	__addType("entity", "BitFlag")
	__addType("entity", "BuffCard")
	__addType("entity", "Boolean")
	__addType("entity", "Card")
	__addType("entity", "CardTemplate")
	__addType("entity", "CategoryTree")
	__addType("entity", "CharacterCard")
	__addType("entity", "ComponentPack")
	__addType("entity", "DictMap")
	__addType("entity", "Emitter")
	__addType("entity", "EquipmentCard")
	__addType("entity", "Float")
	__addType("entity", "Integer")
	__addType("entity", "LinearCharacterCard")
	__addType("entity", "LinearSkillCard")
	__addType("entity", "MapCanvas")
	__addType("entity", "NullPack")
	__addType("entity", "ParamList")
	__addType("entity", "ParamNode")
	__addType("entity", "ScriptTree")
	__addType("entity", "SkillCard")
	__addType("entity", "StringPack")
	__addType("entity", "SwitchTargetTable")
	__addType("entity", "TargetPack")
	__addType("entity", "TriggerTimer")
	__addType("entity", "ValRange")
	__addType("functional", "ArrayOperFuncSet")
	__addType("functional", "ArchiveOperFuncSet")
	__addType("functional", "AttrConditionSet")
	__addType("functional", "AttrFuncSet")
	__addType("functional", "BaseConditionSet")
	__addType("functional", "BaseFuncSet")
	__addType("functional", "CardConditionSet")
	__addType("functional", "CardFuncSet")
	__addType("functional", "CharacterCardConditionSet")
	__addType("functional", "CharacterCardFuncSet")
	__addType("functional", "ExploreMapFuncSet")
	__addType("functional", "Function")
	__addType("functional", "FuncUnit")
	__addType("functional", "FuncGraph")
	__addType("functional", "FuncGraphNode")
	__addType("functional", "FuncSet")
	__addType("functional", "HyperFunction")
	__addType("functional", "LinearBattleConditionSet")
	__addType("functional", "LinearBattleFuncSet")
	__addType("functional", "MathConditionSet")
	__addType("functional", "MathFuncSet")
	__addType("functional", "SceneOperFuncSet")
	__addType("scene", "Archive")
	__addType("scene", "ArchiveManager")
	__addType("scene", "SceneCache")
	__addType("scene", "SceneIndex")
	__addType("scene", "SceneLoader")
	__addType("scene", "SceneManager")
	__addType("scene", "ScenePack")
	__addType("unit", "CardCache")
	__addType("unit", "Logger")
	__addType("unit", "GlobalSetting")
	__addType("unit", "MathUnit")
	__addType("unit", "ResourceUnit")
	__addType("unit", "TimeUnit")
	__addType("unit", "TypeUnit")

	__addSceneType("ArchiveScene", "ArchiveDispatcher")
	__addSceneType("ArchiveScene", "ArchiveModel")
	__addSceneType("ArchiveScene", "ArchiveRender")
	__addSceneType("ArchiveScene", "ArchiveService")
	__addSceneType("DialogScene", "DialogDispatcher")
	__addSceneType("DialogScene", "DialogModel")
	__addSceneType("DialogScene", "DialogRender")
	__addSceneType("DialogScene", "DialogService")
	__addSceneType("ExploreMapScene", "ExploreMapDispatcher")
	__addSceneType("ExploreMapScene", "ExploreMapModel")
	__addSceneType("ExploreMapScene", "ExploreMapRender")
	__addSceneType("ExploreMapScene", "ExploreMapService")
	__addSceneType("MainMenuScene", "MainMenuDispatcher")
	__addSceneType("MainMenuScene", "MainMenuModel")
	__addSceneType("MainMenuScene", "MainMenuRender")
	__addSceneType("MainMenuScene", "MainMenuService")
	__addSceneType("LinearBattleScene", "LinearBattleDispatcher")
	__addSceneType("LinearBattleScene", "LinearBattleModel")
	__addSceneType("LinearBattleScene", "LinearBattleRender")
	__addSceneType("LinearBattleScene", "LinearBattleService")
	__addSceneType("SubMenuScene", "SubMenuDispatcher")
	__addSceneType("SubMenuScene", "SubMenuModel")
	__addSceneType("SubMenuScene", "SubMenuRender")
	__addSceneType("SubMenuScene", "SubMenuService")
	__addSceneType("SettingScene", "SettingDispatcher")
	__addSceneType("SettingScene", "SettingModel")
	__addSceneType("SettingScene", "SettingRender")
	__addSceneType("SettingScene", "SettingService")
	__addSceneType("CharacterWarehouseScene", "CharacterWarehouseModel")

	__addSceneInstance("ArchiveScene")
	__addSceneInstance("DialogScene")
	__addSceneInstance("ExploreMapScene")
	__addSceneInstance("MainMenuScene")
	__addSceneInstance("LinearBattleScene")
	__addSceneInstance("SubMenuScene")
	__addSceneInstance("CharacterWarehouseScene")
	__addSceneInstance("SettingScene")

	__addFactory("ArchiveModelFactory")
	__addFactory("ArchiveSceneFactory")
	__addFactory("AttrFactory")
	__addFactory("BooleanFactory")
	__addFactory("Factory")
	__addFactory("CardCacheFactory")
	__addFactory("CardTemplateFactory")
	__addFactory("FuncGraphFactory")
	__addFactory("FuncGraphNodeFactory")
	__addFactory("FunctionFactory")
	__addFactory("GlobalSettingFactory")
	__addFactory("HyperFunctionFactory")
	__addFactory("LinearBattleModelFactory")
	__addFactory("LinearBattleSceneFactory")
	__addFactory("LinearCharacterCardFactory")
	__addFactory("LinearSkillCardFactory")
	__addFactory("MainMenuModelFactory")
	__addFactory("MainMenuSceneFactory")
	__addFactory("ResourceUnitFactory")
	__addFactory("RootFactory")
	__addFactory("SubMenuModelFactory")
	__addFactory("SubMenuSceneFactory")

	__addDesignType("Designer")
	__addDesignType("FactoryTree")
	__addDesignType("ScriptExporter")

func __addType(dict, type_name):
	var type = load("res://class/" + dict + "/" + type_name + ".gd")
	type_table[type_name] = {
		"type" : type,
		"type_name" : type_name,
		"class_type" : ENTITY
	}

func __addSceneType(dict, type_name):
	var type = load("res://scene/" + dict + "/" + type_name + ".gd")
	type_table[type_name] = {
		"type" : type,
		"type_name" : type_name,
		"class_type" : SCENE_TYPE
	}

func __addSceneInstance(type_name):
	var type = load("res://scene/" + type_name + "/" + type_name + ".tscn")
	type_table[type_name] = {
		"type" : type,
		"type_name" : type_name,
		"class_type" : SCENE_INSTANCE
	}

func __addFactory(type_name):
	var type = load("res://design/factory/" + type_name + ".gd")
	type_table[type_name] = {
		"type" : type,
		"type_name" : type_name,
		"class_type" : FACTORY
	}

func __addDesignType(type_name):
	var type = load("res://design/" + type_name + ".gd")
	type_table[type_name] = {
		"type" : type,
		"type_name" : type_name,
		"class_type" : DESIGNER
	}
