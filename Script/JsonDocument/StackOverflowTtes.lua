--[[
Author: xixi_
Date: 2026-02-18 03:06:53
LastEditors: xixi_
LastEditTime: 2026-02-18 03:08:03
FilePath: /MiniWorldScript/Script/JsonDocument/StackOverflow.lua
Copyright (c) 2020-2026 by xixi_ , All Rights Reserved.
--]]

--[[ 
    输出: false   ./JsonDocument.lua:136: stack overflow 
    测试结果: 不通过, 回炉重造
]]

local JsonDocument = require("JsonDocument")

local BigTable = {};
local TmpBigTable = BigTable;
for i = 1, 1000000, 1 do --[[ 压力起来!!! ]]
    TmpBigTable.Child = {};
    TmpBigTable = TmpBigTable.Child;
end

local Ok, Err = pcall(JsonDocument.Encode, BigTable);
print(Ok, Err);