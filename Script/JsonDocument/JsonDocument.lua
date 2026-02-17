--[[
Author: xixi_
Date: 2025-07-12 21:23:50
LastEditors: xixi_
LastEditTime: 2025-07-14 16:28:38
FilePath: /LYCF/Src/Core/JsonDocument.lua
Copyright (c) 2020-2025 by xixi_ , All Rights Reserved.
--]]

--
-- json.lua
--
-- Copyright (c) 2020 rxi
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy of
-- this software and associated documentation files (the "Software"), to deal in
-- the Software without restriction, including without limitation the rights to
-- use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
-- of the Software, and to permit persons to whom the Software is furnished to do
-- so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.
--

--[[
    JsonDocument模块二次改造而来的
    这个是递归版本的, 我们还需要一个非递归版本
]]

-------------------------------------------------------------------------------

--[[ NULL宏 ]]
local NULL = nil;
-------------------------------------------------------------------------------

--[[
    值类型枚举(保留,后期考虑使用)
    引入这个原因是因为有漏洞
]]
local JsonValueType = {
    NULL = 0
};
-------------------------------------------------------------------------------


---
--- 提供了JSON`序列化`与`反序列化`功能
---
---@nodiscard 仅有两个函数`Encode`和`Decode`
local JsonDocument = { Version = "0.0.1" };

-------------------------------------------------------------------------------
-- Encode: Lua table to JSON
-------------------------------------------------------------------------------

local Encode;

local EscapeCharMap = {
    ["\\"] = "\\", --[[ 反斜杠 ]]
    ["\""] = "\"", --[[ 双引号 ]]
    ["\b"] = "b", --[[ 退格符 ]]
    ["\f"] = "f", --[[ 换页符 ]]
    ["\n"] = "n", --[[ 换行符 ]]
    ["\r"] = "r", --[[ 回车符 ]]
    ["\t"] = "t", --[[ 制表符 ]]
}

--[[ 转义字符的函数 ]]
local function EscapeChar(Char)
    --[[ 转义字符，若没有匹配到则用unicode表示 ]]
    return "\\" .. (EscapeCharMap[Char] or string.format("u%04x", Char:byte()));
end

--[[ 编码空值 ]]
local function EncodeNil()
    return "null";
end

