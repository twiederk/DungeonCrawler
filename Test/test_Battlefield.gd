extends GutTest

var battlefield


func before_each():
	battlefield = Battlefield.new()


func after_each():
	battlefield.free()


func test_as_string():
	# arrange
	var character1 = CharacterBattler.new()
	character1.position = Vector2(32, 32)
	var character2 = CharacterBattler.new()
	character2.position = Vector2(64, 32)
	battlefield.characters = [character1, character2] as Array[Battler]

	var monster1 = MonsterBattler.new()
	monster1.position = Vector2(96, 64)
	var monster2 = MonsterBattler.new()
	monster2.position = Vector2(128, 64)
	battlefield.monsters = [monster1, monster2] as Array[Battler]

	# act
	var output = battlefield.as_string()

	# assert
	assert_eq(output[0], "--------------------")
	assert_eq(output[1], "-cc-----------------")
	assert_eq(output[2], "---mm---------------")

	# tear down
	character1.free()
	character2.free()
	monster1.free()
	monster2.free()


func test_find_attack_positions():
	# arrange
	# c = character, m = monster
	# -ccm
	# ----
	var character1 = CharacterBattler.new()
	character1.position = Vector2(32, 0)
	var character2 = CharacterBattler.new()
	character2.position = Vector2(64, 0)
	battlefield.characters = [character1, character2] as Array[Battler]
	
	var monster = MonsterBattler.new()
	monster.position = Vector2(96, 0)
	battlefield.monsters = [monster] as Array[Battler]

	# act
	var attack_positions = battlefield.find_attack_positions()

	# assert
	assert_eq(attack_positions, [ Vector2(32, 32), Vector2(0, 0), Vector2(64, 32) ])

	# tear down
	character1.free()
	character2.free()
	monster.free()

func test_find_nearest_attack_position():
	# arrange
	# c = character, m = monster, s = start
	# -ccm
	# ----
	# --s-
	var character1 = CharacterBattler.new()
	character1.position = Vector2(32, 0)
	var character2 = CharacterBattler.new()
	character2.position = Vector2(64, 0)
	battlefield.characters = [character1, character2] as Array[Battler]

	var monster = MonsterBattler.new()
	monster.position = Vector2(96, 64)
	battlefield.monsters = [monster] as Array[Battler]

	# act
	var attack_position = battlefield.find_nearest_attack_position(Vector2(64, 64))

	# assert
	assert_eq(attack_position, Vector2(64, 32))

	# tear down
	character1.free()
	character2.free()
	monster.free()


func test_find_neighbors_top_left_corner():

	# act
	var neighbors = battlefield.find_neighbors(Vector2(0, 0))

	# assert
	assert_eq(neighbors, [Vector2(32, 0), Vector2(0, 32)])


func test_find_neighbors_top_edge_with_blocked_by_monster_and_character():
	# arrange
	var character = CharacterBattler.new()
	character.position = Vector2(0, 0)
	battlefield.characters = [character] as Array[Battler]

	var monster = MonsterBattler.new()
	monster.position = Vector2(64, 0)
	battlefield.monsters = [monster] as Array[Battler]

	# act
	var neighbors = battlefield.find_neighbors(Vector2(32, 0))

	# assert
	assert_eq(neighbors, [Vector2(32, 32)])

	# tear down
	character.free()
	monster.free()


func test_is_on_battlefield_true():

	# act
	var result = battlefield.is_on_battlefield(Vector2(0, 0))

	# assert
	assert_true(result)


func test_is_on_battlefield_false():

	# act
	var result = battlefield.is_on_battlefield(Vector2(0, -1))

	# assert
	assert_false(result)


func test_is_free_true():

	# act
	var result = battlefield.is_free(Vector2(0, 0))

	# assert
	assert_true(result)


func test_is_free_taken_by_character():
	# arrange
	var character = CharacterBattler.new()
	character.position = Vector2(32, 32)
	battlefield.characters = [character] as Array[Battler]

	# act
	var result = battlefield.is_free(Vector2(32, 32))

	# assert
	assert_false(result)
	
	# tear down
	character.free()


func test_is_free_taken_by_monster():
	# arrange
	var monster = MonsterBattler.new()
	monster.position = Vector2(32, 32)
	battlefield.monsters = [monster] as Array[Battler]

	# act
	var result = battlefield.is_free(Vector2(32, 32))

	# assert
	assert_false(result)
	
	# tear down
	monster.free()


func test_bfs_simple():
	# arrange
	# s = start, t = target, c = character, m = monster
	# s-
	# -t

	# act
	var path = battlefield.bfs(Vector2(0, 0), Vector2(32, 32))

	# assert
	assert_eq(path, [Vector2(32, 0), Vector2(32, 32)])


func test_bfs_obstacle():
	# arrange
	# s = start, t = target, c = character, m = monster
	# scmt
	# ----
	var character = CharacterBattler.new()
	character.position = Vector2(32, 0)
	battlefield.characters = [character] as Array[Battler]

	var monster = MonsterBattler.new()
	monster.position = Vector2(64, 0)
	battlefield.monsters = [monster] as Array[Battler]

	# act
	var path = battlefield.bfs(Vector2(0, 0), Vector2(96, 0))

	# assert
	assert_eq(path, [Vector2(0, 32), Vector2(32, 32), Vector2(64, 32), Vector2(96, 32), Vector2(96, 0)])

	# tear down
	character.free()
	monster.free()


func test_bfs_from_left_to_right():
	# arrange
	# s = start, t = target, c = character, m = monster
	# s----t

	# act
	var path = battlefield.bfs(Vector2(0, 0), Vector2(160, 0))

	# assert
	assert_eq(path, [Vector2(32, 0), Vector2(64, 0), Vector2(96, 0), Vector2(128, 0), Vector2(160, 0)] )


func test_bfs_from_right_to_left():
	# arrange
	# s = start, t = target, c = character, m = monster
	# t----s

	# act
	var path = battlefield.bfs(Vector2(160, 0), Vector2(0, 0))

	# assert
	assert_eq(path, [Vector2(128,0), Vector2(96, 0), Vector2(64, 0), Vector2(32, 0), Vector2(0, 0)])


func test_bfs_from_bottom_right_to_top_left():
	# arrange
	# s = start, t = target, c = character, m = monster
	# t---
	# ----
	# ----
	# ---s

	# act
	var path = battlefield.bfs(Vector2(96, 96), Vector2(0, 0))

	# assert
	assert_eq(path, [ Vector2(64, 96), Vector2(32, 96), Vector2(0, 96), Vector2(0, 64), Vector2(0, 32), Vector2(0, 0)])


func test_manhatten_distance():

	# act
	var distance = battlefield.manhatten_distance(Vector2(0, 0), Vector2(128, 96))

	# assert
	assert_eq(distance, 224)
