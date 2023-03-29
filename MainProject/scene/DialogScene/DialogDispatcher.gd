extends "res://scene/BaseDispatcher.gd"
class_name DialogDispatcher

func launch():
	render().renderDialogFrame()
	render().renderDialogTitle()
	render().renderDialogPic()
	render().renderDialogInfo()
	render().renderOptionFrame()
	render().renderOptionList()
	
	emitExecEffectFuncSignal()

func emitExecEffectFuncSignal():
	var option_list = render().getOptionList()
	for option in option_list:
		if not option.isConnected("pressed"):
			option.connectTo(self, "pressed", "receiveExecEffectFuncSignal")

func receiveExecEffectFuncSignal(component_key):
	service().execOptionEffectFunc(component_key)
