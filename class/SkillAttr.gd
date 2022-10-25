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
	assert(condition is SkillCondition)
	conditions[condition.c_name] = condition

func delCondition(condition):
	assert(condition is SkillCondition)
	conditions.erase(condition.c_name)

func addEffect(effect):
	assert(effect is SkillEffect)
	effects[effect.e_name] = effect
	
func delEffect(effect):
	assert(effect is SkillEffect)
	effects.erase(effect.e_name)

func getConditions():
	return conditions.values()

func getConditionNames():
	return conditions.keys()

func getEffects():
	return effects.values()

func getEffectNames():
	return effects.keys()
	
