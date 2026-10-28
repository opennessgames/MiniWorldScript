--[[
Author: xixi_
Date: 2026-09-24 19:21:30
LastEditors: xixi_
LastEditTime: 2026-10-28 23:12:05
FilePath: /MiniWorldScript/Script/LittleMathematicianRefactor/[openMap]小小数学家(主页面).lua
Copyright (c) 2017-2026 by xixi_ , All Rights Reserved.
--]]

local Script = {};

--[[ 属性定义 ]]
Script.propertys = {};

--[[ 需要开放给别的组件访问的函数需要配置 ]]
Script.openFnArgs = {};

--[[ 组件启动时调用 ]]
function Script:OnStart()
    --[[ 连接信号槽 ]]
    --[[ 开始按钮 ]]
    self:AddTriggerEvent(TriggerEvent.UIButtonClick, self.OnStartButtonClick, "7688369842520661622-111018_6")
end

function Script:OnStartButtonClick(Event)
    --[[ 关闭掉开始页面 ]]
    local bool = CustomUI:DeleteElement(playerid, uiid, elementid)
end

return Script;
