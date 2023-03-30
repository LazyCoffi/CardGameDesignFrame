extends Control

var FactoryTree = TypeUnit.type("FactoryTree")
var Factory = TypeUnit.type("Factory")
var ScriptTree = TypeUnit.type("ScriptTree")

enum {
	WALK_UP,
	WALK_DOWN,
	WALK_DOWN_INTO,
	WALK_DOWN_LOCAL,
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
var project_path		# String

func _init():
	project_path = null
	jump_table = {}
	factory_tree = FactoryTree.new()

func _ready():
	initToolBar()
	initClassLibrary()

func initToolBar():
	var file_button = get_node("ToolBarSpliter").get_node("ToolBar").get_node("FileMenu")
	file_button.set_text("File")
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
		if inner_name == "Factory":
			continue

		inner_name = inner_name.trim_suffix("Factory")
		class_library.add_item(inner_name, index)

func __getMemberTree():
	return get_node("ToolBarSpliter/WorkspaceContainer/MemberTree")

func __getOperTree():
	return get_node("ToolBarSpliter/WorkspaceContainer/OperTree")

func __getOverviewTree():
	return get_node("ToolBarSpliter/WorkspaceContainer/OverviewTree")

func __getResourceDialog():
	return get_node("ResourceDialog")

func __getClassLibrary():
	return get_node("ClassLibrary")

func __getOpenProjectDialog():
	return get_node("OpenProjectDialog")

func __getSaveProjectDialog():
	return get_node("SaveProjectDialog")

func __getExportProjectDialog():
	return get_node("ExportProjectDialog")

func filePopMenuHandle(id):
	match id:
		0:
			newProject()
			renderMemberView()
			renderOperView()
		1:
			openProject()
		2:
			saveProject()
		3:
			exportProject()
			
func newProject():
	factory_tree.clear()
	factory_tree.create()
	project_path = ""

func openProject():
	var project_dialog = __getOpenProjectDialog()
	project_dialog.popup_centered(Vector2(960, 540))

	if not project_dialog.is_connected("file_selected", self, "__openProjectHook"):
		project_dialog.connect("file_selected", self, "__openProjectHook")

func __openProjectHook(path):
	var script_tree = ScriptTree.new()
	script_tree.loadFromJson(path)
	var proj = script_tree.getRawAttr("proj")
	factory_tree.clear()
	factory_tree.construct(proj)

	project_path = path

	renderMemberView()
	renderOperView()

func saveProject():
	if project_path == null:
		return

	if project_path == "":
		var project_dialog = __getSaveProjectDialog()
		project_dialog.popup_centered(Vector2(960, 540))
		if not project_dialog.is_connected("file_selected", self, "__saveProjectHook"):
			project_dialog.connect("file_selected", self, "__saveProjectHook")
	else:
		var script_tree = factory_tree.exportProject()
		script_tree.exportAsJson(project_path)

func __saveProjectHook(path):
	var file = File.new()
	if not file.file_exists(path):
		var script_tree = factory_tree.saveProject()
		script_tree.exportAsJson(path)
		project_path = path
	
func exportProject():
	var project_dialog = __getExportProjectDialog()
	project_dialog.popup_centered(Vector2(960, 540))
	if not project_dialog.is_connected("dir_selected", self, "__exportProjectHook"):
		project_dialog.connect("dir_selected", self, "__exportProjectHook")

func __exportProjectHook(path):
	factory_tree.exportProject(path)

func renderMemberView():
	var member_tree = __getMemberTree()
	member_tree.clear()

	__connectMemberView(member_tree)

	var title_node = __renderMemberTitleNode(member_tree)
	__renderMemberParent(title_node, member_tree)	
	var main_node = __renderMemberMainNode(title_node, member_tree)
	var local_node = __renderMemberLocalNode(title_node, member_tree)

	var member_list = factory_tree.getMemberList()
	
	for member in member_list:
		match int(member["type"]):
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

func __renderMemberTitleNode(member_tree):
	var title_node = member_tree.create_item()
	title_node.set_text(0, "MemberView")
	title_node.set_expand_right(0, true)

	return title_node

func __renderMemberParent(title_node, member_tree):
	var parent_node = member_tree.create_item(title_node)
	var parent_button_texture = load("res://design/asserts/rollback_16x16.png")
	parent_node.set_text(0, "<Upper>")
	__addJumpIndex("<Upper>", 0, parent_node.get_button_count(0), WALK_UP, null)
	parent_node.add_button(0, parent_button_texture)
	parent_node.set_expand_right(0, true)


func __renderMemberMainNode(title_node, member_tree):
	var main_node = member_tree.create_item(title_node)
	main_node.set_text(0, "<Member Object>")
	main_node.set_expand_right(0, true)

