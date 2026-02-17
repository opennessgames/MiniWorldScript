--[[
Author: xixi_
Date: 2023-3-18 18:57:46
LastEditors: xixi_
LastEditTime: 2026-02-17 14:53:37
FilePath: /MiniWorldScript/script/calc0/计算按钮.lua
Copyright (c) 2020-2026 by xixi_ , All Rights Reserved.
--]]

-- 计算按钮类属性
Calculate_Class = {button_id = [[7183546817928307101_30]]}

-- 计算按钮类计算方法
function Calculate_Class:Calculate(button_id, text)
    if (button_id == self.button_id) then
        local number_list = {}
        local operator_list = {}
        local text = text
        while (#text > 0) do
            if (string.find(text, "%d") == 1) then
                local startindex, endindex = string.find(text, "%d+")
                table.insert(number_list, string.sub(text, startindex, endindex))
                text = string.sub(text, endindex + 1)
            elseif (string.find(text, "%p") == 1) then
                local startindex, endindex = string.find(text, "%p")
                table.insert(operator_list,
                             string.sub(text, startindex, endindex))
                text = string.sub(text, endindex + 1)
            end
        end
        Chat:sendSystemMsg(table.concat(number_list, ","))
        Chat:sendSystemMsg(table.concat(operator_list, ","))
        local function is_incluble(tab, value)
            -- 函数体
            for k, v in pairs(tab) do
                -- 循环体
                if v == value then
                    -- 如果条件为真的执行体
                    return true
                end
            end
            return false
        end
        -- 乘除
        while (is_incluble(operator_list, "*") or
            (is_incluble(operator_list, "/"))) do
            -- 循环直到val为假
            for i = 1, #operator_list do
                -- 循环体
                if (operator_list[i] == "*") then
                    number_list[i] = number_list[i] * number_list[i + 1]
                    table.remove(operator_list, i)
                    table.remove(number_list, i + 1)
                    break
                    -- 如果条件为真的执行体
                elseif (operator_list[i] == "/") then
                    number_list[i] = number_list[i] / number_list[i + 1]
                    table.remove(operator_list, i)
                    table.remove(number_list, i + 1)
                    break
                end
            end
        end
        -- 加减
        while (#operator_list ~= 0) do
            -- 循环直到val为假
            if (operator_list[1] == "+") then
                -- 如果条件为真的执行体
                number_list[1] = number_list[1] + number_list[1 + 1]
                table.remove(operator_list, 1)
                table.remove(number_list, 2)
            elseif (operator_list[1] == "-") then
                -- 如果条件为假的执行体
                number_list[1] = number_list[1] - number_list[1 + 1]
                table.remove(operator_list, 1)
                table.remove(number_list, 2)
            end
        end
        -- 返回计算结果
        return tostring(number_list[1])
    end
end

-- 计算按钮类构造函数
function Calculate_Class:New(attr)
    local tab = {}
    for k, v in pairs(self) do
        if (attr and attr[k]) then
            tab[k] = attr[k]
        else
            tab[k] = v
        end
    end
    return tab
end
