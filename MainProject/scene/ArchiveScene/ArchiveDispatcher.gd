extends Node
class_name ArchiveDispatcher

var scene_ref

func setRef(scene):
	scene_ref = scene

func scene():
	return scene_ref

func render():
	return scene_ref.render()

func service():
	return scene_ref.service()

func launch():
	render().renderBackground()
	render().renderMenuRect()
	render().renderNextButton()
	render().renderPreviousButton()
	render().renderArchiveCard()
	render().renderBackButton()

	emitSelectArchiveSignal()
	emitBackOperSignal()
	emitNextSignal()
	emitPreviousSignal()

func emitSelectArchiveSignal():
	var archive_card_list = render().getArchiveCardList()
	var current_archive_list = service().getCurrentArchiveList()

	for index in range(current_archive_list.size()):
		var component_pack = archive_card_list[index]
		__createRoute(component_pack, "pressed", "receiveSelectArchiveSignal")

func receiveSelectArchiveSignal(component_key):
	service().selectArchive(component_key)
	render().renderArchiveOperRect()
	
	emitLoadArchiveSignal()
	emitDeleteArchiveSignal()

func emitBackOperSignal():
	var back_button = render().getBackButton()
	__createRoute(back_button, "pressed", "receiveBackOperSignal")

func receiveBackOperSignal(_component_key):
	service().returnTo()

func emitNextSignal():
	var next_button = render().getNextButton()
	__createRoute(next_button, "pressed", "receiveNextSignal")

func receiveNextSignal(_component_key):
	service().nextArchive()
	render().renderArchiveCard()

func emitPreviousSignal():
	var previous_button = render().getPreviousButton()
	__createRoute(previous_button, "pressed", "receivePreviousSignal")

func receivePreviousSignal():
	service().previousArchive()
	render().renderArchiveCard()

func emitLoadArchiveSignal():
	var load_button = render().getLoadButton()
	__createRoute(load_button, "pressed", "receiveLoadArchiveSignal")

func receiveLoadArchiveSignal(_component_key):
	service().loadArchive()

func emitDeleteArchiveSignal():
	var delete_button = render().getDeleteButton()
	__createRoute(delete_button, "pressed", "receiveDeleteArchiveSignal")

func receiveDeleteArchiveSignal(_component_key):
	service().deleteArchive()
	render().renderArchiveCard()
	render().renderArchiveOperRect()

func __createRoute(component_pack, component_signal, target_func):
	Logger.assert(not component_pack.isConnected(component_signal), "Component has connected!")
	component_pack.connectTo(self, component_signal, target_func)

func __destroyRoute(component_pack, component_signal, target_func):
	Logger.assert(component_pack.isConnected(component_signal), "Component hasn't connected yet!")
	component_pack.disconnectFrom(self, component_signal, target_func)
