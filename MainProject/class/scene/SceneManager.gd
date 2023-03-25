extends Node

var SceneCache = TypeUnit.type("SceneCache")
var ArchiveManager = TypeUnit.type("ArchiveManager")

var scene_cache
var scene_loader
var archive_manager

func _init():
	scene_cache = SceneCache.new()
	scene_loader = SceneLoader.new()
	archive_manager = ArchiveManager.new()

func hasScene():
	return not scene_cache.empty()

func pushScene(scene_name):
	if not scene_cache.has(scene_name):
		var scene_pack = scene_loader.loadScene(scene_name)
		scene_cache.store(scene_pack)
	
	scene_cache.push(scene_name)

func popScene():
	var ret = topScene()
	scene_cache.pop()
	return ret

func getScene(scene_name):
	if not scene_cache.has(scene_name):
		var scene_pack = scene_loader.loadScene(scene_name)
		scene_cache.store(scene_pack)

	return scene_cache.get(scene_name).getScene()

func topScene():
	return scene_cache.get(scene_cache.top()).getScene()

func peekSceneStack():
	var scene_name_stack = scene_cache.peek()
	var ret = []
	for scene_name in scene_name_stack:
		ret.append(scene_cache.get(scene_name))

	return ret

func peekArchiveList():
	return archive_manager.peekArchiveList()

func getArchiveByIndex(index):
	archive_manager.getArchiveByIndex(index)

func getArchiveNum():
	return archive_manager.getArchiveNum()

func setArchive(archive_name):
	archive_manager.setArchive(archive_name)

func delArchive(archive_name):
	archive_manager.delArchive(archive_name)

func delArchiveByIndex(index):
	archive_manager.delArchiveByIndex(index)

func saveArchive():
	archive_manager.saveArchive(scene_cache)

func callService(scene_name, func_name, params):
	var scene_service = getScene(scene_name).service()
	return scene_service.callv(func_name, params)

func callRender(scene_name, func_name, params):
	var scene_render = getScene(scene_name).render()
	return scene_render.callv(func_name, params)

func loadArchive(archive_name):
	archive_manager.setArchiveName(archive_name)
	scene_cache = archive_manager.loadArchive(archive_name)
