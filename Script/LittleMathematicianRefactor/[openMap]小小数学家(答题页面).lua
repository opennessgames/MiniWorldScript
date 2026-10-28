--[[
Author: xixi_
Date: 2026-09-23 12:39:39
LastEditors: xixi_
LastEditTime: 2026-09-23 12:39:41
FilePath: /xiningyouxiduan-opengame/private/[openMAP]小小数学家.lua
Copyright (c) 2017-2026 by xixi_ , All Rights Reserved.
--]]

local Script = {}

--属性定义
Script.propertys = {
}

-- 需要开放给别的组件访问的函数需要配置
Script.openFnArgs = {
    --[[
    -- 函数开放配置示例
    Add = {
            returnType = Mini.Number,   -- 返回值（不填则为无返回值）
            displayName = "函数别名",   -- 代码块上显示的别名（不填缺省则显示函数名）
            params = {Mini.Number, Mini.Number},-- 参数列表类型（不填则为无参数）
        },
    ]]
}

-- 组件启动时调用
function Script:OnStart()

    -- 监听UI按钮点击事件(元件id, 元件id不填则是监听该界面的全部按钮点击)
    -- self:AddTriggerEvent(TriggerEvent.UIButtonClick, self.OnUIButtonClick, "元件id")

    -- 监听触发器事件 玩家点击方块事件
    -- self:AddTriggerEvent(TriggerEvent.PlayerClickBlock, self.OnPlayerClickBlock)

    -- 监听自定义事件
    -- self:AddCustomEvent("msgui123", self.OnCustomEvent)

    -- 键盘事件监听,快捷键w监听,(不传入第三个参数KeyCode.W,则是同时监听其他键盘）
    -- self:AddTriggerEvent(TriggerEvent.PlayerInputKeyDown, self.OnKeyW, KeyCode.W)
    

    --[[
    -- 启动定时器， 5秒后执行1次
    self:DoTaskInTime(function ()
        print("定时器执行")
    end, 5)
    ]]

    --[[
    -- 启动定时器， 5秒后开始执行, 每3秒执行1次, 执行10次(不填默认无限次)
    local task = self:DoPeriodicTask(self.OnPeriodicTask, 3, 5, 10)

    --task:Pause()    -- 暂停定时器
    --task:Resume()   -- 恢复定时器
    --task:Cancel()   -- 取消定时器
    ]]
end

function Script:OnUIButtonClick(event)
    print("ui组件按钮点击事件")
end


function Script:OnPlayerClickBlock(event)
    -- 点击的方块玩家， 点击的方块类型
    -- event.eventobjid, event.blockid

    -- 在点击的位置上方创建嘟嘟鸟1只
    local objs = GameObject:CreatePrefab(ObjType.Mob, 3400, event.x, event.y + 1, event.z)
    if objs and objs[1] then
        -- 操作对象上组件示例(官方组件有api接口的可以直接用api操作)
        local hpCmp = objs[1]:GetComponent("HP") -- 获取血量组件
        if hpCmp then
            hpCmp.hp = 120 -- 设置血量
        end

        -- 接口操作示例
        Actor:SetAttr(objs[1]:GetId(), RoleAttr.CurHp, 120)
        
    end

    -- 发送自定义事件示例
    self:PushCustomEvent("msg123", 1, 2, 3)
end

function Script:OnCustomEvent(event, arg1, arg2, arg3)
    --输出到调试窗口日志
    print("收到msgui123广播 ", arg1, arg2, arg3)
end

function Script:OnKeyW()
    print("ui组件按下快捷键w")
end

function Script:OnPeriodicTask()
    print("定时器执行")
end

-- 函数定义示例
--[[
function Script:Add(a, b)
    if a and b then
        return a + b
    end
end
]]

return Script
