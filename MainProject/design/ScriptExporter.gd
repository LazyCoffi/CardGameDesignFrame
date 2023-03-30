extends Node
class_name Exporter

var ScriptTree = TypeUnit.type("ScriptTree")

var global_setting
var card_cache
var resource_unit
var main_menu_scene
var sub_menu_scene
var linear_battle_scene
var archive_scene
var explore_map_scene
var setting_scene

func _init():
	global_setting = null
	card_cache = null
	resource_unit = null
	main_menu_scene = []
	sub_menu_scene = []
	linear_battle_scene = []
	archive_scene = []
	explore_map_scene = []
	setting_scene = []

func setGlobalSetting(global_setting_):
	global_setting = global_setting_

func setCardCache(card_cache_):
	card_cache = card_cache_

func setResourceUnit(resource_unit_):
	resource_unit = resource_unit_

func addMainMenuScene(main_menu_scene_):
	main_menu_scene.append(main_menu_scene_)

func delMainMenuScene(index):
	main_menu_scene.remove(index)

func addSubMenuScene(sub_menu_scene_):
	sub_menu_scene.append(sub_menu_scene_)

func delSubMenuScene(index):
	sub_menu_scene.remove(index)

func addLinearBattleScene(linear_battle_scene_):
	linear_battle_scene.append(linear_battle_scene_)

func delLinearBattleScene(index):
	linear_battle_scene.remove(index)

func addArchiveScene(archive_scene_):
	archive_scene.append(archive_scene_)

func delArchiveScene(index):
	archive_scene.remove(index)

func addExploreMapScene(explore_map_scene_):
	explore_map_scene.append(explore_map_scene_)

func delExploreMapScene(index):
	explore_map_scene.remove(index)

func exportScript(path):
	var directory = Directory.new()
	directory.open(path)

	directory.make_dir("./system")
	directory.make_dir("./scene")

	global_setting.pack().exportAsJson(path + "/system/global_setting.json")
	card_cache.pack().exportAsJson(path + "/system/card_templates.json")
	resource_unit.pack().exportAsJson(path + "/system/resource_unit.json")

	for scene in main_menu_scene:
		var scene_name = scene.getSceneName()
		scene.pack().exportAsJson(path + "/scene/" + scene_name + ".json")

	for scene in sub_menu_scene:
		var scene_name = scene.getSceneName()
		scene.pack().exportAsJson(path + "/scene/" + scene_name + ".json")

	for scene in linear_battle_scene:
		var scene_name = scene.getSceneName()
		scene.pack().exportAsJson(path + "/scene/" + scene_name + ".json")

	for scene in archive_scene:
		var scene_name = scene.getSceneName()
		scene.pack().exportAsJson(path + "/scene/" + scene_name + ".json")
	
	for scene in explore_map_scene:
		var scene_name = scene.getSceneName()
		scene.pack().exportAsJson(path + "/scene/" + scene_name + ".json")

	for scene in setting_scene:
		var scene_name = scene.getSceneName()
		scene.pack().exportAsJson(path + "/scene/" + scene_name + ".json")
