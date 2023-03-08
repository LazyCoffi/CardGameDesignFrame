extends Control

var FactoryTree = TypeUnit.type("FactoryTree")
var Factory = TypeUnit.type("Factory")

enum {
	WALK_UP,
	WALK_DOWN,
	WALK_DOWN_INTO,
	ADD_ARRAY_OBJECT,
	DEL_ARRAY_OBJECT,
	ADD_DICT_OBJECT,
	DEL_DICT_OBJECT,
	CALL_FUNC,
	SET_FUNC_PARAM_PATH,
	SET_COMMON_TYPE,
	RESET_COMMON_TYPE,
	SET_LOCAL_COM_TYPE,
	RESET_LOCAL_COM_TYPE,
}

var factory_tree		# FactoryTree
var jump_table			# Dict
var export_table		# Dict

func _init():
	jump_table = {}
	factory_tree = FactoryTree.new()
	__initExportTable()

func _ready():
	initToolBar()

func exportAsJson():
	factory_tree.getRoot().recursionBuild()

	var current_time = TimeUnit.getDateTimeStr()

	var directory = Directory.new()
	var script_dir = "res://design/outputs/" + current_time + "/"
	var system_dir = "res://design/outputs/" + current_time + "/system/"
	var scene_dir = "res://design/outputs/" + current_time + "/scene/"
	directory.make_dir(script_dir)
	directory.make_dir(system_dir)
	directory.make_dir(scene_dir)

	var table = factory_tree.getRoot().getChTable()
	for key in table.keys():
		match export_table[key]["type"]:
			"Object":
				var script_tree = table[key].getEntity().pack()
				script_tree.exportAsJson(system_dir + export_table[key]["filename"])
			"Scene":
				var inner_table = table[key]
				for inner_key in inner_table:
					var script_tree = inner_table[inner_key].getEntity().pack()
					var scene_name = inner_table[inner_key].getEntity().getSceneName()
					script_tree.exportAsJson(scene_dir + scene_name + ".json")

func __initExportTable():
	export_table = {}
	__addExportIndex("GlobalSetting", "Object", "global_setting.json")
	__addExportIndex("CardCache", "Object", "card_templates.json")
	__addExportIndex("ResourceUnit", "Object", "resource_unit.json")
	__addExportIndex("MainMenuScene", "Scene", null)
	__addExportIndex("SubMenuScene", "Scene", null)
	__addExportIndex("LinearBattleScene", "Scene", null)
	__addExportIndex("ArchiveScene", "Scene", null)

func __addExportIndex(index, type, filename):
	export_table[index] = {
		"type" : type,
		"filename" : filename
	}

func initToolBar():
	var file_button = get_node("ToolBarSpliter").get_node("ToolBar").get_node("FileMenu")
	var file_pop_menu = file_button.get_popup()

	file_pop_menu.add_item("New Project", 0)
	file_pop_menu.add_item("Open Project", 1)
	file_pop_menu.add_item("Save Project", 2)
	file_pop_menu.add_item("Export Script", 3)

	file_button.connect("pressed", file_pop_menu, "popup")

	file_pop_menu.connect("id_pressed", self, "filePopMenuHandle")

func initClassLibrary():
	var class_library = get_node("ClassLibrary")

	var class_list = TypeUnit.filter(TypeUnit.FACTORY).keys()
	
	for index in range(class_list.size()):
		var inner_name = class_list[index]
		class_library.add_item(inner_name, index)

func filePopMenuHandle(id):
	match id:
		0:
			newProject()
			renderMemberView()
			renderOperView()

func newProject():
	factory_tree.create()

