--[[
Author: xixi_
Date: 2026-02-17 18:07:08
LastEditors: xixi_
LastEditTime: 2026-02-17 18:07:44
FilePath: /MiniWorldScript/Script/JsonDocument/EncodeTest2.lua
Copyright (c) 2020-2026 by xixi_ , All Rights Reserved.
--]] 

local JsonDocument = require("JsonDocument");

local Table = {
    Name = "xixi_",
    Age = 114,
    City = "openGAME",
    s = {"s", "YanZiHaoFuckYou"},
    t = {"abcde", "哈拉少不哈拉少"}
}

print(JsonDocument.Encode(Table));

