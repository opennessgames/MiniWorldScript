--[[
Author: xixi_
Date: 2026-02-17 18:01:42
LastEditors: xixi_
LastEditTime: 2026-02-17 18:04:19
FilePath: /MiniWorldScript/Script/JsonDocument/EncodeTest.lua
Copyright (c) 2020-2026 by xixi_ , All Rights Reserved.
--]] 

local JsonDocument = require("JsonDocument");

local table = {nil, nil, "s", "YanZiHaoFuckYou"};

print(JsonDocument.Encode(table));
