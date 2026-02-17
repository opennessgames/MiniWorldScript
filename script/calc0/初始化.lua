--[[
Author: xixi_
Date: 2023-3-18 18:58:02
LastEditors: xixi_
LastEditTime: 2026-02-17 14:53:19
FilePath: /MiniWorldScript/script/calc0/初始化.lua
Copyright (c) 2020-2026 by xixi_ , All Rights Reserved.
--]]

player_list = {}

-- 有玩家进入游戏时运行
local function Game_AnyPlayer_EnterGame(event)
    local uin = event.eventobjid
    local uiid = [[7183546817928307101]]
    Player:openUIView(uin,uiid)
    -- 初始化显示屏对象
    local attr = {playerid = uin}
    local screen_obj = Screen_Class:New(attr)
    screen_obj:Refresh()
    -- 初始化数字按钮对象
    local numkey_obj = Number_Class:New()
    -- 初始化运算符按钮对象
    local operakey_obj = Operator_Class:New()
    -- 初始化删除按钮对象
    local backspace_obj = Backspace_Class:New()
    -- 初始化计算对象
    local calculate_obj = Calculate_Class:New()
    -- 初始化玩家对象
    local attr =
    {
        playerid = uin,
        screen_obj = screen_obj,
        numkey_obj = numkey_obj,
        operakey_obj = operakey_obj,
        backspace_obj = backspace_obj,
        calculate_obj = calculate_obj
    }
    local player_obj = Player_Class:New(attr)
    table.insert(player_list, player_obj)
end

-- 注册有玩家进入游戏监听器
ScriptSupportEvent:registerEvent([=[Game.AnyPlayer.EnterGame]=], Game_AnyPlayer_EnterGame)