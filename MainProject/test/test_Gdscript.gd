extends GutTest

func __testFunc():
	return 2

func test_callv():
	assert_eq(2, self.callv("__testFunc", []))
