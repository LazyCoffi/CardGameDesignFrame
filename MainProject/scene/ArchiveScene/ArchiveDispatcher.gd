extends "res://scene/BaseDispatcher.gd"
class_name ArchiveDispatcher

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
	service().nextPage()
	render().renderArchiveCard()

func emitPreviousSignal():
	var previous_button = render().getPreviousButton()
	__createRoute(previous_button, "pressed", "receivePreviousSignal")

func receivePreviousSignal(_component_key):
	service().previousPage()
	render().renderArchiveCard()

func emitLoadArchiveSignal():
	var load_button = render().getLoadButton()
	__createRoute(load_button, "pressed", "receiveLoadArchiveSignal")

func receiveLoadArchiveSignal(_component_key):
	service().loadArchive()

func emitDeleteArchiveSignal():
	var delete_button = render().getDeleteButton()
	__createRoute(delete_button, "pressed", "receiveDeleteArchiveSignal")

func receiveDeleteArchiveSignal(component_key):
	service().delArchive(int(component_key))
	render().renderArchiveCard()
	render().clearArchiveOperRect()

func __createRoute(component_pack, component_signal, target_func):
	if not component_pack.isConnected(component_signal):
		component_pack.connectTo(self, component_signal, target_func)

func __destroyRoute(component_pack, component_signal, target_func):
	if component_pack.isConnected(component_signal):
		component_pack.disconnectFrom(self, component_signal, target_func)