func renderMemberView():
	var member_tree = __getMemberTree()
	member_tree.clear()

	__connectMemberView(member_tree)
	__renderMemberParent(member_tree)	
	
	var main_node = __renderMemberMainNode(member_tree)
	var local_node = __renderMemberLocalNode(member_tree)

	var member_list = factory_tree.getMemberList()
	
	for member in member_list:
		match member["type"]:
			Factory.OBJ_MEM:
				__renderObjectMember(member, main_node, member_tree)
			Factory.COM_OBJ_MEM:
				__renderCommonObjectMember(member, main_node, member_tree)
			Factory.OBJ_ARR_MEM:
				__renderObjectArrayMember(member, main_node, member_tree)
			Factory.OBJ_DICT_MEM:
				__renderObjectDictMember(member, main_node, member_tree)
			Factory.LOCAL_OBJ_MEM:
				__addLocalObjectMember(member, local_node, member_tree)
			Factory.LOCAL_COM_MEM:
				__addLocalCommonMember(member, local_node, member_tree)


func __connectMemberView(member_tree):
	if not member_tree.is_connected("button_pressed", self, "__handleButton"):
		Logger.assert(member_tree.connect("button_pressed", self, "__handleButton") == 0, "Connect fail!")


func __getMemberTree():
	return get_node("ToolBarSpliter/WorkspaceSpliter/MemberTree")

func __getOperTree():
	return get_node("ToolBarSpliter/WorkspaceSpliter/ViewSpliter/OperTree")

func __getFileDialog():
	return get_node("FileDialog")

func __getClassLibrary():
	return get_node("ClassLibrary")

func __renderMemberParent(member_tree):
	var parent_node = member_tree.create_item()
	var parent_button_texture = load("res://design/asserts/rollback_16x16.png")
	parent_node.set_text(0, "[Upper]")
	__addJumpIndex("[Upper]", 0, parent_node.get_button_count(0), WALK_UP, null)
	parent_node.add_button(0, parent_button_texture)
	parent_node.set_expand_right(0, true)

func __renderMemberLocalNode(member_tree):
	var local_node = member_tree.create_item()
	local_node.set_text(0, "[Local Object]")
	local_node.set_expand_right(1, true)

	return local_node

func __renderMemberMainNode(member_tree):
	var main_node = member_tree.create_item()
	main_node.set_text(0, "ObjectRoot")
	main_node.set_expand_right(0, true)

	return main_node

func __renderObjectMember(member, main_node, member_tree):
	var edit_node = member_tree.create_item(main_node)
	var edit_button_texture = load("res://design/asserts/edit_16x16.png")
	edit_node.set_text(0, member["name"])
	__addJumpIndex(member["name"], 0, edit_node.get_button_count(0), WALK_DOWN, member)
	edit_node.add_button(0, edit_button_texture)
	edit_node.set_expand_right(0, true)

func __renderCommonObjectMember(member, main_node, member_tree):
	var common_node = member_tree.create_item(main_node)
	if member["class_type"] == null:
		__renderEmptyCommon(member, common_node)
	else:
		__renderFullCommon(member, common_node)

func __renderEmptyCommon(member, common_node):
	if common_node.get_button_count() > 0:	
		common_node.erase_button(1, 0)

	common_node.set_text(0, member["name"])
	common_node.set_text(1, "[Common Object]")

	var library_button_texture = load("res://design/asserts/word_16x16.png")
	__addJumpIndex(member["name"], 1, common_node.get_button_count(1), SET_COMMON_TYPE, member)
	common_node.add_button(1, library_button_texture)

func __renderFullCommon(member, common_node):
	if common_node.get_button_count() > 0:	
		common_node.erase_button(1, 0)

	common_node.set_text(0, member["name"])
	common_node.set_text(1, "<" + member["class_type"] + ">")
	
	var edit_button_texture = load("res://design/asserts/reset_16x16.png")
	__addJumpIndex(member["name"], 1, common_node.get_button_count(1), WALK_DOWN, member)
	common_node.add_button(0, edit_button_texture)

	var reset_button_texure = load("res://design/asserts/retry_16x16.png")
	__addJumpIndex(member["name"], 1, common_node.get_button_count(0), RESET_COMMON_TYPE, member)
	common_node.add_button(1, reset_button_texure)

