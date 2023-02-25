extends "res://class/functional/FuncSet.gd"
class_name LinearBattleFuncSet

func _init():
	__initFuncForm()

func getOwnCharacterNum(scene_name):
	return SceneManager.callService(scene_name, "getOwnCharacterNum", [])

func getOwnCharacterTeam(scene_name):
	return SceneManager.callService(scene_name, "getOwnCharacterTeam", [])

func getOwnCharacterByName(scene_name, first):
	return SceneManager.callService(scene_name, "getOwnCharacterByName", [first])
 
func getEnemyCharacterNum(scene_name):
	return SceneManager.callService(scene_name, "getEnemyCharacterNum", [])

func getEnemyCharacterTeam(scene_name):
	return SceneManager.callService(scene_name, "getEnemyCharacterTeam", [])

func getEnemyCharacterByName(scene_name, first):
	return SceneManager.callService(scene_name, "getEnemyCharacterByName", [first])

func getOppositeTeam(scene_name, first):
	return SceneManager.callService(scene_name, "getOppositeTeam", [first])

func __initFuncForm():
	addFuncForm("getOwnCharacterNum", "int", ["String"])
	addFuncForm("getOwnCharacterTeam", "Array", ["String"])
	addFuncForm("getOwnCharacterByName", "CharacterCard", ["String", "String"])
	addFuncForm("getEnemyCharacterNum", "int", ["String"])
	addFuncForm("getEnemyCharacterTeam", "Array", ["String"])
	addFuncForm("getEnemyCharacterByName", "CharacterCard", ["String", "String"])
	addFuncForm("getOppositeTeam", "Array", ["String", "CharacterCard"])
