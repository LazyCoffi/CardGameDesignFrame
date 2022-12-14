extends Node
class_name SkillAttr

const POSITIVE = 1
const PASSIVE = 2
const AUTO = 4

var type setget setType
var conditions = {}
var effects = {}

func setType(type_):
	assert(type_ is int)
	assert(type_ >= 0 and type_ < 8)
	type = type_

func setPositive():
	type |= POSITIVE

func setPassive():
	type |= PASSIVE

func setAuto():
	type |= AUTO

func isPositive():
	return true if (type & POSITIVE) > 0 else false

func isPassive():
	return true if (type & PASSIVE) > 0 else false

func isAuto():
	return true if (type & AUTO) > 0 else false

func addCondition(condition):
	conditions[condition.c_name] = condition

func delCondition(condition):
	conditions.erase(condition.c_name)

func addEffect(effect):
	effects[effect.e_name] = effect
	
func delEffect(effect):
	effects.erase(effect.e_name)

func getConditions():
	return conditions.values()

func getConditionNames():
	return conditions.keys()

func getEffects():
	return effects.values()

func getEffectNames():
	return effects.keys()

func pack():
	var data_pack = {}
	data_pack["type"] = type
	data_pack["conditions"] = conditions
	data_pack["effects"] = effects
	
	return data_pack

func loadPack(data_pack):
	assert(data_pack is Dictionary)
	
	type = int(data_pack["type"])
	conditions = data_pack["conditions"]
	effects = data_pack["effects"]
