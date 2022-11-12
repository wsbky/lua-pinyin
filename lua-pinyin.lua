local tonechars = {
    a = { [1] = "ā", [2] = "á", [3] = "ǎ", [4] = "à" },
    e = { [1] = "ē", [2] = "é", [3] = "ě", [4] = "è" },
    i = { [1] = "ī", [2] = "í", [3] = "ǐ", [4] = "ì" },
    o = { [1] = "ō", [2] = "ó", [3] = "ǒ", [4] = "ò" },
    u = { [1] = "ū", [2] = "ú", [3] = "ǔ", [4] = "ù" },
    v = { [1] = "ǖ", [2] = "ǘ", [3] = "ǚ", [4] = "ǜ" },
    A = { [1] = "Ā", [2] = "Á", [3] = "Ǎ", [4] = "À" },
    O = { [1] = "Ō", [2] = "Ó", [3] = "Ǒ", [4] = "Ò" },
    E = { [1] = "Ē", [2] = "É", [3] = "Ě", [4] = "È" },
}

local function contains(c, str)
    for i = 1, #str do
        local t = str:sub(i, i)
        if t == c then
            return true
        end
    end
    return false
end

local function tonepriority(c)
    if c == "a" then
        return 10
    elseif c == "o" then
        return 9
    elseif c == "e" then
        return 8
    elseif c == "i" then
        return 6
    elseif c == "u" then
        return 6
    elseif c == "v" then
        return 5
    elseif c == "A" then
        return 10
    elseif c == "O" then
        return 9
    elseif c == "E" then
        return 8
    else
        return 0
    end
end

local function pinyin(str)
    local result = ""
    local tonechar = ""
    local beforetone = ""
    local aftertone = ""
    for i = 1, #str do
        local c = str:sub(i, i)
        local n = tonumber(c, 10)
        if n then
            local toned = tonechars[tonechar][n]
            if toned then
                local addition = beforetone .. toned .. aftertone
                result = result .. addition
            else
                local addition = beforetone .. tonechar .. aftertone
                result = result .. addition
            end
            beforetone = ""
            aftertone = ""
            tonechar = ""
        elseif contains(c, "!?. ") then
            local addition = beforetone .. tonechar .. aftertone .. c
            result = result .. addition
            beforetone = ""
            aftertone = ""
            tonechar = ""
        else
            if tonepriority(c) >= tonepriority(tonechar) then
                beforetone = beforetone .. tonechar .. aftertone
                tonechar = c
                aftertone = ""
            else
                aftertone = aftertone .. c
            end
        end
    end
    local addition = beforetone .. tonechar .. aftertone
    result = result .. addition
    result = result:gsub("v", "ü")
    return result
end

local function pinyin_tex(str)
    str = pinyin(str)
    tex.sprint(str)
end

return {
    pinyin = pinyin,
    pinyin_tex = pinyin_tex,
}