func __renderEmptyLocalCommon(member, common_node):
	if common_node.get_button_count() > 0:	
		common_node.erase_button(1, 0)

	common_node.set_text(0, member["func_name"] + "_" + member["index"])
	common_node.set_text(1, "[Common Object]")

	var library_button_texture = load("res://design/asserts/word_16x16.png")
	__addJumpIndex(member["func_name"] + "_" + member["index"], 1, common_node.get_button_count(1), SET_COMMON_TYPE, member)
	common_node.add_button(1, library_button_texture)

func __renderFullLocalCommon(member, common_node):
	if common_node.get_button_count() > 0:	
		common_node.erase_button(1, 0)

	common_node.set_text(0, member["func_name"] + "_" + member["index"])
	common_node.set_text(1, "<" + member["class_type"] + ">")
	
	var edit_button_texture = load("res://design/asserts/reset_16x16.png")
	__addJumpIndex(member["func_name"] + "_" + member["index"], 1, common_node.get_button_count(1), WALK_DOWN, member)
	common_node.add_button(0, edit_button_texture)

	var reset_button_texure = load("res://design/asserts/retry_16x16.png")
	__addJumpIndex(member["func_name"] + "_" + member["index"], 1, common_node.get_button_count(0), RESET_COMMON_TYPE, member)
	common_node.add_button(1, reset_button_texure)

func __renderObjectArrayMember(member, main_node, member_tree):
	var container_node = member_tree.create_item(main_node)
	container_node.set_text(0, member["name"])

	var add_button_texture = load("res://design/asserts/queue_16x16.png")
	__addJumpIndex(member["name"], 0, container_node.get_button_count(0), ADD_ARRAY_OBJECT, member)
	container_node.add_button(0, add_button_texture)
	container_node.set_expand_right(0, true)

	for inner_member in member["container"]:
		__addArrayInnerMember(inner_member, container_node, member_tree)
		
func __addArrayInnerMember(inner_member, container_node, member_tree):
	var inner_node = member_tree.create_item(container_node)
	inner_node.set_text(0, inner_member["container_name"] + "[" + str(inner_member["index"]) + "]")

	var edit_button_texture = load("res://design/asserts/edit_16x16.png")
	__addJumpIndex(inner_member["container_name"] + "[" + str(inner_member["index"]) + "]", 0, inner_node.get_button_count(0), WALK_DOWN_INTO, inner_member)
	inner_node.add_button(0, edit_button_texture)

	var remove_button_texture = load("res://design/asserts/close_16x16.png")
	__addJumpIndex(inner_member["container_name"] + "[" + str(inner_member["index"]) + "]", 0, inner_node.get_button_count(0), DEL_ARRAY_OBJECT, inner_member)
	inner_node.add_button(0, remove_button_texture)

	inner_node.set_expand_right(0, true)

func __delArrayInnerMember(item):
	var container_node = item.get_parent()
	container_node.remove_child(item)

func __renderObjectDictMember(member, main_node, member_tree):
	var container_node = member_tree.create_item(main_node)
	container_node.set_text(0, member["name"])
	container_node.set_editable(1, true)

	var add_button_texture = load("res://design/asserts/queue_16x16.png")
	__addJumpIndex(member["name"], 1, container_node.get_button_count(1), ADD_DICT_OBJECT, member)
	container_node.add_button(1, add_button_texture)

	for inner_member in member["container"]:
		__addDictInnerMember(inner_member, container_node, member_tree)
	
func __addLocalObjectMember(member, local_node, member_tree):
	var loc_node = member_tree.create_item(local_node)
	loc_node.set_text(0, member["func_name"] + "_" + member["index"])

	var edit_button_texture = load("res://design/asserts/edit_16x16.png")
	__addJumpIndex(member["func_name"] + "_" + member["index"], 0, loc_node.get_button_count(0), WALK_DOWN_INTO, member)
	loc_node.add_button(0, edit_button_texture)

