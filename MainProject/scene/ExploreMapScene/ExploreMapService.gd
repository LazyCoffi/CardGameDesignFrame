extends Node
class_name ExploreMapService

var scene_ref

func setRef(scene):
	scene_ref = scene

func scene():
	return scene_ref

func model():
	return scene_ref.model()

func subMenu():
	model().subMenuFunction(scene())

func getMapLines():
	var map_node_list = model().getMapNodeList()
	var ret = []

	for map_node in map_node_list:
		var x1 = map_node.getCoordinateX()
		var y1 = map_node.getCoordinateY()

		var ch_list = map_node.getChList()
		
		for ch_node_index in ch_list: 
			var ch_node = map_node_list[ch_node_index]
			var x2 = ch_node.getCoordinateX()
			var y2 = ch_node.getCoordinateY()

			ret.append([coordinateRemap(x1, y1), coordinateRemap(x2, y2)])
	
	return ret

func coordinateRemap(x, y):
	var map_node_size = model().getMapNodeSize()

	return [x * map_node_size[0], y * map_node_size[1]]

func enableMapNode(index):
	model().setNodeInteractive(index)
	
func disableMapNode(index):
	model().setNodeInteractive(index)

func execNodeEffectFunc(node_index):
	model().execNodeEffectFunc(node_index, scene())