--[[ 编码表 ]]
local function EncodeTable(Val, Stack)
    local Result = {}; --[[ 编码后的结果 ]]
    Stack = Stack or {}; --[[ 如果没有提供 Stack 则初始化为空 ]]

    --[[ 啥? 循环引用? ]]
    if (Stack[Val]) then
        error("circular reference");
    end

    Stack[Val] = true; --[[ 标记当前对象，防止循环引用 ]]

    --[[ 判断是否为数组（连续的数字索引），如果是则以数组方式编码 ]]
    if (rawget(Val, 1) ~= NULL or next(Val) == NULL) then
        local n = 0;
        for Key in pairs(Val) do --[[ 检查是否所有的 key 都是数字类型 ]]
            if (type(Key) ~= "number") then
                error("invalid table: mixed or invalid key types");
            end
            n = n + 1;
        end
        --[[ 如果数组的长度和实际的 key 数量不匹配，则报错（表示稀疏数组） ]]
        if (n ~= #Val) then
            error("invalid table: sparse array");
        end

        --[[ 编码数组 ]]
        for _, Value in ipairs(Val) do
            table.insert(Result, Encode(Value, Stack)); --[[ 将数组中的每个值编码 ]]
        end
        Stack[Val] = NULL; --[[ 移除引用 ]]
        return "[" .. table.concat(Result, ",") .. "]"; --[[ 将编码后的结果用方括号括起来形成 JSON 数组 ]]
    else
        --[[ 处理对象 ]]
        for Key, Value in pairs(Val) do
            if (type(Key) ~= "string") then
                error("invalid table: mixed or invalid key types"); --[[ 对象的键必须是字符串 ]]
            end
            --[[ 对每个键值对进行编码，并将结果加入到 Result 中 ]]
            table.insert(Result, Encode(Key, Stack) .. ":" .. Encode(Value, Stack));
        end
        Stack[Val] = NULL; --[[ 移除引用 ]]
        return "{" .. table.concat(Result, ",") .. "}"; --[[ 将编码后的结果用花括号括起来形成 JSON 对象 ]]
    end
end

--[[ 编码字符串 ]]
local function EncodeString(Val)
    return '"' .. Val:gsub('[%z\1-\31\\"]', EscapeChar) .. '"'; --[[ 对字符串中的特殊字符进行转义 ]]
end

--[[ 编码数字 ]]
local function EncodeNumber(Val)
    --[[ 检查是否为无效数字或无穷大 ]]
    if (Val ~= Val or Val <= -math.huge or Val >= math.huge) then
        error("unexpected number value '" .. tostring(Val) .. "'");
    end
    return string.format("%.14g", Val); --[[ 将数字转换为字符串格式 ]]
end

--[[ 简易工厂 ]]
local TypeFuncMap = {
    ["nil"] = EncodeNil, --[[ 空值 ]]
    ["table"] = EncodeTable, --[[ 对象 ]]
    ["string"] = EncodeString, --[[ 字符串 ]]
    ["number"] = EncodeNumber, --[[ 数字 ]]
    ["boolean"] = tostring, --[[ 布尔值 ]]
};

Encode = function(Val, Stack)
    local ValType = type(Val); --[[ 获取值类型 ]]
    local EncodeFunc = TypeFuncMap[ValType]; --[[ 根据值类型选择编码函数 ]]

    --[[ 确保是有效的 ]]
    if (EncodeFunc) then
        return EncodeFunc(Val, Stack);
    end

    --[[ 未知的类型 ]]
    error("unexpected type '" .. ValType .. "'") --[[ 扔出错误 ]]
end

---
--- 将传入的表(table)转换为JSON字符串
---
---[View documents](command:extension.lua.doc?["en-us/54/manual.html/pdf-table.concat"])
---
---@param Table table
---@return string
---@nodiscard 不支持缩进
function JsonDocument.Encode(Table)
    return Encode(Table);
end

-------------------------------------------------------------------------------
-- Decode
-------------------------------------------------------------------------------

local Parse

local function CreateSet(...)
    local Result = {};
    for Index = 1, select("#", ...) do
        Result[select(Index, ...)] = true;
    end
    return Result;
end

local SpaceChars  = CreateSet(" ", "\t", "\r", "\n");
local DelimChars  = CreateSet(" ", "\t", "\r", "\n", "]", "}", ",");
local EscapeChars = CreateSet("\\", "/", '"', "b", "f", "n", "r", "t", "u");
local Literals    = CreateSet("true", "false", "null");


local LiteralMap       =
{
    ["true"] = true,
    ["false"] = false,
    ["null"] = NULL,
};

local EscapeCharMapInv = { ["/"] = "/" };
for Key, Value in pairs(EscapeCharMap) do
    EscapeCharMapInv[Value] = Key;
end

--[[ 下一个Token ]]
local function NextChar(String, Index, Set, Negate)
    for i = Index, #String do
        if (Set[String:sub(i, i)] ~= Negate) then
            return i;
        end
    end
    return #String + 1;
end

--[[ 错误 ]]
local function DecodeError(String, Index, Msg)
    local LineCount = 1;
    local ColCount = 1;
    for i = 1, Index - 1 do
        ColCount = ColCount + 1;
        if (String:sub(i, i) == "\n") then
            LineCount = LineCount + 1;
            ColCount = 1;
        end
    end
    error(string.format("%s at line %d col %d", Msg, LineCount, ColCount));
end


local function CodepointToUtf8(n)
    -- http://scripts.sil.org/cms/scripts/page.php?site_id=nrsi&id=iws-appendixa
    local Func = math.floor;
    if (n <= 0x7f) then
        return string.char(n);
    elseif (n <= 0x7ff) then
        return string.char(Func(n / 64) + 192, n % 64 + 128);
    elseif (n <= 0xffff) then
        return string.char(Func(n / 4096) + 224, Func(n % 4096 / 64) + 128, n % 64 + 128);
    elseif (n <= 0x10ffff) then
        return string.char(Func(n / 262144) + 240, Func(n % 262144 / 4096) + 128,
            Func(n % 4096 / 64) + 128, n % 64 + 128);
    end
    error(string.format("invalid unicode codepoint '%x'", n));
end

--[[ 解析Unicode ]]
local function ParseUnicodeEscape(s)
    local n1 = tonumber(s:sub(1, 4), 16);
    local n2 = tonumber(s:sub(7, 10), 16);
    --[[ Surrogate pair? ]]
    if (n2) then
        return CodepointToUtf8((n1 - 0xd800) * 0x400 + (n2 - 0xdc00) + 0x10000);
    else
        return CodepointToUtf8(n1);
    end
end

--[[ 解析字符串 ]]
local function ParseString(String, Index)
    local Result = "";
    local j = Index + 1;
    local k = j;

    while (j <= #String) do
        local x = String:byte(j);

        if (x < 32) then
            DecodeError(String, j, "control character in string");
        elseif (x == 92) then --[[ `\`: 杠]]
            Result = Result .. String:sub(k, j - 1);
            j = j + 1;
            local Char = String:sub(j, j);
            if (Char == "u") then
                local Hex = (String:match("^[dD][89aAbB]%x%x\\u%x%x%x%x", j + 1) or String:match("^%x%x%x%x", j + 1) or
                    DecodeError(String, j - 1, "invalid unicode escape in string"));
                Result = Result .. ParseUnicodeEscape(Hex);
                j = j + #Hex;
            else
                if (not EscapeChars[Char]) then
                    DecodeError(String, j - 1, "invalid escape char '" .. Char .. "' in string");
                end
                Result = Result .. EscapeCharMapInv[Char];
            end
            k = j + 1;
        elseif (x == 34) then --[[ `"`: 字符串结束 ]]
            Result = Result .. String:sub(k, j - 1);
            return Result, j + 1;
        end

        j = j + 1;
    end

    DecodeError(String, Index, "expected closing quote for string");
end

--[[ 解析数字 ]]
local function ParseNumber(String, Index)
    local x = NextChar(String, Index, DelimChars);
    local s = String:sub(Index, x - 1);
    local n = tonumber(s);
    if (not n) then
        DecodeError(String, Index, "invalid number '" .. s .. "'");
    end
    return n, x;
end


local function ParseLiteral(String, Index)
    local x = NextChar(String, Index, DelimChars);
    local Word = String:sub(Index, x - 1);
    if (not Literals[Word]) then
        DecodeError(String, Index, "invalid literal '" .. Word .. "'");
    end
    return LiteralMap[Word], x;
end

--[[ 解析数组 ]]
local function ParseArray(String, Index)
    local Result = {};
    local n = 1;
    Index = Index + 1;
    while (true) do
        local x
        Index = NextChar(String, Index, SpaceChars, true);
        --[[ 空数组或者数组结束? ]]
        if (String:sub(Index, Index) == "]") then
            Index = Index + 1;
            break;
        end
        --[[ 读取Token ]]
        x, Index = Parse(String, Index);
        Result[n] = x;
        n = n + 1;
        --[[ 下一个Token ]]
        Index = NextChar(String, Index, SpaceChars, true);
        local Char = String:sub(Index, Index);
        Index = Index + 1;
        if (Char == "]") then
            break;
        end
        if (Char ~= ",") then
            DecodeError(String, Index, "expected ']' or ','");
        end
    end
    return Result, Index;
end

--[[ 解析对象 ]]
local function ParseObject(String, Index)
    local Result = {};
    Index = Index + 1;
    while (true) do
        local Key, Val;
        Index = NextChar(String, Index, SpaceChars, true);
        --[[ 空对象或者对象结束了? ]]
        if (String:sub(Index, Index) == "}") then
            Index = Index + 1;
            break;
        end
        --[[ 读取键 ]]
        if (String:sub(Index, Index) ~= '"') then
            DecodeError(String, Index, "expected string for Key");
        end
        Key, Index = Parse(String, Index);
        --[[ 读取`:`分隔符 ]]
        Index = NextChar(String, Index, SpaceChars, true);
        if (String:sub(Index, Index) ~= ":") then
            DecodeError(String, Index, "expected ':' after Key");
        end
        Index = NextChar(String, Index + 1, SpaceChars, true);
        --[[ 读取键的值 ]]
        Val, Index = Parse(String, Index);
        --[[ 设置键的值 ]]
        Result[Key] = Val;
        --[[ 下一个Token ]]
        Index = NextChar(String, Index, SpaceChars, true);
        local Char = String:sub(Index, Index);
        Index = Index + 1;
        if (Char == "}") then
            break;
        end
        if (Char ~= ",") then
            DecodeError(String, Index, "expected '}' or ','");
        end
    end
    return Result, Index;
end

--[[ 简易工厂 ]]
local CharFuncMap = {
    ['"'] = ParseString, --[[ 字符串 ]]
    ["0"] = ParseNumber, --[[ 数字 ]]
    ["1"] = ParseNumber, --[[ 数字 ]]
    ["2"] = ParseNumber, --[[ 数字 ]]
    ["3"] = ParseNumber, --[[ 数字 ]]
    ["4"] = ParseNumber, --[[ 数字 ]]
    ["5"] = ParseNumber, --[[ 数字 ]]
    ["6"] = ParseNumber, --[[ 数字 ]]
    ["7"] = ParseNumber, --[[ 数字 ]]
    ["8"] = ParseNumber, --[[ 数字 ]]
    ["9"] = ParseNumber, --[[ 数字 ]]
    ["-"] = ParseNumber, --[[ 数字 ]]
    ["t"] = ParseLiteral, --[[ true ]]
    ["f"] = ParseLiteral, --[[ false ]]
    ["n"] = ParseLiteral, --[[ num ]]
    ["["] = ParseArray, --[[ 数组 ]]
    ["{"] = ParseObject, --[[ 对象 ]]
};


Parse = function(String, Index)
    local Char = String:sub(Index, Index); --[[ 当前的字符串 ]]
    local DecodeFunc = CharFuncMap[Char]; --[[ 根据字符串选择解析函数 ]]

    --[[ 确保是有效的 ]]
    if (DecodeFunc) then
        return DecodeFunc(String, Index);
    end

    --[[ 啊? ]]
    DecodeError(String, Index, "unexpected character '" .. Char .. "'");
end

---
--- 将传入的JSON字符串转换为表(table)
---
---[View documents](command:extension.lua.doc?["en-us/54/manual.html/pdf-table.concat"])
---
---@param String string
---@return table
---@nodiscard
function JsonDocument.Decode(String)
    if (type(String) ~= "string") then
        error("expected argument of type string, got " .. type(String));
    end
    local Result, Index = Parse(String, NextChar(String, 1, SpaceChars, true));
    Index = NextChar(String, Index, SpaceChars, true);
    if (Index <= #String) then
        DecodeError(String, Index, "trailing garbage");
    end
    return Result;
end

-------------------------------------------------------------------------------

--[[ 返回模块的接口 ]]
return JsonDocument;
-------------------------------------------------------------------------------
