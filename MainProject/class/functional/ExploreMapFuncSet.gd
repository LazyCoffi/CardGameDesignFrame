extends "res://class/functional/FuncSet.gd"
class_name ExploreMapFuncSet

func _init():
	func_form = {}
	__initFuncForm()

func enableSelfMapNode(map_node, scene_ref):
	var map_node_list = scene_ref.model().getMapNodeList()

	var node_index = map_node_list.find(map_node)

	scene_ref.service().enableMapNode(node_index)
	scene_ref.render().enableMapNode(node_index)
	scene_ref.dispatcher().refreshExecEffectFuncSignal()

func disableSelfMapNode(map_node, scene_ref):
	var map_node_list = scene_ref.model().getMapNodeList()

	var node_index = map_node_list.find(map_node)

	scene_ref.service().disableMapNode(node_index)
	scene_ref.render().disableMapNode(node_index)
	scene_ref.dispatcher().refreshExecEffectFuncSignal()

func enableSelfMapNodeByIndex(node_index, scene_ref):
	scene_ref.service().enableMapNode(node_index)
	scene_ref.render().enableMapNode(node_index)
	scene_ref.dispatcher().refreshExecEffectFuncSignal()

func disableSelfMapNodeByIndex(node_index, scene_ref):
	scene_ref.service().disableMapNode(node_index)
	scene_ref.render().disableMapNode(node_index)
	scene_ref.dispatcher().refreshExecEffectFuncSignal()

func __initFuncForm():
	addFuncForm("enableSelfMapNode", "null", ["Object", "Object"])
	addFuncForm("disableSelfMapNode", "null", ["Object", "Object"])
	addFuncForm("enableSelfMapNodeByIndex", "null", ["int", "Object"])
	addFuncForm("disableSelfMapNodeByIndex", "null", ["int", "Object"])
