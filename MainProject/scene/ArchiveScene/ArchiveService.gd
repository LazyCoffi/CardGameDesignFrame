extends Node
class_name ArchiveService

var scene_ref

func setRef(scene):
	scene_ref = scene

func scene():
	return scene_ref

func model():
	return scene_ref.model()

func nextPage():
	var archive_num = SceneManager.getArchiveNum()
	var page_size = model().getPageSize()
	var page_index = model().getPageIndex()

	if page_size * page_index < archive_num:
		model().nextPage()

func previousPage():
	model().previousPage()

func getCurrentArchiveList():
	var ret = []
	var page_index = model().getPageIndex()
	var page_size = model().getPageSize()
	var head = (page_index - 1) * page_size
	var tail = min(page_index * page_size, SceneManager.getArchiveNum())
	for index in range(head, tail):
		ret.append(SceneManager.getArchiveByIndex(index))
	
	return ret
	
func delArchive(current_index):
	var page_index = model().getPageIndex()
	var page_size = model().getPageSize()
	var index = (page_index - 1) * page_size + current_index

	SceneManager.delArchiveByIndex(index)

	model().resetSelectedArchive()
	
func loadArchive():
	var archive = model().getSelectedArchive()
	scene().loadArchive(archive.getArchiveName())

func selectArchive(current_index):
	var page_index = model().getPageIndex()
	var page_size = model().getPageSize()
	var index = (page_index - 1) * page_size + current_index
	index = min(index, SceneManager.getArchiveNum() - 1)

	var archive = SceneManager.getArchiveByIndex(index)
	model().selectArchive(archive)

func returnTo():
	model().returnFunction(scene())
