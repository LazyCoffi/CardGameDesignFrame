extends GutTest

var SubMenuScene = TypeUnit.type("SubMenuScene")
var SubMenuModel = TypeUnit.type("SubMenuModel")

func test_buildSubMenuScript():
	var sub_menu = SubMenuScene.instance()
	sub_menu.setSceneName("sub_menu")

	var switch_target_table = SwitchTargetTable.new()
	sub_menu.setSwitchTargetTable(switch_target_table)

	var sub_menu_model = SubMenuModel.new()
	sub_menu.setModel(sub_menu_model)

	var script_tree = sub_menu.pack()
	script_tree.exportAsJson("res://test/scripts/sub_menu.json")

	pass_test("SubMenu script generate success!")
 
 
