--[[
Author: xixi_
Date: 2023-3-18 18:55:12
LastEditors: xixi_
LastEditTime: 2026-02-17 14:54:47
FilePath: /MiniWorldScript/script/calc0/显示屏.lua
Copyright (c) 2020-2026 by xixi_ , All Rights Reserved.
--]]

-- 显示屏类属性
Screen_Class =
{
    text = "",
    text_id = [[7183546817928307101_7]],
    playerid = 0,
    uiid = [[7183546817928307101]]
}

-- 显示屏类刷新方法
function Screen_Class:Refresh()
    local playerid = self.playerid
    local uiid = self.uiid
    local elementid = self.text_id
    local text = self.text
    result = Coustomui:setText(playerid, uiid, elementid, text)
end

-- 显示屏类构造函数
function Screen_Class:New(attr)
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