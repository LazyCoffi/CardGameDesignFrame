extends GutTest

func before_all():
	CardCache.initScript()
	GlobalSetting.initScript()
	ResourceUnit.initScript()

func __testFunc():
	return 2

func test_callv():
	assert_eq(2, self.callv("__testFunc", []))
