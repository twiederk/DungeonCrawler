extends GutTest

const Monster = preload("res://World/Monster.tscn")
const texture = preload("res://World/Goblin_01.png")

var monster: Monster = null

func before_each():
	monster = Monster.instance()


func after_each():
	monster.free()


func test_get_creature():
	# act
	var creature = monster.get_creature()

	# assert
	assert_not_null(creature)


func test_set_texture():

	# act
	monster.set_texture(texture)

	# assert
	assert_eq(monster.get_node("Sprite").texture, texture, "Should set texture on sprite of monster")


func test__on_Hurtbox_area_entered():

	# arrange
	watch_signals(monster)

	# act
	monster._on_Hurtbox_area_entered(null)

	# assert
	assert_signal_emitted(monster, 'attacked')
