extends Node
class_name FactoryTree

var RootFactory = TypeUnit.type("RootFactory")

enum {
	BASE_MEM,
	OBJ_MEM,
	COM_OBJ_MEM,
	CONT_MEM,
	OBJ_CONT_MEM
	RES_MEM,
}

class FactoryTreeNode:
	var factory
	var father
	var ch

	func _init(factory_, father_):
		factory = factory_
		father = father_
		ch = {}

		__construct()
	
	func getMemberView():
		return factory.getMemberView()
	
	func getConfigView():
		return factory.getConfigView()
	
	func addObjectIntoContainer(container_name):
		factory.addMemberViewContainer(container_name)
		var member_list = factory.getMemberList()
		for member in member_list:		
			if member[0] == container_name:
				var tree_factory = __getFactory(member[1])
				var tree_node = FactoryTreeNode.new(tree_factory, self)
				ch[member[0]].append(tree_node)
	
	func delObjectFromContainer(container_name, index):
		factory.delMemberViewContainer(container_name, index)
		var member_list = factory.getMemberList()

		for member in member_list:		
			if member[0] == container_name:
				ch[member[0]].remove(index)
	
	func setCommonObject(obj_name, obj_type):
		factory.setMemberViewCommonObject(obj_name, obj_type)
		factory.setConfigCommonObject(obj_name, obj_type)
		var member_list = factory.getMemberList()

		for member in member_list:
			if member[0] == obj_name:
				if ch[member[0]] == null:
					var tree_factory = __getFactory(obj_type)
					var tree_node = FactoryTreeNode.new(tree_factory, self)
					ch[member[0]] = tree_node

	func resetCommonObject(obj_name):
		factory.setMemberViewCommonObject(obj_name)
		factory.resetConfigCommonObject(obj_name)
		var member_list = factory.getMemberList()

		for member in member_list:
			if member[0] == obj_name:
				ch[member[0]] = null

	func setBaseVal(base_name, val):
		factory.setConfigViewBaseVal(base_name, val)
	
	func addConfigViewContainer(container_name):
		factory.addConfigViewContainer(container_name)
	
	func delConfigViewContainer(container_name, index):
		factory.delConfigViewContainer(container_name, index)
	
	func getEntity():
		factory.getEntity()

	func buildEntity():
		var blueprint = __buildBlueprint()

		for key in ch.keys():
			var tree_node = ch[key]
			var entity = tree_node.getEntity()
			blueprint[key] = entity

		factory.buildRef(blueprint)
		factory.build(blueprint)
	
	func recursionBuild():
		buildEntity()
		for key in ch.keys():
			var ch_node = ch[key]
			if ch_node != null:
				if ch_node is FactoryTreeNode:
					ch_node.recursionBuild()
				else:
					for inner_node in ch_node:
						inner_node.recursionBuild()
	
	func getCh(index):
		return ch[index]
	
	func getFather():
		return father
	
	func __buildBlueprint():
		var config_view = factory.getConfigView()
		var blueprint = {}
		
		for config in config_view:
			match config[1]:
				BASE_MEM:
					blueprint[config[0]] = config[2]
				CONT_MEM:
					blueprint[config[0]] = config[2]

		return blueprint	

	func __construct():
		var member_list = factory.getMemberList()
		for member in member_list:
			match member[1]:
				OBJ_MEM:
					var tree_factory = __getFactory(member[2])
					var tree_node = FactoryTreeNode.new(tree_factory, self)
					ch[member[0]] = tree_node
				OBJ_CONT_MEM:
					ch[member[0]] = []
				COM_OBJ_MEM:
					ch[member[0]] = null
					
	func __getFactory(type_name):
		return TypeUnit.type(type_name + "Factory").new()

var root
var node

func _init():
	var root_factory = RootFactory.new()
	root = FactoryTreeNode.new(root_factory, null)
	node = root

func getRoot():
	return root

func getNode():
	return node

func walkDown(ch_name):
	var ch_node = node.getCh(ch_name)
	if ch_node == null or ch_node is FactoryTreeNode:
		return

	node = ch_node

func walkDownInto(ch_name, index):
	var ch_node = node.getCh(ch_name)
	if ch_node == null or ch_node is FactoryTreeNode:
		return
	
	node = ch_node[index]

func walkUp():
	var father_node = node.getFather()
	if father_node == null:
		return
	
	node = father_node

func recursionBuild():
	root.recursionBuild()

func singleBuild():
	node.buildEntity()

func connectNode(entity):
	pass

func disconnectNode(entity):
	pass
