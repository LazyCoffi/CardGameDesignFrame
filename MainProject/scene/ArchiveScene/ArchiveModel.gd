extends Node
class_name ArchiveModel

var param_map

const MAX_ARCHIVE_NUM = 3

var selected_archive	# Archive
var head_pointer		# int

func _init():
	selected_archive = null
	head_pointer = 0

func getMaxArchiveNum():
	return MAX_ARCHIVE_NUM

func hasSelectedArchive():
	return not selected_archive == null

func getSelectedArchive():
	return selected_archive

func resetSelectedArchive():
	selected_archive = null

func selectArchive(archive):
	selected_archive = archive

func getHeadPointer():
	return head_pointer

func next():
	head_pointer += 1

func previous():
	head_pointer = max(0, head_pointer - 1)

func pack():
	var script_tree = ScriptTree.new()

	return script_tree

func loadScript(_script_tree):
	pass
