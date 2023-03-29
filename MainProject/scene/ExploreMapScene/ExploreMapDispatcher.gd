extends "res://scene/BaseDispatcher.gd"
class_name ExploreMapDispatcher

func launch():
	render().renderBackground()
	render().drawMapCanvas()
	render().renderMapNode()
	
	initSubMenuEntryButton()
	refreshExecEffectFuncSignal()

func initSubMenuEntryButton():
	render().renderSubMenuEntryButton()
	var component_pack = render().getSubMenuEntryButton()
	var sub_menu_entry_button = component_pack.getComponent()
	sub_menu_entry_button.connect("pressed", service(), "subMenu")

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
