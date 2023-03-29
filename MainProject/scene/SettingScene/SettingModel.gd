extends "res://scene/BaseModel.gd"
class_name SettingModel

var HyperFunction = TypeUnit.type("HyperFunction")

var return_function			# HyperFunction

func getSettingFrameRectSize():
	return Vector2(600, 600)

func getSettingFramePosition():
	return Vector2(660, 240)

func getBgmTextRectSize():
	return Vector2(120, 120)

func getBgmTextPosition():
	return Vector2(60, 60)

func getBgmText():
	return "BGM音量"

func getBgmVolumeRectSize():
	return Vector2(360, 120)

func getBgmVolumePosition():
	return Vector2(180, 60)

func getSoundTextRectSize():
	return Vector2(120, 120)

func getSoundTextPosition():
	return Vector2(60, 240)

func getSoundText():
	return "音效音量"

func getSoundVolumeRectSize():
	return Vector2(360, 120)

func getSoundVolumePosition():
	return Vector2(180, 240)

func getReturnButtonRectSize():
	return Vector2(240, 120)

func getReturnButtonPosition():
	return Vector2(180, 420)

func getReturnTextRectSize():
	return Vector2(240, 120)

func getReturnTextPosition():
	return Vector2(0, 0)

func getReturnText():
	return "返回"

func getVolumeMarkRectSize():
	return Vector2(20, 120)

func returnFunction(scene_ref):
	return_function.exec([scene_ref])

func setReturnFunction(return_function_):
	return_function = return_function_

func pack():
	var script_tree = ScriptTree.new()

	script_tree.addObject("return_function", return_function)

	return script_tree

func loadScript(script_tree):
	return_function = script_tree.getObject("return_function", HyperFunction)
