extends "res://class/functional/FuncSet.gd"
class_name SceneOperFuncSet

func fetchFromScene(scene_name, param_name):
	return SceneManager.fetchParam(scene_name, param_name)

func callSceneService(scene_name, func_name, params):
	return SceneManager.callService(scene_name, func_name, params)

func switchScene(scene_ref, signal_name, next_scene_name):
	scene_ref.switchScene(signal_name, next_scene_name)

func __initFuncForm():
	addFuncForm("fetchFromScene", "all", ["String", "String"])
	addFuncForm("callSceneService", "all", ["String", "String", "Array"])
	addFuncForm("switchScene", "null", ["Object", "String", "String"])

