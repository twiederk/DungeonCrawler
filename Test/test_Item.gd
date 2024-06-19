extends GutTest

var item : ItemArea2D = null

func before_each():
	item = ItemArea2D.new()


func after_each():
	item.free()


func test_can_create_Item():
	# act
	var myItem = ItemArea2D.new()

	# assert
	assert_not_null(myItem)

	# tear down
	myItem.free()


func test_on_Item_body_entered():
	# arrange
	watch_signals(item)
	var character = Character.new()

	# act
	item._on_Item_body_entered(character)

	# assert
	assert_signal_emitted(item, "picked")

	# tear down
	character.free()
