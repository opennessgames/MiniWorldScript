--[[
Author: xixi_
Date: 2026-10-28 23:39:42
LastEditors: xixi_
LastEditTime: 2026-10-28 23:39:44
FilePath: /MiniWorldScript/Script/LittleMathematicianRefactor/Demo.lua
Copyright (c) 2017-2026 by xixi_ , All Rights Reserved.
--]]

--[[ 使用方法 ]]
local Problem = require("libSimpleMathProblem"); --[[ 创建出题对象 ]]

Problem:SetLevel(1); --[[ 调节难度 ]]

--[[ 
    获取一道新题 
    返回的表里有三个元素，
    索引1的元素是一个数字
    索引2的元素是操作符
    索引3的元素是第二个数字
]]
local Table = Problem:GetProblem(); 

------- N数    运算符号(+-*/)    被N数
print(Table[1] .. Table[2] .. Table[3] .. "=" .. "?");

--[[ 获取玩家的答案 ]]
local PlayerAnswer = io.read("*n");

--[[ 检查 ]]
if (Problem:CheckAnswer(PlayerAnswer))then
    print("很好，你回答对了");
else
    print("很遗憾，回答错误，继续加油！");
end
