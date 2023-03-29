extends "res://scene/BaseModel.gd"
class_name ExploreMapModel

var HyperFunction = TypeUnit.type("HyperFunction")

class ExploreMapNode:
	var coordinate_x
	var coordinate_y
	var ch
	var is_interactive
	var effect_func
	
	func _init():
		coordinate_x = 0
		coordinate_y = 0
		ch = []
		is_interactive = false
		effect_func = null

	func getCoordinateX():
		return coordinate_x

	func setCoordinateX(coordinate_x_):
		coordinate_x = coordinate_x_
	
	func getCoordinateY():
		return coordinate_y
	
	func setCoordinateY(coordinate_y_):
		coordinate_y = coordinate_y_
	
	func addCh(ch_id):
		ch.append(ch_id)
	
	func delCh(ch_id):
		ch.erase(ch_id)
	
	func getChList():
		return ch	
	
	func isInteractive():
		return is_interactive
	
	func setInteractive():
		is_interactive = true
	
	func resetInteractive():
		is_interactive = false
	
	func execEffectFunc(scene_ref):
		effect_func.exec([self, scene_ref])
	
	func setEffectFunc(effect_func_):
		effect_func = effect_func_
	
	func pack():
		var script_tree = ScriptTree.new()

		script_tree.addAttr("coordinate_x", coordinate_x)
		script_tree.addAttr("coordinate_y", coordinate_y)
		script_tree.addAttr("ch", ch)
		script_tree.addAttr("is_interactive", is_interactive)
		script_tree.addObject("effect_func", effect_func)

		return script_tree
	
	func loadScript(script_tree):
		coordinate_x = script_tree.getInt("coordinate_x")
		coordinate_y = script_tree.getInt("coordinate_y")
		ch = script_tree.getIntArray("ch")
		is_interactive = script_tree.getBool("is_interactive")
		effect_func = script_tree.getObject("effect_func", HyperFunction)

var map_node_list		# Array
var sub_menu_function	# HyperFunction

func _init():
	map_node_list = []

# const
func getMapSize():
	return Vector2(1920, 1080)

func getMapNodeSize():
	return Vector2(60, 60)

func getMapPosition():
	return Vector2()

func getMapLineWidth():
	return 4

func getSubMenuRectSize():
	return Vector2(100, 100)

func getSubMenuPosition():
	return Vector2(1720, 41)

func addMapNode(coordinate_x, coordinate_y, effect_func, is_interactive):
	var map_node = ExploreMapNode.new()

	map_node.setCoordinateX(coordinate_x)
	map_node.setCoordinateY(coordinate_y)
	map_node.setEffectFunc(effect_func)
	if is_interactive:
		map_node.setInteractive()
	else:
		map_node.resetInteractive()

	map_node_list.append(map_node)

func delMapNode(node_index):
	map_node_list.remove(node_index)

func addMapNodeCh(node_index, ch_node_index):
	map_node_list[node_index].addCh(ch_node_index)

func delMapNodeCh(node_index, ch_node_index):
	map_node_list[node_index].delCh(ch_node_index)

func isNodeInteractive(node_index):
	return map_node_list[node_index].isInteractive()

func setNodeInteractive(node_index):
	map_node_list[node_index].setInteractive()

func resetNodeInteractive(node_index):
	map_node_list[node_index].resetInteractive()

func execNodeEffectFunc(node_index, scene_ref):
	map_node_list[node_index].execEffectFunc(scene_ref)

func getMapNodeList():
	return map_node_list

func subMenuFunction(scene_ref):
	sub_menu_function.exec([scene_ref])

func setSubMenuFunction(sub_menu_function_):
	sub_menu_function = sub_menu_function_
	
func pack():
	var script_tree = ScriptTree.new()

	script_tree.addObjectArray("map_node_list", map_node_list)
	script_tree.addObject("sub_menu_function", sub_menu_function)

	return script_tree

func loadScript(script_tree):
	map_node_list = script_tree.getObjectArray("map_node_list", ExploreMapNode)
	sub_menu_function = script_tree.getObject("sub_menu_function", HyperFunction)
