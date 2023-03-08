extends Node
class_name FactoryTree

var RootFactory = TypeUnit.type("RootFactory")
var Factory = TypeUnit.type("Factory")

class FactoryTreeNode:
	var factory
	var father
	var ch

	func _init(factory_, father_):
		factory = factory_
		father = father_
		ch = {}
	
	func addObjectIntoArray(arr_name):
		var member = factory.addObjectIntoArray(arr_name)
		var tree_factory = __getFactory(member["class_type"])
		var tree_node = FactoryTreeNode.new(tree_factory, self)
		ch[member["name"]].append(tree_node)
		factory.getEntity().call(member["add_func"], tree_node.getEntity())

		return member
	
	func delObjectFromArray(arr_name, index):
		var member = factory.delObjectFromArray(arr_name, index)
		var tree_node = ch[member["name"]][index]
		factory.getEntity().call(member["del_func"], tree_node.getEntity())
		ch[member["name"]].remove(index)

		return member
					
	func addObjectIntoDict(dict_name, index):
		var member = factory.addObjectIntoDict(dict_name, index)
		var tree_factory = __getFactory(member["class_type"])
		var tree_node = FactoryTreeNode.new(tree_factory, self)
		ch[member["name"]][index] = tree_node
		factory.getEntity().call(member["add_func"], tree_node.getEntity())

		return member

	func delObjectFromDict(dict_name, index):
		var member = factory.delObjectFromDict(dict_name, index)
		var tree_node = ch[member["name"]][index]
		factory.getEntity().call(member["del_func"], tree_node.getEntity())
		ch[member["name"]].erase(index)

		return member

	func setCommonObjectType(obj_name, obj_type):
		var member = factory.setCommonObjectType(obj_name)

		var tree_factory = __getFactory(obj_type)
		var tree_node = FactoryTreeNode.new(tree_factory, self)
		factory.getEntity().call(member["set_func"], tree_node.getEntity())
		ch[member["name"]] = tree_node

		return member

	func resetCommonObjectType(obj_name):
		var member = factory.resetCommonObjectType(obj_name)

		factory.getEntity().call(member["set_func"], null)

		ch[member["name"]] = null

		return member

	func setLocalCommonObjectType(func_name, index, class_type):
		var member = factory.setLocalCommonObjectType(func_name, index, class_type)

		var tree_factory = __getFactory(class_type)
		var tree_node = FactoryTreeNode.new(tree_factory, self)
		factory.getEntity().call(member["set_func"], tree_node.getEntity())
		ch[member["func_name"] + "_" + member["index"]] = tree_node

		return member

	func resetLocalCommonObjectType(func_name, index):
		var member = factory.resetLocalCommonObjectType(func_name, index)

		factory.getEntity().call(member["set_func"], null)

		ch[member["func_name"] + "_" + member["index"]] = null

		return member
	
	func callFunc(func_name, params):
		factory.getEntity().callv(func_name, params)
		
	func getEntity():
		return factory.getEntity()

	func getEntityType():
		return factory.getEntityType()

	func getCh(index):
		return ch[index]
	
	func getChTable():
		return ch
	
	func getFather():
		return father
	
	func construct(proj):
		factory.construct(proj["member_list"], proj["func_ops"])

		var member_list = factory.getMemberList()
		for member in member_list:
			match member["type"]:
				Factory.OBJ_MEM:
					var tree_factory = __getFactory(member["class_type"])
					var tree_node = FactoryTreeNode.new(tree_factory, self)
					ch[member["name"]] = tree_node
					getEntity().call(member["set_func"], tree_node.getEntity())

					tree_node.construct(proj[member["name"]])

				Factory.OBJ_ARR_MEM:
					ch[member["name"]] = []

					for index in range(member["container"].size()):
						var inner_member = member["container"][index]
						var tree_factory = __getFactory(inner_member["class_type"])
						var tree_node = FactoryTreeNode.new(tree_factory, self)
						getEntity().call(member["add_func"], tree_factory)
						ch[member["name"]].append(tree_node)

						tree_node.construct(proj[member["name"][index]])

				Factory.OBJ_DICT_MEM:
					ch[member["name"]] = {}
					for key in member["container"].keys():
						var inner_member = member["container"][key]
						var tree_factory = __getFactory(inner_member["class_type"])
						var tree_node = FactoryTreeNode.new(tree_factory, self)
						getEntity().call(member["add_func"], tree_node.getEntity())
						ch[member["name"]] = tree_node

						tree_node.construct(proj[member["name"]][key])

				Factory.COM_OBJ_MEM:
					if member["class_type"] == null:
						ch[member["name"]] = null
					else:
						var tree_factory = __getFactory(member["class_type"])
						var tree_node = FactoryTreeNode.new(tree_factory, self)
						getEntity().call(member["set_func"], tree_node.getEntity())
						ch[member["name"]] = tree_node

						tree_node.construct(proj[member["name"]])

				Factory.LOCAL_OBJ_MEM:
					var tree_factory = __getFactory(member["class_type"])
					var tree_node = FactoryTreeNode.new(tree_factory, self)
					ch[member["func_name"] + "_" + member["index"]] = tree_node

					tree_node.construct(proj[member["func_name"] + "_" + member["index"]])

				Factory.LOCAL_COM_MEM:
					if member["class_type"] == null:
						ch[member["name"]] = null
					else:
						var tree_factory = __getFactory(member["class_type"])
						var tree_node = FactoryTreeNode.new(tree_factory, self)
						ch[member["func_name"] + "_" + member["index"]] = tree_node

						tree_node.construct(proj[member["func_name"] + "_" + member["index"]])

	func create():
		factory.create()

		var member_list = factory.getMemberList()
		for member in member_list:
			match member["type"]:
				Factory.OBJ_MEM:
					var tree_factory = __getFactory(member["class_type"])
					var tree_node = FactoryTreeNode.new(tree_factory, self)
					ch[member["name"]] = tree_node
					getEntity().call(member["set_func"], tree_node.getEntity())

					tree_node.create()

				Factory.OBJ_ARR_MEM:
					ch[member["name"]] = []

					for index in range(member["container"].size()):
						var inner_member = member["container"][index]
						var tree_factory = __getFactory(inner_member["class_type"])
						var tree_node = FactoryTreeNode.new(tree_factory, self)
						getEntity().call(member["add_func"], tree_factory)
						ch[member["name"]].append(tree_node)

						tree_node.create()

				Factory.OBJ_DICT_MEM:
					ch[member["name"]] = {}
					for key in member["container"].keys():
						var inner_member = member["container"][key]
						var tree_factory = __getFactory(inner_member["class_type"])
						var tree_node = FactoryTreeNode.new(tree_factory, self)
						getEntity().call(member["add_func"], tree_node.getEntity())
						ch[member["name"]] = tree_node

						tree_node.create()

				Factory.COM_OBJ_MEM:
					if member["class_type"] == null:
						ch[member["name"]] = null
					else:
						var tree_factory = __getFactory(member["class_type"])
						var tree_node = FactoryTreeNode.new(tree_factory, self)
						getEntity().call(member["set_func"], tree_node.getEntity())
						ch[member["name"]] = tree_node

						tree_node.create()

				Factory.LOCAL_OBJ_MEM:
					var tree_factory = __getFactory(member["class_type"])
					var tree_node = FactoryTreeNode.new(tree_factory, self)
					ch[member["func_name"] + "_" + member["index"]] = tree_node

					tree_node.create()

				Factory.LOCAL_COM_MEM:
					if member["class_type"] == null:
						ch[member["name"]] = null
					else:
						var tree_factory = __getFactory(member["class_type"])
						var tree_node = FactoryTreeNode.new(tree_factory, self)
						ch[member["func_name"] + "_" + member["index"]] = tree_node

						tree_node.create()

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

func callFunc(func_name, params):
	node.callFunc(func_name, params)

func addObjectIntoArray(arr_name):
	return node.addObjectIntoArray(arr_name)

func delObjectFromArray(arr_name, index):
	return node.delObjectFromArray(arr_name, index)

func addObjectIntoDict(dict_name, index):
	return node.addObjectIntoDict(dict_name, index)

func delObjectFromDict(dict_name, index):
	return node.delObjectFromDict(dict_name, index)

func setCommonObjectType(obj_name, obj_type):
	return node.setCommonObjectType(obj_name, obj_type)

func resetCommonObjectType(obj_name):
	return node.resetCommonObjectType(obj_name)

func setLocalCommonObjectType(func_name, index, obj_type):
	return node.setLocalCommonObjectType(func_name, index, obj_type)

func resetLocalCommonObjectType(func_name, index):
	return node.resetLocalCommonObjectType(func_name, index)

func walkDown(ch_name):
	var ch_node = node.getCh(ch_name)
	if ch_node == null or (not ch_node is FactoryTreeNode):
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

func create():
	root.create()

func construct(proj):
	root.construct(proj)

func getMemberList():
	return node.getMemberList()
