extends GutTest

var ArchiveScene = TypeUnit.type("ArchiveScene")
var ArchiveModel = TypeUnit.type("ArchiveModel")

func test_buildArchiveScript():
	var archive = ArchiveScene.instance()
	archive.setSceneName("archive")

	var switch_target_table = SwitchTargetTable.new()
	archive.setSwitchTargetTable(switch_target_table)

	var archive_model = ArchiveModel.new()
	archive.setModel(archive_model)

	var script_tree = archive.pack()
	script_tree.exportAsJson("res://test/scripts/archive.json")

	pass_test("Archive script generate success!")

