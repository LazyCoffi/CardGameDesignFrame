extends "res://class/functional/FuncSet.gd"
class_name SceneOperFuncSet

func _init():
	__initFuncForm()

func fetchFromScene(scene_name, param_name):
	return SceneManager.fetchParam(scene_name, param_name)

func callSceneService(scene_name, func_name, params):
	return SceneManager.callService(scene_name, func_name, params)

func switchScene(scene_ref, next_scene_name):
	scene_ref.switchScene(next_scene_name)

func pushScene(scene_ref, next_scene_name):
	scene_ref.pushScene(next_scene_name)

func popScene(scene_ref):
	return scene_ref.popScene()

func getScene(scene_name):
	return SceneManager.getScene(scene_name)

func quitGame(scene_ref):
	scene_ref.get_tree().quit()

func __initFuncForm():
	addFuncForm("fetchFromScene", "all", ["String", "String"])
	addFuncForm("callSceneService", "all", ["String", "String", "Array"])
	addFuncForm("switchScene", "null", ["Object", "String"])
	addFuncForm("pushScene", "null", ["Object", "String"])
	addFuncForm("popScene", "null", ["Object"])
	addFuncForm("getScene", "Object", ["String"])
	addFuncForm("quitGame", "null", ["Object"])
