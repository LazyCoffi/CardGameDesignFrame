extends Node
class_name ArchiveModel

const MAX_ARCHIVE_NUM = 3
const BUTTON_RECT_SIZE = Vector2(210, 90)
const LABEL_RECT_SIZE = Vector2(180, 72)
const LABEL_POSITION = Vector2(15, 9)
const LOAD_BUTTON_POSITION = Vector2(112, 480)
const DELETE_BUTTON_POSITION = Vector2(112, 600)
const BACK_BUTTON_POSITION = Vector2(112, 720)
const LOAD_LABEL_TEXT = "读取"
const DELETE_LABEL_TEXT = "删除"
const BACK_LABEL_TEXT = "返回"
const SWITCH_RECT_SIZE = Vector2(128, 56)
const NEXT_BUTTON_POSITION = Vector2(1032, 792)
const PREVIOUS_BUTTON_POSITION = Vector2(24, 792)
const CARD_RECT_SIZE = Vector2(360, 720)
const CARD_POSITION_LIST = [
			Vector2(12, 56),
			Vector2(400, 56),
			Vector2(792, 56)
		]
const CARD_TEXT_RECT_SIZE = Vector2(296, 72)
const CARD_TEXT_POSITION = Vector2(32, 596)
const INFO_LABEL_RECT_SIZE = Vector2(120, 40)
const INFO_CREATE_TEXT = "创建时间"
const INFO_UPDATE_TEXT = "更新时间"
const INFO_CREATE_POSITION = Vector2(45, 25)
const INFO_UPDATE_POSITION = Vector2(45, 65)
const INFO_CREATE_TIME_POSITION = Vector2(165, 25)
const INFO_UPDATE_TIME_POSITION = Vector2(165, 65)
const PAGE_SIZE = 3

var selected_archive	# Archive
var page_index		 	# int
var return_function		# HyperFunction

func _init():
	selected_archive = null
	page_index = 1
	return_function = null

func getPageSize():
	return PAGE_SIZE

func getMaxArchiveNum():
	return MAX_ARCHIVE_NUM

func getButtonRectSize():
	return BUTTON_RECT_SIZE

func getLoadButtonPosition():
	return LOAD_BUTTON_POSITION

func getDeleteButtonPosition():
	return DELETE_BUTTON_POSITION

func getBackButtonPosition():
	return BACK_BUTTON_POSITION

func getLabelRectSize():
	return LABEL_RECT_SIZE

func getLabelPosition():
	return LABEL_POSITION

func getLoadLabelText():
	return LOAD_LABEL_TEXT

func getDeleteLabelText():
	return DELETE_LABEL_TEXT

func getBackLabelText():
	return BACK_LABEL_TEXT

func getSwitchRectSize():
	return SWITCH_RECT_SIZE

func getNextButtonPosition():
	return NEXT_BUTTON_POSITION

func getPreviousButtonPosition():
	return PREVIOUS_BUTTON_POSITION

func getCardRectSize():
	return CARD_RECT_SIZE

func getCardPositionList():
	return CARD_POSITION_LIST

func getCardTextRectSize():
	return CARD_TEXT_RECT_SIZE

func getCardTextPosition():
	return CARD_TEXT_POSITION

func getInfoLabelRectSize():
	return INFO_LABEL_RECT_SIZE

func getInfoCreatePosition():
	return INFO_CREATE_POSITION

func getInfoUpdatePosition():
	return INFO_UPDATE_POSITION

func getInfoCreateTimePosition():
	return INFO_CREATE_TIME_POSITION

func getInfoUpdateTimePosition():
	return INFO_UPDATE_TIME_POSITION

func getInfoCreateText():
	return INFO_CREATE_TEXT

func getInfoUpdateText():
	return INFO_UPDATE_TEXT

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
