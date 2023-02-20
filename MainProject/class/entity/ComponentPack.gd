extends Node
class_name ComponentPack

var key
var component
var connection_table

func _init(key_, component_):
	key = key_
	component = component_
	connection_table = {}
	
func getKey():
	return key
	
func getComponent():
	return component

func setKey(key_):
	key = key_
	
func setComponent(component_):
	component = component_
	
func connectTo(entity, component_signal, target_func):
	Logger.assert(not connection_table.has(component_signal), "Component has connected!")
	var emitter = Emitter.new()
	emitter.setParam(key)
	emitter.connectTo(entity, target_func)
	component.connect(component_signal, emitter, emitter.emitFuncName())
	connection_table[component_signal] = emitter
	
func disconnectFrom(entity, component_signal, target_func):
	Logger.assert(connection_table.has(component_signal), "Component hasn't connected yet!")
	var emitter = connection_table[component_signal]
	component.disconnect(component_signal, emitter, emitter.emitFuncName())
	emitter.disconnectFrom(entity, target_func)
	connection_table.erase(component_signal)
	
func isConnected(component_signal):
	return connection_table.has(component_signal)
