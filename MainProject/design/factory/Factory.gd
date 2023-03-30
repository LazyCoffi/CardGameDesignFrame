extends Node 
class_name Factory

enum {
	OBJ_MEM,
	COM_OBJ_MEM,
	OBJ_ARR_MEM,
	OBJ_DICT_MEM,
	FUNC_MEM,
	LOCAL_OBJ_MEM,
	LOCAL_COM_MEM,
	ATTR_VIEW,
	ATTR_ARRAY_VIEW,
	ATTR_DICT_VIEW,
	ARRAY_VIEW,
	DICT_VIEW
}
var entity
var entity_type

var member_list
var overview_list
var func_ops

func _init():
	member_list = []
	overview_list = []
	func_ops = []

	initOverviewList()

func getEntity():
	return entity

func getEntityType():
	return entity_type

func setMemberList(member_list_):
	member_list = member_list_

func getMemberList():
	return member_list

func getFuncOps():
	return func_ops

func setFuncOps(func_ops_):
	func_ops = func_ops_

func create():
	initMemberList()
	initLocalMember()

func initMemberList():
	## 子类实现
	return

func initOverviewList():
	## 子类实现
	return

func initLocalMember():
	for member in member_list:
		if member["type"] == FUNC_MEM:
			for index in range(member["form"].size()):
				var param = member["form"][index]
				match param["param_type"]:
					"obj":
						addLocalObjectMember(param["type"], param["name"], index)
					"common_obj":
						addLocalCommonMember(param["name"], index)

func construct(member_list_, func_ops_):
	setMemberList(member_list_)
	setFuncOps(func_ops_)
	execFuncOps()

func execFuncOps():
	for func_op in func_ops:
		__callFunc(func_op["func_name"], func_op["params"])

func callFunc(func_name, params):
	var func_op = {
		"func_name" : func_name,
		"params" : params
	}
	func_ops.append(func_op)

	__callFunc(func_name, params)
	
func __callFunc(func_name, params):
	var fparams = []

	for param in params:
		match param["type"]:
			"int":
				fparams.append(int(param["val"]))
			"float":
				fparams.append(float(param["val"]))
			"String":
				fparams.append(str(param["val"]))
			_:
				fparams.append(param["val"])

	entity.callv(func_name, fparams)

func addObjectMember(mem_name, class_type, set_func):
	var ret = {
		"name" : mem_name,
		"type" : OBJ_MEM,
		"class_type" : class_type,
		"set_func" : set_func
	}

	member_list.append(ret)

	return ret

func addCommonObjectMember(mem_name, set_func):
	var ret = {
		"name" : mem_name,
		"type" : COM_OBJ_MEM,
		"class_type" : null,
		"set_func" : set_func
	}
	member_list.append(ret)

	return ret

func addObjectArrayMember(mem_name, class_type, add_func, del_func):
	member_list.append({
		"name" : mem_name,
		"type" : OBJ_ARR_MEM,
		"class_type" : class_type,
		"container" : [],
		"add_func" : add_func,
		"del_func" : del_func
	})

func addObjectDictMember(mem_name, class_type, add_func, del_func, set_index_func, get_index_func):
	member_list.append({
		"name" : mem_name,
		"type" : OBJ_DICT_MEM,
		"class_type" : class_type,
		"container" : {},
		"add_func" : add_func,
		"del_func" : del_func,
		"set_index_func" : set_index_func,
		"get_index_func" : get_index_func
	})

func addFuncMember(func_name, form):
	for inner_form in form:
		inner_form["func_name"] = func_name

	member_list.append({
		"name" : func_name,
		"type" : FUNC_MEM,
		"form" : form
	})

func addObjectIntoArray(arr_name):
	for member in member_list:
		if member["type"] == OBJ_ARR_MEM:
			if member["name"] == arr_name:
				var index = member["container"].size()
				var ret = {
					"container_name" : member["name"],
					"class_type" : member["class_type"],
					"index" : index,
					"add_func" : member["add_func"],
					"del_func" : member["del_func"]
				}

				member["container"].append(ret)

				return ret

func delObjectFromArray(arr_name, index):
	for member in member_list:
		if member["type"] == OBJ_ARR_MEM:
			if member["name"] == arr_name:
				var ret = member["container"][index]

				member["container"].remove(index)
				for inner_index in range(member["container"].size()):
					member["container"][inner_index]["index"] = inner_index

				return ret

func addObjectIntoDict(dict_name, index):
	for member in member_list:
		if member["type"] == OBJ_DICT_MEM:
			if member["name"] == dict_name:
				var ret = {
					"container_name" : member["name"],
					"class_type" : member["class_type"],
					"index" : index,
					"add_func" : member["add_func"],
					"del_func" : member["del_func"]
				}

				member["container"][index] = ret

				return ret

func delObjectFromDict(dict_name, index):
	for member in member_list:
		if member["type"] == OBJ_DICT_MEM:
			if member["name"] == dict_name:
				var ret = member["container"][index]

				member["container"].erase(index)
	
				return ret

func setCommonObjectType(obj_name, class_type):
	for member in member_list:
		if member["type"] == COM_OBJ_MEM:
			if member["name"] == obj_name:
				var ret = member

				member["class_type"] = class_type
	
				return ret

func resetCommonObjectType(obj_name):
	for member in member_list:
		if member["type"] == COM_OBJ_MEM:
			if member["name"] == obj_name:
				var ret = member

				member["class_type"] = null

				return ret

func setLocalCommonObjectType(func_name, index, class_type):
	for member in member_list:
		if member["type"] == LOCAL_COM_MEM:
			if member["func_name"] == func_name and member["index"] == index:
				var ret = member

				member["class_type"] = class_type

				return ret

func resetLocalCommonObjectType(func_name, index):
	for member in member_list:
		if member["type"] == LOCAL_COM_MEM:
			if member["func_name"] == func_name and member["index"] == index:
				var ret = member

				member["class_type"] = null

				return ret

func addLocalObjectMember(class_type, func_name, index):
	var ret = {
		"type" : LOCAL_OBJ_MEM,
		"class_type" : class_type,
		"func_name" : func_name,
		"index" : index
	}

	member_list.append(ret)

	return ret

func addLocalCommonMember(func_name, index):
	var ret = {
		"type" : LOCAL_COM_MEM,
		"class_type" : null,
		"func_name" : func_name,
		"index" : index
	}

	member_list.append(ret)

	return ret

func addAttrOverview(view_name, func_name):
	overview_list.append({
		"name" : view_name,
		"func_name" : func_name,
		"type" : ATTR_VIEW
	})

func addAttrArrayOverview(view_name, func_name):
	overview_list.append({
		"name" : view_name,
		"func_name" : func_name,
		"type" : ATTR_ARRAY_VIEW
	})

func addAttrDictOverview(view_name, func_name):
	overview_list.append({
		"name" : view_name,
		"func_name" : func_name,
		"type" : ATTR_DICT_VIEW
	})

func addArrayOverview(view_name, func_name, form):
	overview_list.append({
		"name" : view_name,
		"func_name" : func_name,
		"type" : ARRAY_VIEW,
		"form" : form
	})

func addDictOverview(view_name, func_name, form):
	overview_list.append({
		"name" : view_name,
		"func_name" : func_name,
		"type" : DICT_VIEW,
		"form" : form
	})

func getOverviewList():
	return overview_list
