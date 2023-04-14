extends "res://class/functional/FuncSet.gd"
class_name LinearBattleConditionSet

func _init():
	__initFuncForm()

func isOwnTeamEmpty(scene_name):
	return SceneManager.callService(scene_name, "isOwnTeamEmpty", [])

func isEnemyTeamEmpty(scene_name):
	return SceneManager.callService(scene_name, "isEnemyTeamEmpty", [])

func isCardOwnTeam(character, scene_name):
	return SceneManager.callService(scene_name, "isCardOwnTeam", [character])

func isCardEnemyTeam(character, scene_name):
	return SceneManager.callService(scene_name, "isCardEnemyTeam", [character])

func __initFuncForm():
	addFuncForm("isOwnTeamEmpty", "bool", ["String"])
	addFuncForm("isEnemyTeamEmpty", "bool", ["String"])
	addFuncForm("isCardOwnTeam", "bool", ["Character", "String"])
	addFuncForm("isCardEnemyTeam", "bool", ["Character", "String"])
