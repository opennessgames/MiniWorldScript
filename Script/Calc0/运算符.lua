--[[
Author: xixi_
Date: 2023-3-18 18:57:12
LastEditors: xixi_
LastEditTime: 2026-02-17 15:15:10
FilePath: /MiniWorldScript/script/calc0/运算符.lua
Copyright (c) 2020-2026 by xixi_ , All Rights Reserved.
--]]

Operator_Class = {
    operator_key = {
        {id = "7183546817928307101_32", text = "+"},
        {id = "7183546817928307101_34", text = "-"},
        {id = "7183546817928307101_36", text = "*"},
        {id = "7183546817928307101_38", text = "/"}
    }
};

function Operator_Class:Output(button_id)
    for k, v in pairs(self.operator_key) do
        if v.id == button_id then return v.text; end
    end
end

function Operator_Class:New(attr)
    local tab = {};
    for k, v in pairs(self) do
        if attr and attr[k] then
            tab[k] = attr[k];
        else
            tab[k] = v;
        end
    end
    return tab;
end
