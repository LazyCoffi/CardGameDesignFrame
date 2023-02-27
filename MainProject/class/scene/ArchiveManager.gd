extends Node
class_name ArchiveManager

var Archive = TypeUnit.type("Archive")
var SceneCache = TypeUnit.type("SceneCache")

var active_archive		# Archive
var total_archive_num	# int
var archive_list		# Array

func _init():
	initArchiveManager()

func initArchiveManager():
	active_archive = null

	var file = File.new()
	var path = "usr://archive_list.json"

	if file.file_exists(path):
		var script_tree = ScriptTree.new()
		script_tree.loadFromJson(path)

		total_archive_num = script_tree.getInt("total_archive_num")
		archive_list = script_tree.getObjectArray("archive_list", Archive)
	else:
		total_archive_num = 0
		archive_list = []

func peekArchiveList():
	return archive_list

func getArchiveByIndex(index):
	return archive_list[index]

func getArchiveNum():
	return archive_list.size()

func newArchive():
	var archive_name = "Archive" + str(total_archive_num)
	var archive = Archive.new()
	archive.setArchiveName(archive_name)
	active_archive = archive

func setArchive(archive_name):
	var archive = getArchive(archive_name)
	active_archive = archive

func delArchive(archive_name):
	for index in range(archive_list.size()):
		if archive_list[index].getArchiveName() == archive_name:
			archive_list.remove(index)
			return

func delArchiveByIndex(index):
	Logger.assert(index >= 0 and index < archive_list.size(), "Index out of range!")
		
	archive_list.remove(index)

func hasArchive(archive_name):
	for archive in archive_list:
		if archive.getArchiveName() == archive_name:
			return true
	
	return false

func getArchive(archive_name):
	for archive in archive_list:
		if archive.getArchiveName() == archive_name:
			return archive
	
	return null

func isActiveArchiveSelected():
	return active_archive != null

func saveArchive(scene_cache):
	Logger.assert(isActiveArchiveSelected(), "No archive is selected!")
		
	var archive_name = active_archive.getArchiveName()
	var path = "usr://"
	var save_path = path + archive_name + ".json"
	var script_tree = scene_cache.pack()
	script_tree.exportAsJson(save_path)

	active_archive.update()

	if not hasArchive(archive_name):
		archive_list.append(active_archive)
		total_archive_num += 1

	var list_path = path + "archive_list.json"

	var list_script_tree = ScriptTree.new()
	list_script_tree.addAttr("total_archive_num", total_archive_num)
	list_script_tree.addObjectArray("archive_list", archive_list)
	list_script_tree.exportAsJson(list_path)
	
func loadArchive(archive_name):
	Logger.assert(isActiveArchiveSelected(), "No archive is selected!")

	var archive = getArchive(archive_name)

	var script_tree = archive.pack()
	var path = "usr://" + archive_name + ".json"
	script_tree.loadFromJson(path)

	var scene_cache = SceneCache.new()
	scene_cache.loadScript(script_tree)

	return scene_cache
