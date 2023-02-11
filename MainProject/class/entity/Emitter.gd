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
	Exception.assert(connect("emitter", entity, target_func) == 0)

func disconnectFrom(entity, target_func):
	Exception.assert(is_connected("emitter", entity, target_func))
	disconnect("emitter", entity, target_func)

func __emit(default_param := null):
	if default_param == null:
		emit_signal("emitter", param)
	else:
		emit_signal("emitter", param, default_param)