func __addLocalCommonMember(member, local_node, member_tree):
	var loc_node = member_tree.create_item(local_node)
	if member["class_type"] == null:
		__renderEmptyLocalCommon(member, loc_node)
	else:
		__renderFullLocalCommon(member, loc_node)

func __addDictInnerMember(inner_member, container_node, member_tree):
	var inner_node = member_tree.create_item(container_node)
	inner_node.set_text(0, inner_member["index"])

	var edit_button_texture = load("res://design/asserts/edit_16x16.png")
	__addJumpIndex(inner_member["index"], 0, inner_node.get_button_count(0), WALK_DOWN_INTO, inner_member)
	inner_node.add_button(0, edit_button_texture)

	var remove_button_texture = load("res://design/asserts/close_16x16.png")
	__addJumpIndex(inner_member["index"], 0, inner_node.get_button_count(0), DEL_DICT_OBJECT, inner_member)
	inner_node.add_button(0, remove_button_texture)

	inner_node.set_expand_right(0, true)

func __delDictInnerMember(item):
	var container_node = item.get_parent()
	container_node.remove_child(item)

func renderOperView():
	var member_list = factory_tree.getMemberList()
	var oper_tree = __getOperTree()

	var main_node = __renderOperMainNode(oper_tree)
	
	for member in member_list:
		if member["type"] == Factory.FUNC_MEM:
			__renderFuncOper(member, main_node, oper_tree)

func __renderOperMainNode(oper_tree):
	var main_node = oper_tree.create_item()
	main_node.set_text("Avaiable Opers")
	main_node.set_expand_right(0, true)

	return main_node

func __connectOperView(oper_tree):
	if not oper_tree.is_connected("button_pressed", self, "__handleButton"):
		Logger.assert(oper_tree.connect("button_pressed", self, "__handleButton") == 0, "Connect fail!")

func __renderFuncOper(member, main_node, oper_tree):
	var func_node = oper_tree.create_item(main_node)
	func_node.set_text(0, member["name"])

	var call_button_texture = load("res://design/asserts/caret-right-small_16x16.png")
	__addJumpIndex(member["name"], 0, func_node.get_button_count(0), CALL_FUNC, member)
	func_node.add_button(0, call_button_texture)
	func_node.set_expand_right(0, true)

	for inner_member in member["params"]:
		var inner_node = oper_tree.create_item(func_node)
		inner_node.set_text(0, inner_member["name"])

		if inner_member["param"] != null:
			inner_node.set_text(1, str(inner_member["param"]))
		else:
			inner_node.set_text(1, "")

		match inner_member["param_type"]:
			"val":
				inner_node.set_editable(1, true)
			"path":
				__addJumpIndex(inner_member["name"], 0, inner_node.get_button_count(0), SET_FUNC_PARAM_PATH, inner_member)
				var directory_button_texture = load("res://design/asserts/root-list_16x16.png")
				inner_node.add_button(0, directory_button_texture)
			"obj":
				#TODO: 添加obj参数操作
				pass
			"common_obj":
				#TODO: 添加common_obj参数操作
				pass

func __addJumpIndex(member_name, column, id, handle_type, content):
	if not jump_table.has(member_name):
		jump_table[member_name] = {}
	if not jump_table[member_name].has(column):
		jump_table[member_name][column] = {}
	if not jump_table[member_name][column].has(id):
		jump_table[member_name][column][id] = {}

	jump_table[member_name][column][id] = {
		"handle_type" : handle_type, 
		"content" : content
	}

