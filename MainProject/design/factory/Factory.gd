extends Node 
class_name Factory

enum {
	BASE_MEM,
	OBJ_MEM,
	COM_OBJ_MEM,
	CONT_MEM,
	OBJ_CONT_MEM
	RES_MEM,
}
var entity
var entity_type

var member_list
var member_view
var config_view

func _init():
	member_list = []
	member_view = []
	config_view = []

func getEntity():
	return entity

func getEntityType():
	return entity_type

func getMemberList():
	return member_list

func addBaseMember(mem_name, class_type):
	member_list.append([mem_name, BASE_MEM, class_type])

func addObjectMember(mem_name, class_type):
	member_list.append([mem_name, OBJ_MEM, class_type])

func addCommonObjectMember(mem_name):
	member_list.append([mem_name, COM_OBJ_MEM])

func addContainerMember(mem_name, class_type):
	member_list.append([mem_name, CONT_MEM, class_type])

func addObjectContainerMember(mem_name, class_type):
	member_list.append([mem_name, OBJ_CONT_MEM, class_type])

func addResourceMember(category_list, class_type):
	member_list.append([category_list, RES_MEM, class_type])

func initMemberView():
	for member in member_list:
		match member[1]:
			OBJ_MEM:
				member_view.append([member[0], member[1], member[2]])
			COM_OBJ_MEM:
				member_view.append([member[0], member[1], null])
			OBJ_CONT_MEM:
				member_view.append([member[0], member[1], member[2], []])
			RES_MEM:
				member_view.append([member[0], member[1], member[2]])

func getMemberView():
	return member_view

func setMemberViewCommonObject(obj_name, obj_type):
	for member in member_view:
		if member[0] == obj_name:
			member[2] = obj_type

func resetMemberViewCommonObject(obj_name):
	for member in member_view:
		if member[0] == obj_name:
			member[2] = null

func addMemberViewContainer(container_name):
	for member in member_view:
		if member[0] == container_name:
			var index = member[3].size()
			member[3].append([container_name + "[" + str(index) + "]", member[2]])

		return

func delMemberViewObject(container_name, index):
	for member in member_view:
		if member[0] == container_name:
			member[3].remove(index)

			for inner_index in range(member[3].size()):
				var inner_member = member[3][inner_index]
				inner_member[0] = container_name + "[" + str(inner_index) + "]"	

			return

func initConfigView():
	for member in member_list:
		match member[1]:
			BASE_MEM:
				config_view.append([member[0], member[1], member[2], null])
			COM_OBJ_MEM:
				config_view.append([member[0], member[1], null])
			OBJ_MEM:
				config_view.append([member[0], member[1], member[2]])
			CONT_MEM:
				config_view.append([member[0], member[1], member[2], []])
			OBJ_CONT_MEM:
				config_view.append([member[0], member[1], member[2]])

func getConfigView():
	return config_view

func setConfigCommonObject(obj_name, obj_type):
	for config in config_view:
		if config[0] == obj_name:
			config[2] = obj_type
		
		return

func resetConfigCommonObject(obj_name):
	for config in config_view:
		if config[0] == obj_name:
			config[2] = null 
		
		return

func setConfigViewBaseVal(base_name, val):
	for config in config_view:
		if config[0] == base_name:
			config[3] = val

			return

func addConfigViewContainer(container_name):
	for config in config_view:
		if config[0] == container_name:
			var index = config[3].size()
			config[3].append([container_name + "[" + str(index) + "]", config[2]])

			return

func delConfigViewContainer(container_name, index):
	for config in config_view:
		if config[0] == container_name:
			config[3].remove(index)

			for inner_index in range(config[3].size()):
				var inner_config = config[3][inner_index]
				inner_config[0] = container_name + "[" + str(inner_index) + "]"	

			return

