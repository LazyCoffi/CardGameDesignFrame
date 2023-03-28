extends "res://class/functional/FuncSet.gd"
class_name ArchiveOperFuncSet

func _init():
	__initFuncForm()

func createArchive():
	SceneManager.createArchive()

func saveArchive():
	SceneManager.saveArchive()

func __initFuncForm():
	addFuncForm("saveArchive", "null", [])
	addFuncForm("createArchive", "null", [])
