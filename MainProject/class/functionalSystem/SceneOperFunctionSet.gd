extends "res://class/functionalSystem/FunctionalSet.gd"
class_name SceneOperFunctionSet

func fetchFromScene(scene_name, param_name):
	return SceneCache.fetchParam(scene_name, param_name)

func callSceneService(scene_name, func_name, params):
	return SceneCache.callService(scene_name, func_name, params)

func switchScene(scene_ref, signal_name, next_scene_name):
	scene_ref.switchScene(signal_name, next_scene_name)

func __initFuncForm():
	addFuncForm("fetchFromScene", "all", ["String", "String"])
	addFuncForm("callSceneService", "all", ["String", "String", "Array"])
	addFuncForm("switchScene", "null", ["Object", "String", "String"])

