extends GutTest

var battle_grid: BattleGrid = null

func before_each():
	battle_grid = BattleGrid.new()


func after_each():
	battle_grid.free()
	
	
func test_create_lines():
	# arrange
	
	# act
	var result = true
	
	# assert
	assert_eq(result, true)
