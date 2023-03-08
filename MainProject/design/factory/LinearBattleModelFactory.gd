extends "res://design/factory/Factory.gd"
class_name LinearBattleModelFactory

func _init():
	entity_type = "LinearBattleModel"
	entity = TypeUnit.type(entity_type).new()

func initMemberList():
	addObjectMember("own_team_function", "Function", "setOwnTeamFunction")
	addObjectMember("enemy_team_function", "Function", "setEnemyTeamFunction")
	addObjectMember("draw_num_function", "Function", "setDrawNumFunction")
	addObjectMember("is_dead_condition", "Function", "setIsDeadCondition")
	addObjectMember("is_battle_over_condition", "Function", "setIsBattleOverCondition")
	addFuncMember("setBucketInitShuffleFunction", [
		{"name" : "init_shuffle_function", "type" : "Function", "param_val" : "object"},
	])
	addFuncMember("setBucketRegularShuffleFunction", [
		{"name" : "regular_shuffle_function", "type" : "Function", "param_val" : "object"},
	])
