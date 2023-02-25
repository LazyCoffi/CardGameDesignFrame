extends "res://class/functional/FuncSet.gd"
class_name LinearBattleConditionSet

func _init():
	__initFuncForm()

func isOwnTeamEmpty(scene_name):
	return SceneManager.callService(scene_name, "isOwnTeamEmpty", [])

func isEnemyTeamEmpty(scene_name):
	return SceneManager.callService(scene_name, "isEnemyTeamEmpty", [])

func __initFuncForm():
	addFuncForm("isOwnTeamEmpty", "bool", ["String"])
	addFuncForm("isEnemyTeamEmpty", "bool", ["String"])