	return main_node

func __renderMemberLocalNode(title_node, member_tree):
	var local_node = member_tree.create_item(title_node)
	local_node.set_text(0, "<Local Object>")
	local_node.set_expand_right(0, true)

	return local_node

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
	if common_node.get_button_count(1) > 0:	
		common_node.erase_button(1, 0)

	common_node.set_text(0, member["name"])
	common_node.set_text(1, "<Common Object>")

	var library_button_texture = load("res://design/asserts/word_16x16.png")
	__addJumpIndex(member["name"], 1, common_node.get_button_count(1), SET_COMMON_TYPE, member)
	common_node.add_button(1, library_button_texture)

func __renderFullCommon(member, common_node):
	if common_node.get_button_count(1) > 0:	
		common_node.erase_button(1, 0)

	common_node.set_text(0, member["name"])
	common_node.set_text(1, "<" + member["class_type"] + ">")
	
	var edit_button_texture = load("res://design/asserts/reset_16x16.png")
	__addJumpIndex(member["name"], 1, common_node.get_button_count(1), WALK_DOWN, member)
	common_node.add_button(0, edit_button_texture)

	var reset_button_texure = load("res://design/asserts/retry_16x16.png")
	__addJumpIndex(member["name"], 1, common_node.get_button_count(1), RESET_COMMON_TYPE, member)
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

func __addDictInnerMember(inner_member, container_node, member_tree):
	var inner_node = member_tree.create_item(container_node)
	inner_node.set_text(0, "[" + str(inner_member["index"]) + "]")

	var edit_button_texture = load("res://design/asserts/edit_16x16.png")
	__addJumpIndex("[" + str(inner_member["index"]) + "]", 0, inner_node.get_button_count(0), WALK_DOWN_INTO, inner_member)
	inner_node.add_button(0, edit_button_texture)

	var remove_button_texture = load("res://design/asserts/close_16x16.png")
	__addJumpIndex("[" + str(inner_member["index"]) + "]", 0, inner_node.get_button_count(0), DEL_DICT_OBJECT, inner_member)
	inner_node.add_button(0, remove_button_texture)

	inner_node.set_expand_right(0, true)

func __delDictInnerMember(item):
	var container_node = item.get_parent()
	container_node.remove_child(item)

func __addLocalObjectMember(member, local_node, member_tree):
	var loc_node = member_tree.create_item(local_node)
	loc_node.set_text(0, member["func_name"] + "_" + str(member["index"]))

	var edit_button_texture = load("res://design/asserts/edit_16x16.png")
	__addJumpIndex(member["func_name"] + "_" + str(member["index"]), 0, loc_node.get_button_count(0), WALK_DOWN_LOCAL, member)
	loc_node.add_button(0, edit_button_texture)

func __addLocalCommonMember(member, local_node, member_tree):
	var loc_node = member_tree.create_item(local_node)
	if member["class_type"] == null:
		__renderEmptyLocalCommon(member, loc_node)
	else:
		__renderFullLocalCommon(member, loc_node)

func __renderEmptyLocalCommon(member, common_node):
	while common_node.get_button_count(1) > 0:	
		common_node.erase_button(1, 0)

	common_node.set_text(0, member["func_name"] + "_" + str(member["index"]))
	common_node.set_text(1, "[Common Object]")

	var library_button_texture = load("res://design/asserts/word_16x16.png")
	__addJumpIndex(member["func_name"] + "_" + str(member["index"]), 1, common_node.get_button_count(1), SET_LOCAL_COM_TYPE, member)
	common_node.add_button(1, library_button_texture)

func __renderFullLocalCommon(member, common_node):
	while common_node.get_button_count(1) > 0:	
		common_node.erase_button(1, 0)

	common_node.set_text(0, member["func_name"] + "_" + str(member["index"]))
	common_node.set_text(1, "<" + member["class_type"] + ">")
	
	var edit_button_texture = load("res://design/asserts/edit_16x16.png")
	__addJumpIndex(member["func_name"] + "_" + str(member["index"]), 1, common_node.get_button_count(1), WALK_DOWN_LOCAL, member)
	common_node.add_button(1, edit_button_texture)

