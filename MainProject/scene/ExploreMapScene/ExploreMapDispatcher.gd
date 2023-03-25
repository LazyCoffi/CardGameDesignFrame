extends Node
class_name ExploreMapDispatcher

var scene_ref

func setRef(scene):
	scene_ref = scene

func scene():
	return scene_ref

func render():
	return scene().render()

func tween():
	return scene().get_node("Tween")

func service():
	return scene().service()

func launch():
	render().renderBackground()
	render().drawMapCanvas()
	render().renderMapNode()

	refreshExecEffectFuncSignal()

func refreshExecEffectFuncSignal():
	emitExecEffectFuncSignal()
	recycleExecEffectFuncSignal()

func emitExecEffectFuncSignal():
	var map_node_rect_list = render().getEnableMapNodeRectList()

	for component_pack in map_node_rect_list:
		if not component_pack.isConnected("pressed"):
			component_pack.connectTo(self, "pressed", "execNodeEffectFunc")

func recycleExecEffectFuncSignal():
	var map_node_rect_list = render().getDisableMapNodeRectList()

	for component_pack in map_node_rect_list:
		if component_pack.isConnected("pressed"):
			component_pack.disconnectFrom(self, "pressed", "execNodeEffectFunc")

func execNodeEffectFunc(component_key):
	service().execNodeEffectFunc(int(component_key))
