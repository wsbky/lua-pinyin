local pinyin = require("lua-pinyin").pinyin

local tests = require("tests.tests").tests

-- print(tests)

for _, test in pairs(tests) do
    context(test.name, function()
        for i, test_value in ipairs(test.test) do
            spec(string.format("%03d", i), function()
                assert.same(pinyin(test_value.input), test_value.expected)
            end)
        end
    end)
end