func __handleButton(item, column, id):
	var member_name = item.get_text(0)
	var handle_type = jump_table[member_name][column][id]["handle_type"]
	var content = jump_table[member_name][column][id]["content"]

	__refreshConfigText()

	match handle_type:
		WALK_UP:
			__walkUp(content, item)
		WALK_DOWN:
			__walkDown(content, item)
		WALK_DOWN_INTO:
			__walkDownInto(content, item)
		ADD_ARRAY_OBJECT:
			__addArrayObject(content, item)
		DEL_ARRAY_OBJECT:
			__delArrayObject(content, item)
		ADD_DICT_OBJECT:
			__addDictObject(content, item)
		DEL_DICT_OBJECT:
			__delDictObject(content, item)
		CALL_FUNC:
			__callFunc(content, item)
		SET_FUNC_PARAM_PATH:
			__setFuncParamPath(content, item)
		SET_COMMON_TYPE:
			__setCommonType(content, item)
		RESET_COMMON_TYPE:
			__resetCommonType(content, item)
		SET_LOCAL_COM_TYPE:
			__setLocalCommonType(content, item)
		RESET_LOCAL_COM_TYPE:
			__resetLocalCommonType(content, item)

func __walkUp(_content, _item):
	factory_tree.walkUp()
	renderMemberView()
	renderOperView()

func __walkDown(content, _item):
	factory_tree.walkDown(content["name"])
	renderMemberView()
	renderOperView()

func __walkDownInto(content, _item):
	factory_tree.walkDownInto(content["name"], content["index"])
	renderMemberView()
	renderOperView()

func __addArrayObject(content, item):
	var inner_member = factory_tree.addObjectIntoArray(content["name"])
	var member_tree = __getMemberTree()
	__addArrayInnerMember(inner_member, item, member_tree)

func __delArrayObject(content, item):
	factory_tree.delObjectFromArray(content["index"])
	__delArrayInnerMember(item)

func __addDictObject(content, item):
	var index = item.get_text(1)
	var inner_member = factory_tree.addObjectIntoDict(content["name"], index)
	var member_tree = __getMemberTree()
	__addArrayInnerMember(inner_member, item, member_tree)

func __delDictObject(content, item):
	factory_tree.delObjectFromArray(content["index"])
	__delArrayInnerMember(item)

func __setCommonType(content, item):
	var class_library = __getClassLibrary()
	if not class_library.is_connected("index_pressed", self, "__setCommonTypeHook"):
		class_library.is_connected("index_pressed", self, "__setCommonTypeHook", [content, item])
	
	class_library.popup_centered()

func __setCommonTypeHook(target_idx, content, item):
	var class_library = __getClassLibrary()
	var cl_name = class_library.get_item_text(target_idx)
	
	factory_tree.setCommonObjectType(content["name"], cl_name)
	__renderFullCommon(content, item)

func __resetCommonType(content, item):
	factory_tree.resetCommonObjectType(content["name"])
	__renderEmptyCommon(content, item)

func __setLocalCommonType(content, item):
	var class_library = __getClassLibrary()
	if not class_library.is_connected("index_pressed", self, "__setCommonTypeHook"):
		class_library.is_connected("index_pressed", self, "__setCommonTypeHook", [content, item])
	
	class_library.popup_centered()

func __setLocalCommonTypeHook(target_idx, content, item):
	var class_library = __getClassLibrary()
	var cl_name = class_library.get_item_text(target_idx)
	
	factory_tree.setCommonObjectType(content["func_name,"], content["index"], cl_name)
	__renderFullLocalCommon(content, item)

func __resetLocalCommonType(content, item):
	factory_tree.resetCommonObjectType(content["func_name"], content["index"])
	__renderEmptyLocalCommon(content, item)

func __callFunc(item):
	# TODO
	factory_tree.callFunc(func_name, params)

func __setFuncParamPath(content, _item):
	var file_dialog = get_node("FileDialog")

	file_dialog.popup_centered(Vector2(960, 540))

	if not file_dialog.is_connected("file_selected", self, "__setFuncParamPathHook"):
		file_dialog.connect("file_selected", self, "__setFuncParamPathHook", [content["func_name"], content["name"]])

func __setFuncParamPathHook(path, func_name, param_name):
	var file_dialog = get_node("FileDialog")
	file_dialog.hide()

	# TODO

	factory_tree.getNode().setFuncParam(func_name, param_name, path)
