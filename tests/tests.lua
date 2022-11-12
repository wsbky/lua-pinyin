local test_normal = require("tests.test_normal").test

local tests = {
    { name = "test_normal", test = test_normal }
}

return {
    tests = tests
}
