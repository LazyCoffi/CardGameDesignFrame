extends Node

## 作为Bootloader， 在此初始化SceneController，
## 创建主菜单场景，并将控制权交给主菜单场景

func _ready():
	SceneContainer.createMainMenu()
	SceneContainer.createBattle()
	var main_menu = SceneContainer.getMainMenu()
	$SceneController.changeScene(main_menu)
	
	CardTemplate.loadCards()
	var test_card = CardTemplate.getCard("TestCard")
	print(test_card.info.c_name)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
