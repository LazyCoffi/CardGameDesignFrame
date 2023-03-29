extends "res://scene/BaseModel.gd"
class_name DialogModel

var HyperFunction = TypeUnit.type("HyperFunction")

class DialogOption:
	var option_text		# String
	var effect_func		# HyperFunction

	func _init():
		option_text = ""
		effect_func = null
	
	func getOptionText():
		return option_text

	func setOptionText(option_text_):
		option_text = option_text_
	
	func execEffectFunc(scene_ref):
		return effect_func.exec([scene_ref])
	
	func setEffectFunc(effect_func_):
		effect_func = effect_func_
	
	func pack():
		var script_tree = ScriptTree.new()

		script_tree.addAttr("option_text", option_text)
		script_tree.addObject("effect_func", effect_func)

		return script_tree
	
	func loadScript(script_tree):
		option_text = script_tree.getStr("option_text")
		effect_func = script_tree.getObject("effect_func", HyperFunction)

var dialog_title		# String
var dialog_info			# String
var option_list			# DialogOption_Array

func _init():
	dialog_title = ""
	dialog_info = ""
	option_list = []

func getDialogFrameRectSize():
	return Vector2(1600, 900)

func getDialogFramePosition():
	return Vector2(160, 90)

func getDialogTitleRectSize():
	return Vector2(720, 90)

func getDialogTitlePosition():
	return Vector2(40, 45)

func getDialogPicRectSize():
	return Vector2(720, 720)

func getDialogPicPosition():
	return Vector2(40, 135)

func getInfoRectSize():
	return Vector2(720, 270)

func getInfoPosition():
	return Vector2(840, 45)

func getOptionFrameRectSize():
	return Vector2(720, 480)

func getOptionFramePosition():
	return Vector2(840, 315)

func getOptionButtonRectSize():
	return Vector2(640, 100)

func getMaxOptionNum():
	return 4

func getTitle():
	return dialog_title

func setTitle(dialog_title_):
	dialog_title = dialog_title_

func getInfo():
	return dialog_info

func setInfo(dialog_info_):
	dialog_info = dialog_info_

func getOptionNum():
	return option_list.size()

func getOptionTextList():
	var ret = []
	for option in option_list:
		ret.append(option.getOptionText())
	
	return ret

func execOptionEffectFunc(index, scene_ref):
	option_list[index].execEffectFunc(scene_ref)

func addOption(option_text, effect_func):
	var max_option_num = getMaxOptionNum()
	if option_list.size() >= max_option_num:
		Logger.warning("Option num reachs the limit!")
		return
	
	var option = DialogOption.new()
	option.setOptionText(option_text)
	option.setEffectFunc(effect_func)
	option_list.append(option)

func delOption(index):
	option_list.remove(index)

func clearOption():
	option_list.clear()

func pack():
	var script_tree = ScriptTree.new()

	script_tree.addAttr("dialog_title", dialog_title)
	script_tree.addAttr("dialog_info", dialog_info)
	script_tree.addObjectArray("option_list", option_list)

	return script_tree

func loadScript(script_tree):
	dialog_title = script_tree.getStr("dialog_title")
	dialog_info = script_tree.getStr("dialog_info")
	option_list = script_tree.getObjectArray("option_list", DialogOption)
