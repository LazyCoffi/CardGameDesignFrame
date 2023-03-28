extends Node
class_name SettingModel

var ScriptTree = TypeUnit.type("ScriptTree")
var HyperFunction = TypeUnit.type("HyperFunction")

const SETTING_FRAME_RECT_SIZE = Vector2(600, 600)
const SETTING_FRAME_POSITION = Vector2(660, 240)
const BGM_TEXT_RECT_SIZE = Vector2(120, 120)
const BGM_TEXT_POSITION = Vector2(60, 60)
const BGM_TEXT = "BGM音量"
const BGM_VOLUME_RECT_SIZE = Vector2(360, 120)
const BGM_VOLUME_POSITION = Vector2(180, 60)
const SOUND_TEXT_RECT_SIZE = Vector2(120, 120)
const SOUND_TEXT_POSITION = Vector2(60, 240)
const SOUND_TEXT = "音效音量"
const VOLUME_MARK_RECT_SIZE = Vector2(20, 120)
const SOUND_VOLUME_RECT_SIZE = Vector2(360, 120)
const SOUND_VOLUME_POSITION = Vector2(180, 240)
const RETURN_BUTTON_RECT_SIZE = Vector2(240, 120)
const RETURN_BUTTON_POSITION = Vector2(180, 420)
const RETURN_TEXT_RECT_SIZE = Vector2(240, 120)
const RETURN_TEXT_POSITION = Vector2(0, 0)
const RETURN_TEXT = "返回"

var return_function			# HyperFunction

func getSettingFrameRectSize():
	return SETTING_FRAME_RECT_SIZE

func getSettingFramePosition():
	return SETTING_FRAME_POSITION

func getBgmTextRectSize():
	return BGM_TEXT_RECT_SIZE

func getBgmTextPosition():
	return BGM_TEXT_POSITION

func getBgmText():
	return BGM_TEXT

func getBgmVolumeRectSize():
	return BGM_VOLUME_RECT_SIZE

func getBgmVolumePosition():
	return BGM_VOLUME_POSITION

func getSoundTextRectSize():
	return SOUND_TEXT_RECT_SIZE

func getSoundTextPosition():
	return SOUND_TEXT_POSITION

func getSoundText():
	return SOUND_TEXT

func getSoundVolumeRectSize():
	return SOUND_VOLUME_RECT_SIZE

func getSoundVolumePosition():
	return SOUND_VOLUME_POSITION

func getReturnButtonRectSize():
	return RETURN_BUTTON_RECT_SIZE

func getReturnButtonPosition():
	return RETURN_BUTTON_POSITION

func getReturnTextRectSize():
	return RETURN_TEXT_RECT_SIZE

func getReturnTextPosition():
	return RETURN_TEXT_POSITION

func getReturnText():
	return RETURN_TEXT

func getVolumeMarkRectSize():
	return VOLUME_MARK_RECT_SIZE

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
