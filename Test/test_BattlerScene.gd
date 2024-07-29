extends GutTest

const BattlerScene = preload("res://Battle/Battler.tscn")
const SKELETON = preload("res://Battle/Monster/Skeleton.tres")

var battler: Battler = null


func before_each():
	battler = BattlerScene.instantiate()
	battler.set_creature(SKELETON.to_creature_stats())
	add_child(battler)


func after_each():
	battler.free()


func test_hurt():
	# arrange
	battler.set_hit_points(10)
	watch_signals(battler)

	# act
	battler.hurt(3)

	# assert
	assert_eq(battler.get_hit_points(), 7, "Should reduce damage from hit point when hurt")
	assert_signal_not_emitted(battler, "battler_died")
	
	# tear down
	var hit_effect = get_child(1)
	hit_effect.free()


func test_hurt_and_battler_died():
	# arrange
	battler.set_hit_points(10)
	watch_signals(battler)

	# act
	battler.hurt(11)

	# assert
	assert_eq(battler.get_hit_points(), 0, "Should reduce damage from hit point when hurt")
	assert_signal_emitted(battler, "battler_died")
	
	# tear down
	get_node("HitEffect").free()

