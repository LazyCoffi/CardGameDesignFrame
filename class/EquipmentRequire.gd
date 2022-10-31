extends Node
class_name EquipmentRequire

var strength_re setget setStrengthRe
var agility_re setget setAgilityRe
var insight_re setget setInsightRe
var intelligence_re setget setIntelligenceRe
var mystery_re setget setMysteryRe
var perserverance_re setget setPerserveranceRe
var belief_re setget setBeliefRe
var physique_re setget setPhysiqueRe
var speed_re setget setSpeedRe

func setStrengthRe(strength_re_):
	assert(strength_re_ > 0)
	strength_re = strength_re_

func setAgilityRe(agility_re_):
	assert(agility_re_ > 0)
	agility_re = agility_re_

func setInsightRe(insight_re_):
	assert(insight_re_ > 0)
	insight_re_ = insight_re

func setIntelligenceRe(intelligence_re_):
	assert(intelligence_re_ > 0)
	intelligence_re = intelligence_re_
	
func setMysteryRe(mystery_re_):
	assert(mystery_re_ > 0)
	mystery_re = mystery_re_

func setPerserveranceRe(perserverance_re_):
	assert(perserverance_re_ > 0)
	perserverance_re = perserverance_re_
	
func setBeliefRe(belief_re_):
	assert(belief_re_ > 0)
	belief_re = belief_re_

func setPhysiqueRe(physique_re_):
	assert(physique_re_ > 0)
	physique_re = physique_re_

func setSpeedRe(speed_re_):
	assert(speed_re_ > 0)
	speed_re_ = speed_re

func isReady(character):
	assert(character is CharacterCard)
	var info = character.info
	if info.strength < strength_re:
		return false
	if info.agility < agility_re:
		return false
	if info.insight < insight_re:
		return false
	if info.intelligence < intelligence_re:
		return false
	if info.perserverance < perserverance_re:
		return false
	if info.mystery < mystery_re:
		return false
	if info.belief < belief_re:
		return false
	if info.physique < physique_re:
		return false
	if info.speed < speed_re:
		return false
		
	return true

func getRequirement():
	var requirement = {}
	requirement["strength"] = strength_re
	requirement["agility"] = agility_re
	requirement["insight"] = insight_re
	requirement["intelligence"] = intelligence_re
	requirement["perserverance"] = perserverance_re
	requirement["mystery"] = mystery_re
	requirement["belief"] = belief_re
	requirement["physique"] = physique_re
	requirement["speed"] = speed_re
	
	return requirement

func pack():
	var data_pack = {}
	data_pack["strength_re"] = strength_re
	data_pack["agility_re"] = agility_re
	data_pack["insight_re"] = insight_re
	data_pack["intelligence_re"] = intelligence_re
	data_pack["mystery_re"] = mystery_re
	data_pack["perserverance_re"] = perserverance_re
	data_pack["belief_re"] = belief_re
	data_pack["physique_re"] = physique_re
	data_pack["speed_re"] = speed_re
	
	return data_pack

static func loadPack(data_pack):
	var require = load("res://class/EquipmentRequire.gd").new()
	require.strength_re = data_pack["strength_re"]
	require.agility_re = data_pack["agility_re"]
	require.insight_re = data_pack["insight_re"]
	require.intelligence_re = data_pack["intelligence_re"]
	require.mystery_re = data_pack["mystery_re"]
	require.perserverance_re = data_pack["perserverance_re"]
	require.belief_re = data_pack["belief_re"]
	require.physique_re = data_pack["physique_re"]
	require.speed_re = data_pack["speed_re"]
	
	return require
