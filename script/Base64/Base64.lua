--[[
Author: xixi_
Date: 2024/8/14 01:29:57
LastEditors: xixi_
LastEditTime: 2026-02-17 14:55:29
FilePath: /MiniWorldScript/script/Base64/Base64.lua
Copyright (c) 2020-2026 by xixi_ , All Rights Reserved.
--]]

--------------------------------------------------------------------------------------------------------------------------
--[[
    编码字符串为 Base64 的函数
    参数：
        source_str - 待编码的字符串
    返回值：
        编码后的 Base64 字符串
--]]
local function encodeBase64(source_str)
    -- 定义 Base64 字符集
    local b64chars = { 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S',
        'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l',
        'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', '0', '1', '2', '3', '4',
        '5', '6', '7', '8', '9', '+', '/' }
    -- 初始化编码结果字符串
    local s64 = ''
    -- 将输入字符串赋值给局部变量 str
    local str = source_str

    -- 在 str 长度大于零的情况下循环执行
    while #str > 0 do
        -- 初始化字节计数和缓冲区
        local bytes_num = 0
        local buf = 0

        -- 处理每三个字节为一组
        for byte_cnt = 1, 3 do
            -- 将缓冲区左移 8 位
            buf = (buf * 256)
            -- 如果 str 长度大于零，则将 str 的第一个字符转换为 ASCII 码并添加到缓冲区
            if #str > 0 then
                buf = buf + string.byte(str, 1, 1)
                -- 移除 str 的第一个字符
                str = string.sub(str, 2)
                -- 增加字节计数
                bytes_num = bytes_num + 1
            end
        end

        -- 将每组数据编码成四个 Base64 字符
        for group_cnt = 1, (bytes_num + 1) do
            -- 计算缓冲区除以 262144（64^3）的余数，并加一（因为数组索引从一开始）
            local b64char = math.fmod(math.floor(buf / 262144), 64) + 1
            -- 将对应的 Base64 字符添加到结果字符串
            s64 = s64 .. b64chars[b64char]
            -- 将缓冲区左移 6 位
            buf = buf * 64
        end

        -- 在不足三个字节的情况下，补充等号（'='）
        for fill_cnt = 1, (3 - bytes_num) do
            s64 = s64 .. '='
        end
    end

    -- 返回编码后的字符串
    return s64
end
--------------------------------------------------------------------------------------------------------------------------
--[[ function math.pow(num1,num2)
  return num1^num2
end
--------------------------------------------------------------------------------------------------------------------------
function math.mod(num1,num2)
    return num1%num2
end ]]
--------------------------------------------------------------------------------------------------------------------------
--[[
    解码 Base64 字符串的函数
    参数：
        str64 - 待解码的 Base64 字符串
    返回值：
        解码后的字符串或 "nil"（如果解码失败）
--]]
local function decodeBase64(str64)
    -- 定义 Base64 字符集
    local b64chars = { 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S',
        'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l',
        'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', '0', '1', '2', '3', '4',
        '5', '6', '7', '8', '9', '+', '/' }

    -- 创建一个临时表，用于存储字符与其对应索引的映射关系
    local temp = {}
    for i = 1, 64 do
        temp[b64chars[i]] = i
    end
    -- 将等号 '=' 对应的索引设置为 0
    temp['='] = 0

    -- 初始化解码结果字符串
    local str = ""

    -- 每次处理4个字符为一组进行解码
    for i = 1, #str64, 4 do
        if i > #str64 then
            break -- 如果字符串长度不足4个字符，跳出循环
        end

        local data = 0      -- 存储解码后的数据
        local str_count = 0 -- 记录有效字符的数量

        -- 解析每组数据
        for j = 0, 3 do
            local str1 = string.sub(str64, i + j, i + j) -- 获取当前字符
            if not temp[str1] then
                return "nil"                             -- 如果字符不在 Base64 字符集内，返回 "nil"
            end

            if temp[str1] < 1 then
                data = data * 64                  -- 如果是填充字符 '='，则将数据左移6位（不累加）
            else
                data = data * 64 + temp[str1] - 1 -- 否则将数据左移6位并添加当前字符对应的值
                str_count = str_count + 1         -- 增加有效字符的数量
            end
        end

        -- 将解码后的数据转换为字节，并拼接到结果字符串中
        for j = 16, 0, -8 do
            if str_count > 0 then
                str = str .. string.char(math.floor(data / math.pow(2, j))) -- 取高位字节，并转换为字符
                data = math.mod(data, math.pow(2, j))                       -- 更新数据为低位字节
                str_count = str_count - 1                                   -- 减少有效字符的数量
            end
        end
    end

    local last = tonumber(string.byte(str, string.len(str), string.len(str))) -- 获取最后一个字符的 ASCII 值
    if last == 0 then
        str = string.sub(str, 1, string.len(str) - 1)                         -- 如果最后一个字符是空字符（ASCII 值为 0），则移除该字符
    end

    return str -- 返回解码后的字符串
end
--------------------------------------------------------------------------------------------------------------------------
