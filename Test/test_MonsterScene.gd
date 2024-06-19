extends GutTest

const MonsterScene = preload("res://Combat/Monster.tscn")

var monster: Monster = null


func before_each():
	monster = MonsterScene.instantiate()


func after_each():
	monster.free()


func test_hurt():
	# arrange
	monster.set_hit_points(10)
	add_child(monster)
	watch_signals(monster)

	# act
	monster.hurt(3)

	# assert
	assert_eq(monster.get_hit_points(), 7, "Should reduce damage from hit point when hurt")
	assert_signal_not_emitted(monster, "battler_died")
	
	# tear down
	var hit_effect = get_child(1)
	hit_effect.free()


func test_hurt_and_battler_died():
	# arrange
	monster.set_hit_points(10)
	add_child(monster)
	watch_signals(monster)

	# act
	monster.hurt(11)

	# assert
	assert_eq(monster.get_hit_points(), 0, "Should reduce damage from hit point when hurt")
	assert_signal_emitted(monster, "battler_died")
	
	# tear down
	get_node("HitEffect").free()
