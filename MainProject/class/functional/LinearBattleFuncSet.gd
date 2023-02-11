extends "res://class/functional/FuncSet.gd"
class_name LinearBattleFuncSet

func _init():
	__initFuncForm()

func getMainCharacterNum(scene_name):
	return SceneCache.callService(scene_name, "getEnemyCharacterNum", [])
 
func getEnemyCharacterNum(scene_name):
	return SceneCache.callService(scene_name, "getEnemyCharacterNum", [])

func __initFuncForm():
	func_form = {}
	addFuncForm("getMainCharacterNum", "int", ["String"])
	addFuncForm("getEnemyCharacterNum", "int", ["String"])
