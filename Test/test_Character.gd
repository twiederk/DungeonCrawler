extends GutTest

var character: Character = null


func before_each():
	character = Character.new()


func after_each():
	character.free()


func test_on_Item_picked():

	# act
	character._on_Item_picked({ gold = 5})

	# assert
	var inventory = character.get_inventory()
	assert_eq(inventory.get_gold(), 5, "Should increase gold of character by 5")


func test_move_step():

	# arrange
	character.set_movement(4)
	var hitbox_pivot = Marker2D.new()
	character.hitboxPivot = hitbox_pivot

	# act
	character.move_step(Vector2.RIGHT)

	# assert
	var creature = character.get_creature()
	assert_eq(creature.movement, 3, "Should make a step when character moves")

	# tear down
	hitbox_pivot.free()


func test_can_move_movement_left():

	# arrange
	var ray_cast = RayCast2D.new()
	character.set_movement(1)

	# act
	var can_move = character.can_move(ray_cast)

	# assert
	assert_true(can_move, "Should allow move when movement left")
	
	# tear down
	ray_cast.free()


func test_can_move_movement_gone():

	# arrange
	var ray_cast = RayCast2D.new()
	character.set_movement(0)

	# act
	var can_move = character.can_move(ray_cast)

	# assert
	assert_false(can_move, "Should deny move when movement gone")
	
	# tear down
	ray_cast.free()
