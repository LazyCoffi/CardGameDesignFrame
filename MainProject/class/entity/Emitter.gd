extends Node
class_name Emitter

signal emitter
var param

func _init():
	param = null

func setParam(param_):
	param = param_

func emitFuncName():
	return "__emit"

func connectTo(entity, target_func):
	Logger.assert(connect("emitter", entity, target_func) == 0, "Connect fail!")

func disconnectFrom(entity, target_func):
	Logger.assert(is_connected("emitter", entity, target_func), "Disconnect fail!")
	disconnect("emitter", entity, target_func)

func __emit():
	emit_signal("emitter", param)
