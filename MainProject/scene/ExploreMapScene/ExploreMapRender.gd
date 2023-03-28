extends Node
class_name ExploreMapRender

var Emitter = TypeUnit.type("Emitter")
var ComponentPack = TypeUnit.type("ComponentPack")
var MapCanvas = TypeUnit.type("MapCanvas")

var map_canvas				# MapCanvas
var map_node_rect_list		# ComponentPack_Array
var background_rect			# ComponentPack
var sub_menu_entry_button	# ComponentPack

var scene_ref

func _init():
	map_canvas = MapCanvas.new()
	map_node_rect_list = []

func setRef(scene):
	scene_ref = scene

func scene():
	return scene_ref

func sceneName():
	return scene().getSceneName()

func model():
	return scene_ref.model()

func service():
	return scene_ref.service()

func dispatcher():
	return scene_ref.dispatcher()

func renderBackground():
	var background = TextureRect.new()
	scene().add_child(background)

	var texture = ResourceUnit.loadRes(scene().getSceneName(), scene().getSceneName(), "background")

	background.texture = texture
	var screen_size = GlobalSetting.getScreenSize()
	background.rect_size = Vector2(screen_size[0], screen_size[1])
	background.rect_position = Vector2(0, 0)

func getMapNodeRectList():
	return map_node_rect_list

func getEnableMapNodeRectList():
	var map_node_list = model().getMapNodeList()
	var ret = []

	for index in range(map_node_list.size()):
		if map_node_list[index].isInteractive():
			ret.append(map_node_rect_list[index])

	return ret

func getDisableMapNodeRectList():
	var map_node_list = model().getMapNodeList()
	var ret = []

	for index in range(map_node_list.size()):
		if not map_node_list[index].isInteractive():
			ret.append(map_node_rect_list[index])

	return ret

func drawMapCanvas():
	var line_width = model().getMapLineWidth()
	var lines = service().getMapLines()

	map_canvas.setLineWidth(line_width)
	map_canvas.setLines(lines)

	scene().add_child(map_canvas)
	map_canvas.update()

	var map_position = model().getMapPosition()
	map_canvas.setPosition(Vector2(map_position[0], map_position[1]))

func renderMapNode():
	var map_node_list = model().getMapNodeList()
	for index in range(map_node_list.size()):
		var map_node = map_node_list[index]

		var x_ = map_node.getCoordinateX()
		var y_ = map_node.getCoordinateY()

		var x = service().coordinateRemap(x_, y_)[0]
		var y = service().coordinateRemap(x_, y_)[1]

		var map_node_rect_size = Vector2(model().getMapNodeSize()[0], model().getMapNodeSize()[1])
		var map_node_rect_postion = Vector2(x - map_node_rect_size[0] / 2, y - map_node_rect_size[1] / 2)

		var map_node_rect = TextureButton.new()
		map_canvas.add_child(map_node_rect)

		map_node_rect.rect_position = map_node_rect_postion
		map_node_rect.rect_size = map_node_rect_size

		var component_pack = ComponentPack.new(str(index), map_node_rect)

		map_node_rect_list.append(component_pack)

		if map_node.isInteractive():
			enableMapNode(index)
		else:
			disableMapNode(index)

func enableMapNode(node_index):
	var component_pack = map_node_rect_list[node_index]
	var map_node = component_pack.getComponent()

	var scene_name = scene().getSceneName()
	var texture = ResourceUnit.loadRes(scene_name, scene_name, "map_node")

	map_node.texture_normal = texture

func disableMapNode(node_index):
	var component_pack = map_node_rect_list[node_index]
	var map_node = component_pack.getComponent()

	var scene_name = scene().getSceneName()
	var texture = ResourceUnit.loadRes(scene_name, scene_name, "disable_map_node")

	map_node.texture_normal = texture

func renderSubMenuEntryButton():
	var sub_menu_button = TextureButton.new()
	var rect_size = model().getSubMenuRectSize()
	var rect_position = model().getSubMenuPosition()
	var texture = ResourceUnit.loadRes(sceneName(), sceneName(), "sub_menu_button")
	sub_menu_button.rect_size = rect_size
	sub_menu_button.rect_position = rect_position
	sub_menu_button.texture_normal = texture

	var component_pack = ComponentPack.new("__subMenuButton", sub_menu_button)
	scene().add_child(sub_menu_button)

	sub_menu_entry_button = component_pack

func getSubMenuEntryButton():
	return sub_menu_entry_button
