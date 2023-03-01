extends GutTest

const Character = preload("res://Combat/Character.tscn")
const texture = preload("res://Assets/graphics/sprites/Fighter.png")

const STEP = 16

var _sender = InputSender.new(Input)
var character: Character = null


func before_each():
	character = Character.instantiate()


func after_each():
	character.free()
	_sender.release_all()
	_sender.clear()


func test_should_have_zero_velocity_when_no_input_is_given():

	# assert
	Input.flush_buffered_events()

	# act
	character.move()

	# assert
	assert_eq(character.position, Vector2.ZERO)


func test_move_right():

	# arrange
	_sender.action_down('ui_right')
	Input.flush_buffered_events()
	var hitbox_pivot = Marker2D.new()
	character.hitboxPivot = hitbox_pivot
	var ray_cast_right = RayCast2D.new()
	character.ray_cast_right = ray_cast_right
	character.get_creature().set_movement(1)

	# act
	character.move()

	# assert
	assert_eq(character.position, Vector2(STEP, 0), "Should step right when right is pressed")
	assert_eq(hitbox_pivot.rotation_degrees, 0.0, "Should rotate hitbox by 0 degrees")

	# tear down
	hitbox_pivot.free()
	ray_cast_right.free()


func test_move_left():
	# arrange
	_sender.action_down('ui_left')
	Input.flush_buffered_events()
	var hitbox_pivot = Marker2D.new()
	character.hitboxPivot = hitbox_pivot
	var ray_cast_left = RayCast2D.new()
	character.ray_cast_left = ray_cast_left
	character.get_creature().set_movement(1)

	# act
	character.move()

	# assert
	assert_eq(character.position, Vector2(-STEP, 0), "Should step left when left is pressed")
	assert_eq(hitbox_pivot.rotation_degrees, 180.0, "Should rotate hitbox by 180 degrees")

	# tear down
	hitbox_pivot.free()
	ray_cast_left.free()


func test_move_up():
	# arrange
	_sender.action_down('ui_up')
	Input.flush_buffered_events()
	var hitbox_pivot = Marker2D.new()
	character.hitboxPivot = hitbox_pivot
	var ray_cast_up = RayCast2D.new()
	character.ray_cast_up = ray_cast_up
	character.get_creature().set_movement(1)

	# act
	character.move()

	# assert
	assert_eq(character.position, Vector2(0, -STEP), "Should step up when up is pressed")
	assert_eq(hitbox_pivot.rotation_degrees, 270.0, "Should rotate hitbox by 270 degrees")

	# tear down
	hitbox_pivot.free()
	ray_cast_up.free()


func test_move_down():
	# arrange
	_sender.action_down('ui_down')
	Input.flush_buffered_events()
	var hitbox_pivot = Marker2D.new()
	character.hitboxPivot = hitbox_pivot
	var ray_cast_down = RayCast2D.new()
	character.ray_cast_down = ray_cast_down
	character.get_creature().set_movement(1)

	# act
	character.move()

	# assert
	assert_eq(character.position, Vector2(0, STEP), "Should step down when down is pressed")
	assert_eq(hitbox_pivot.rotation_degrees, 90.0, "Should rotate hitbox by 90 degrees")

	# tear down
	hitbox_pivot.free()
	ray_cast_down.free()


func test_move_turn_down_no_movement():
	# arrange
	_sender.action_down('ui_down')
	Input.flush_buffered_events()
	var hitbox_pivot = Marker2D.new()
	character.hitboxPivot = hitbox_pivot
	var ray_cast_down = RayCast2D.new()
	character.ray_cast_down = ray_cast_down
	character.get_creature().set_movement(0)

	# act
	character.move()

	# assert
	assert_eq(character.position, Vector2.ZERO, "Should stay in same position when movement left")
	assert_eq(hitbox_pivot.rotation_degrees, 90.0, "Should rotate hitbox by 90 degrees")

	# tear down
	hitbox_pivot.free()
	ray_cast_down.free()



func test_set_texture():

	# act
	character.set_texture(texture)

	# assert
	assert_eq(character.get_node("Sprite2D").texture, texture, "Should set texture checked sprite of character")


func test_on_Item_picked():

	# act
	character._on_Item_picked({ gold = 5})

	# assert
	var inventory = character.get_inventory()
	assert_eq(inventory.get_gold(), 5, "Should increase gold of character by 5")


func test_move_step():

	# arrange
	character.get_creature().set_movement(4)
	var hitbox_pivot = Marker2D.new()
	character.hitboxPivot = hitbox_pivot

	# act
	character.move_step(Vector2.RIGHT)

	# assert
	var creature = character.get_creature()
	assert_eq(creature.get_movement(), 3, "Should make a step when character moves")

	# tear down
	hitbox_pivot.free()


func test_can_move_movement_left():

	# arrange
	var ray_cast = RayCast2D.new()
	character.get_creature().set_movement(1)

	# act
	var can_move = character.can_move(ray_cast)

	# assert
	assert_true(can_move, "Should allow move when movement left")
	
	# tear down
	ray_cast.free()


func test_can_move_movement_gone():

	# arrange
	var ray_cast = RayCast2D.new()
	character.get_creature().set_movement(0)

	# act
	var can_move = character.can_move(ray_cast)

	# assert
	assert_false(can_move, "Should deny move when movement gone")
	
	# tear down
	ray_cast.free()