	var reset_button_texure = load("res://design/asserts/retry_16x16.png")
	__addJumpIndex(member["func_name"] + "_" + str(member["index"]), 1, common_node.get_button_count(1), RESET_LOCAL_COM_TYPE, member)
	common_node.add_button(1, reset_button_texure)

func renderOperView():
	var member_list = factory_tree.getMemberList()
	var oper_tree = __getOperTree()
	__connectOperView(oper_tree)
	oper_tree.clear()

	var main_node = __renderOperMainNode(oper_tree)
	
	for member in member_list:
		if int(member["type"]) == Factory.FUNC_MEM:
			__renderFuncOper(member, main_node, oper_tree)

func __renderOperMainNode(oper_tree):
	var main_node = oper_tree.create_item()
	main_node.set_text(0, "Avaiable Opers")
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
	func_node.set_expand_right(0, true)
	func_node.add_button(0, call_button_texture)

	for index in range(member["form"].size()):
		var inner_member = member["form"][index]
		var inner_node = oper_tree.create_item(func_node)
		inner_node.set_text(0, inner_member["func_name"] + ": " + inner_member["name"])

		match inner_member["param_type"]:
			"val":
				inner_node.set_editable(1, true)
			"path":
				__addJumpIndex(inner_member["func_name"] + ": " + inner_member["name"], 1, inner_node.get_button_count(1), SET_FUNC_PARAM_PATH, inner_member)
				var directory_button_texture = load("res://design/asserts/root-list_16x16.png")
				inner_node.add_button(1, directory_button_texture)
			"obj":
				continue
			"common_obj":
				inner_node.set_text(1, "<" + inner_member["name"] + "_" + str(index) + ">")

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

	match handle_type:
		WALK_UP:
			__walkUp(content, item)
		WALK_DOWN:
			__walkDown(content, item)
		WALK_DOWN_INTO:
			__walkDownInto(content, item)
		WALK_DOWN_LOCAL:
			__walkDownLocal(content, item)
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

	renderOverView()

func __walkUp(_content, _item):
	factory_tree.walkUp()
	renderMemberView()
	renderOperView()
	renderOverView()

func __walkDown(content, _item):
	factory_tree.walkDown(content["name"])
	renderMemberView()
	renderOperView()
	renderOverView()

func __walkDownInto(content, _item):
	factory_tree.walkDownInto(content["container_name"], content["index"])
	renderMemberView()
	renderOperView()
	renderOverView()

func __walkDownLocal(content, _item):
	factory_tree.walkDown(content["func_name"] + "_" + str(content["index"]))
	renderMemberView()
	renderOperView()
	renderOverView()

func __addArrayObject(content, item):
	var inner_member = factory_tree.addObjectIntoArray(content["name"])
	var member_tree = __getMemberTree()
	__addArrayInnerMember(inner_member, item, member_tree)

func __delArrayObject(content, item):
	factory_tree.delObjectFromArray(content["container_name"], content["index"])
	__delArrayInnerMember(item)

func __addDictObject(content, item):
	var index = item.get_text(1)
	var inner_member = factory_tree.addObjectIntoDict(content["name"], index)
	var member_tree = __getMemberTree()
	__addDictInnerMember(inner_member, item, member_tree)

func __delDictObject(content, item):
	factory_tree.delObjectFromDict(content["container_name"], content["index"])
	__delDictInnerMember(item)

func __setCommonType(content, item):
	var class_library = __getClassLibrary()
	if not class_library.is_connected("index_pressed", self, "__setCommonTypeHook"):
		class_library.connect("index_pressed", self, "__setCommonTypeHook", [content, item])
	
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
	if not class_library.is_connected("index_pressed", self, "__setLocalCommonTypeHook"):
		class_library.connect("index_pressed", self, "__setLocalCommonTypeHook", [content, item])
	
	class_library.popup_centered()

func __setLocalCommonTypeHook(target_idx, content, item):
	var class_library = __getClassLibrary()
	var cl_name = class_library.get_item_text(target_idx)

	if class_library.is_connected("index_pressed", self, "__setLocalCommonTypeHook"):
		class_library.disconnect("index_pressed", self, "__setLocalCommonTypeHook")

	factory_tree.setLocalCommonObjectType(content["func_name"], content["index"], cl_name)
	__renderFullLocalCommon(content, item)

func __resetLocalCommonType(content, item):
	factory_tree.resetLocalCommonObjectType(content["func_name"], content["index"])
	__renderEmptyLocalCommon(content, item)

func __callFunc(content, item):
	var iter = item.get_children()
	var params = []

	while iter != null:
		params.append(iter.get_text(1))
		iter = iter.get_next()
	
