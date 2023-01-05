extends GutTest

var monster_manual: MonsterManual = null

func before_each():
	monster_manual = MonsterManual.new()


func test_can_create_MonsterManual():
	# act
	var my_monster_manual = MonsterManual.new()

	# assert
	assert_not_null(my_monster_manual)


func test_size():

	# act
	var size = monster_manual.size()

	# assert
	assert_eq(size, 0, "Should be empty after instanciation")


func test_add_monster():
	# arrange
	var monster = {
		name = "Goblin",
		hit_points = 2,
		armor_class = 10,
		texture_file = "res://Assets/Goblin_01.png"
	}

	# act
	monster_manual.add_monster(monster)

	# assert
	assert_eq(monster_manual.size(), 1, "Should add monster to monster manual")
	assert_not_null(monster_manual.get_monster("Goblin"))



func test_get_monster():
	# arrange
	monster_manual.add_monster({
		name = "Goblin",
		hit_points = 2,
		armor_class = 10,
		texture_file = "res://Assets/Goblin_01.png"
	})

	# act
	var monster = monster_manual.get_monster("Goblin")

	# assert
	assert_not_null(monster)
	assert_eq(monster["name"], "Goblin", "Should return entry of monster with name Goblin")


