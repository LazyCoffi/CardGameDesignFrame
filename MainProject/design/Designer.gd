extends Control

var FactoryTree = TypeUnit.type("FactoryTree")

var factory_tree

func _ready():
	init()
	renderMemberView()

func init():
	factory_tree = FactoryTree.new()
	
func renderMemberView():
	var member_view = __getMemberView()
	var member_tree = __getMemberTree() 	

	__renderMemberParent(member_tree)	

	var main_node = __renderMemberMainNode(member_tree)

	for member in member_view:
		match member[1]:
			Factory.OBJ_MEM:
				__renderObjectMember(member, main_node, member_tree)
			Factory.COM_OBJ_MEM:
				__renderCommonObjectMember(member, main_node, member_tree)
			Factory.OBJ_CONT_MEM:
				__renderObjectContainerMember(member, main_node, member_tree)

func __getMemberView():
	return factory_tree.getNode().getMemberView()

func __getMemberTree():
	return get_node("ToolBarSpliter").get_node("WorkspaceSpliter").get_node("ViewSpliter").get_node("MemberScrollContainer").get_node("MemberTree")

func __renderMemberParent(member_tree):
	var parent_node = member_tree.create_item()
	var parent_button_texture = load("res://design/asserts/rollback_16x16.png")
	parent_node.set_text(0, "...")
	parent_node.add_button(0, parent_button_texture)

func __renderMemberMainNode(member_tree):
	var main_node = member_tree.create_item()
	main_node.set_text(0, "RootFactory")

	return main_node

func __renderObjectMember(member, main_node, member_tree):
	var edit_node = member_tree.create_item(main_node)
	var edit_button_texture = load("res://design/asserts/edit_16x16.png")
	edit_node.set_text(0, member[0])
	edit_node.add_button(0, edit_button_texture)

func __renderCommonObjectMember(member, main_node, member_tree):
	var edit_node = member_tree.create_item(main_node)
	if member[2] == null:
		edit_node.set_text(0, "[Common Object]")
	else:
		edit_node.set_text(0, member[0])
		var edit_button_texture = load("res://design/asserts/edit_16x16.png")
		edit_node.add_button(0, edit_button_texture)

		var clear_button_texure = load("res://design/asserts/clear_16x16.png")
		edit_node.add_button(0, clear_button_texure)

func __renderObjectContainerMember(member, main_node, member_tree):
	var container_node = member_tree.create_item(main_node)
	container_node.set_text(0, member[0])

	for index in range(member[3].size()):
		var inner_member = member[3][index]
		var inner_node = member_tree.create_item(container_node)
		inner_node.set_text(0, inner_member[0])

		var edit_button_texture = load("res://design/asserts/edit_16x16.png")
		inner_node.add_button(0, edit_button_texture)

		var remove_button_texture = load("res://design/asserts/close_16x16.png")
		inner_node.add_button(0, remove_button_texture)

func renderConfigView():
	var config_view = __getConfigView()
	var config_tree = __getConfigTree()

	__renderConfigMainNode():

func __getConfigView():
	return factory_tree.getNode().getConfigView()

func __getConfigTree():
	return get_node("ToolBarSpliter").get_node("WorkspaceSpliter").get_node("ViewSpliter").get_node("ConfigScrollContainer").get_node("ConfigTree")