	for index in range(content["form"].size()):
		var param = params[index]
		params[index] = {
			"val" : param,	
			"type" : content["form"][index]["type"]
		}

	factory_tree.callFunc(content["name"], params)

func __setFuncParamPath(_content, item):
	var resource_dialog = get_node("ResourceDialog")

	resource_dialog.popup_centered(Vector2(960, 540))

	if not resource_dialog.is_connected("file_selected", self, "__setFuncParamPathHook"):
		resource_dialog.connect("file_selected", self, "__setFuncParamPathHook", [item])

func __setFuncParamPathHook(path, item):
	var resource_dialog = get_node("ResourceDialog")
	resource_dialog.hide()

	item.set_text(1, path)

func renderOverView():
	var overview_tree = __getOverviewTree()
	overview_tree.clear()
	var main_node = __renderOverviewMainNode(overview_tree)
	var attr_node = __renderOverviewAttrNode(main_node, overview_tree)

	var overview_list = factory_tree.getOverviewList()

	for overview in overview_list:
		match int(overview["type"]):
			Factory.ATTR_VIEW:
				var overview_name = overview["name"]
				var overview_node = overview_tree.create_item(attr_node)
				overview_node.set_text(0, overview_name)

				var val = factory_tree.getNode().getEntity().call(overview["func_name"])
				val = str(val)

				overview_node.set_text(1, val)

			Factory.ATTR_ARRAY_VIEW:
				var overview_name = overview["name"]
				var overview_node = overview_tree.create_item(attr_node)
				overview_node.set_text(0, overview_name)
				overview_node.set_expand_right(0, true)

				var arr = factory_tree.getNode().getEntity().call(overview["func_name"])

				for index in range(arr.size()):
					var val = arr[index]
					var inner_node = overview_tree.create_item(overview_node)
					inner_node.set_text(0, "[" + str(index) + "]")
					inner_node.set_text(1, str(val))

			Factory.ATTR_DICT_VIEW:
				var overview_name = overview["name"]
				var overview_node = overview_tree.create_item(attr_node)
				overview_node.set_text(0, overview_name)
				overview_node.set_expand_right(0, true)

				var dict = factory_tree.getNode().getEntity().call(overview["func_name"])

				for index in dict.keys():
					var val = dict[index]
					var inner_node = overview_tree.create_item(overview_node)
					inner_node.set_text(0, index)
					inner_node.set_text(1, str(val))


			Factory.ARRAY_VIEW:
				var overview_name = overview["name"]
				var overview_node = overview_tree.create_item(main_node)
				overview_node.set_text(0, overview_name)
				overview_node.set_expand_right(0, true)

				var form = overview["form"]
				var arr = factory_tree.getNode().getEntity().call(overview["func_name"])

				for index in range(arr.size()):
					var entity = arr[index]
					var index_node = overview_tree.create_item(overview_node)
					index_node.set_text(0, "[" + str(index) + "]")
					index_node.set_expand_right(0, true)

					for inner_form in form:
						var attr_name = inner_form["attr_name"]
						var func_name = inner_form["func_name"]
						
						var inner_node = overview_tree.create_item(index_node)
						var val = entity.call(func_name)

						inner_node.set_text(0, attr_name)
						inner_node.set_text(1, str(val))

			Factory.DICT_VIEW:
				var overview_name = overview["name"]
				var overview_node = overview_tree.create_item(main_node)
				overview_node.set_text(0, overview_name)
				overview_node.set_expand_right(0, true)

				var form = overview["form"]
				var dict = factory_tree.getNode().getEntity().call(overview["func_name"])
			
				for index in dict.keys():
					var entity = dict[index]
					var index_node = overview_tree.create_item(overview_node)

					index_node.set_text(0, str(index))
					index_node.set_expand_right(0, true)
				
					for inner_form in form:
						var attr_name = inner_form["attr_name"]
						var func_name = inner_form["func_name"]
					
						var inner_node = overview_tree.create_item(index_node)
						var val = entity.call(func_name)

						inner_node.set_text(0, attr_name)
						inner_node.set_text(1, str(val))

func __renderOverviewMainNode(overview_tree):
	var main_node = overview_tree.create_item(null)

	main_node.set_text(0, "Overview")
	
	return main_node

func __renderOverviewAttrNode(main_node, overview_tree):
	var attr_node = overview_tree.create_item(main_node)

	attr_node.set_text(0, "Attrs")
	attr_node.set_expand_right(0, true)
	
	return attr_node
