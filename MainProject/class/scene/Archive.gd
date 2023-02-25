extends Node
class_name Archive

var ScriptTree = TypeUnit.type("ScriptTree")

var archive_name
var create_time
var last_save_time

func _init():
	var time_stamp = TimeUnit.getTimeStamp()
	create_time = time_stamp
	last_save_time = time_stamp

func update():
	var time_stamp = TimeUnit.getTimeStamp()
	last_save_time = time_stamp

func getArchiveName():
	return archive_name

func setArchiveName(archive_name_):
	archive_name = archive_name_

func getCreateTime():
	return create_time

func getCreateTimeStr():
	return TimeUnit.getDateTimeStrFrom(create_time)

func getLastSaveTimeStr():
	return TimeUnit.getDateTimeStrFrom(last_save_time)

func pack():
	var script_tree = ScriptTree.new()

	script_tree.addAttr("archive_name", archive_name)
	script_tree.addAttr("create_time", create_time)
	script_tree.addAttr("last_save_time", last_save_time)

	return script_tree

func loadScript(script_tree):
	script_tree.getStr("archive_name")
	script_tree.getInt("create_time")
	script_tree.getInt("last_save_time")
