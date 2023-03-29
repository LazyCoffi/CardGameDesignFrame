extends "res://scene/BaseModel.gd"
class_name ArchiveModel

var selected_archive	# Archive
var page_index		 	# int
var return_function		# HyperFunction

func _init():
	selected_archive = null
	page_index = 1
	return_function = null

func getPageSize():
	return 3

func getMaxArchiveNum():
	return 3

func getButtonRectSize():
	return Vector2(210, 90)

func getLoadButtonPosition():
	return Vector2(112, 480)

func getDeleteButtonPosition():
	return Vector2(112, 600)

func getBackButtonPosition():
	return Vector2(112, 720)

func getLabelRectSize():
	return Vector2(180, 72)

func getLabelPosition():
	return Vector2(15, 9)

func getLoadLabelText():
	return "读取"

func getDeleteLabelText():
	return "删除"

func getBackLabelText():
	return "返回"

func getSwitchRectSize():
	return Vector2(128, 56)

func getNextButtonPosition():
	return Vector2(1032, 792)

func getPreviousButtonPosition():
	return Vector2(24, 792)

func getCardRectSize():
	return Vector2(360, 720)

func getCardPositionList():
	return [
				Vector2(12, 56),
				Vector2(400, 56),
				Vector2(792, 56)
			]

func getCardTextRectSize():
	return Vector2(296, 72)

func getCardTextPosition():
	return Vector2(32, 596)

func getInfoLabelRectSize():
	return Vector2(120, 40)

func getInfoCreatePosition():
	return Vector2(45, 25)

func getInfoUpdatePosition():
	return Vector2(45, 65)

func getInfoCreateTimePosition():
	return Vector2(165, 25)

func getInfoUpdateTimePosition():
	return Vector2(165, 65)

func getInfoCreateText():
	return "创建时间"

func getInfoUpdateText():
	return "更新时间"

func hasSelectedArchive():
	return not selected_archive == null

func getSelectedArchive():
	return selected_archive

func resetSelectedArchive():
	selected_archive = null

func selectArchive(archive):
	selected_archive = archive

func getPageIndex():
	return page_index

func nextPage():
	page_index += 1

func previousPage():
	page_index = max(1, page_index - 1)

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
