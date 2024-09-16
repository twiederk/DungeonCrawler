extends GutTest

const BattleScene: PackedScene = preload("res://Battle/Battle.tscn")

var battle: Battle = null


func before_each():
	battle = BattleScene.instantiate()
	add_child(battle)


func after_each():
	battle.free()

