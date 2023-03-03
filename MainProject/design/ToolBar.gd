extends HFlowContainer

func _ready():
	var file_button = get_node("FileMenu")
	var pop_menu = get_node("FilePopMenu")
	pop_menu.add_item("Load", 0)
	pop_menu.add_item("Save", 1)

	file_button.connect("pressed", self, "menu_popup")

func menu_popup():
	var pop_menu = get_node("FilePopMenu")
	pop_menu.popup(Rect2(0, 32, 128, 64))
