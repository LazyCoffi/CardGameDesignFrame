extends "res://design/factory/Factory.gd"
class_name LinearBattleModelFactory

func _init():
	__setMemberList()
	initMemberView()
	initConfigView()

	entity_type = "LinearBattleModel"
	entity = TypeUnit.type(entity_type).new()

func __setMemberList():
	addObjectMember("order_bucket", "OrderBucket")
	addObjectMember("own_team_function", "Function")
	addObjectMember("enemy_team_function", "Function")
	addObjectMember("draw_num_function", "Function")
	addObjectMember("is_dead_condition", "Function")
	addObjectMember("is_battle_over_condition", "Function")

func buildRef(blueprint):
	entity.setOrderBucket(blueprint["order_bucket"])
	entity.setOwnTeamFunction(blueprint["own_team_function"])
	entity.setEnemyTeamFunction(blueprint["enemy_team_function"])
	entity.setDrawNumFunction(blueprint["draw_num_function"])
	entity.setIsDeadCondition(blueprint["is_dead_condition"])
	entity.setIsBattleOverCondition(blueprint["is_battle_over_condition"])

func build(_blueprint):
	return

