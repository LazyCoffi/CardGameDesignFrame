extends Node

var MainMenuScene = preload("res://scene/MainMenuScene/MainMenuScene.tscn")
var BattleScene = preload("res://scene/BattleScene/BattleScene.tscn")
var CharacterGenScene = preload("res://scene/CharacterGenScene/CharacterGenScene.tscn")

var container = {}

func _ready():
	pass

func freeScene(scene): 
	scene.free()

func createMainMenu(): 
	if container.has("MainMenu"):
		freeScene(container["MainMenu"])
	container["MainMenu"] = MainMenuScene.instance()
	
func getMainMenu():
	return container["MainMenu"]
	
func createBattle():
	if container.has("Battle"):
		freeScene(container["Battle"])
	container["Battle"] = BattleScene.instance()

func getBattle():
	return container["Battle"]

func createCharacterGen():
	if container.has("CharacterGen"):
		freeScene(container["CharacterGen"])
	container["CharacterGen"] = CharacterGenScene.instance()

func getCharacterGen():
	return container["CharacterGen"]
	
func sceneCall(scene_name, func_name, params):
	return container[scene_name].callv(func_name, params)
	
func loadPack(data_pack):
	pass

func pack():
	pass
