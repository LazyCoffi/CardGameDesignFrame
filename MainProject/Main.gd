extends Node

## 作为Bootloader， 在此初始化SceneController，
## 创建主菜单场景，并将控制权交给主菜单场景

func gameInit():
	GlobalSetting.loadGlobalSetting()
	CardTemplate.loadCards()
	SceneContainer.createMainMenu()
	SceneContainer.createBattle()
	UnitTools.toolInit()

func _ready():
	gameInit()
	var main_menu = SceneContainer.getMainMenu()
	$SceneController.changeScene(main_menu)
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
