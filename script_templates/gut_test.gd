extends GutTest

var under_test: %BASE% = null


func before_each():
	under_test = %BASE%.new()
	
	
func after_each():
	under_test.free()
