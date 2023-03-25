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
	addObjectMember("is_victory_condition", "Function", "setIsVictoryCondition")
	addObjectMember("is_fail_condition", "Function", "setIsFailCondition")
	addObjectMember("before_round_function", "HyperFunction", "setBeforeRoundFunction")
	addObjectMember("after_round_function", "HyperFunction", "setAfterRoundFunction")
	addObjectMember("victory_function", "HyperFunction", "setVictoryFunction")
	addObjectMember("fail_function", "HyperFunction", "setFailFunction")
	addObjectMember("sub_menu_function", "HyperFunction", "setSubMenuFunction")

	addFuncMember("setBucketInitShuffleFunction", [
		{"name" : "init_shuffle_function", "type" : "Function", "param_type" : "object"},
	])
	addFuncMember("setBucketRegularShuffleFunction", [
		{"name" : "regular_shuffle_function", "type" : "Function", "param_type" : "object"},
	])
