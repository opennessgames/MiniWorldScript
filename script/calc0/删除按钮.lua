--[[
Author: xixi_
Date: 2023-3-18 18:57:28
LastEditors: xixi_
LastEditTime: 2026-02-17 14:53:49
FilePath: /MiniWorldScript/script/calc0/删除按钮.lua
Copyright (c) 2020-2026 by xixi_ , All Rights Reserved.
--]]

-- 删除按钮类属性
Backspace_Class =
{
    button_id = [[7183546817928307101_26]],
}

-- 删除按钮类删除方法
function Backspace_Class:Backspace(button_id, text)
    if(button_id == self.button_id)
    then
        return string.sub(text, 1, #text - 1)
    else
        return text
    end
end

-- 删除按钮类构造函数
function Backspace_Class:New(attr)
    local tab = {}
    for k,v in pairs(self)
    do
        if(attr and attr[k])
        then
            tab[k] = attr[k]
        else
            tab[k] = v
        end
    end
    return tab
end