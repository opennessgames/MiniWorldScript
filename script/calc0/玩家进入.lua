--[[
Author: xixi_
Date: 2023-3-18 18:58:36
LastEditors: xixi_
LastEditTime: 2026-02-17 14:54:30
FilePath: /MiniWorldScript/script/calc0/玩家进入.lua
Copyright (c) 2020-2026 by xixi_ , All Rights Reserved.
--]]

-- 玩家类属性
Player_Class =
{
    playerid = 0,
    screen_obj = {},
    numkey_obj = {},
    operakey_obj = {},
    backspace_obj = {},
    calculate_obj = {}
}

-- 玩家类构造函数
function Player_Class:New(attr)
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