extends Node
class_name ArchiveService

var scene_ref

func setRef(scene):
	scene_ref = scene

func scene():
	return scene_ref

func model():
	return scene_ref.model()

func nextArchive():
	if model().getHeadPointer() >= SceneManager.getArchiveNum():
		return
	
	model().next()

func previousArchive():
	model().previous()

func getCurrentArchiveList():
	var ret = []
	for index in range(model().getHeadPointer(), min(model().getHeadPointer() + model().getMaxArchiveNum(), SceneManager.getArchiveNum())):
		ret.append(SceneManager.getArchiveByIndex(index))
	
	return ret
	
func delArchive(current_index):
	var index = model().getHeadPointer() + current_index
	index = min(index, SceneManager.getArchiveNum() - 1)

	SceneManager.delArchiveByIndex(index)

	if SceneManager.getArchiveNum() == 0:
		model().resetSelectedArchive()
	
	if model().getHeadPointer() == SceneManager.getArchiveNum() - 1:
		model().previous()
	
	model().selectArchive(model().getHeadPointer())
	
func loadArchive():
	var archive = model().getSelectedArchive()
	scene().loadArchive(archive.getArchiveName())

func selectArchive(current_index):
	var index = model().getHeadPointer() + current_index
	index = min(index, SceneManager.getArchiveNum() - 1)

	var archive = SceneManager.getArchiveByIndex(index)
	model().selectArchive(archive)

func returnTo():
	scene().popScene()
