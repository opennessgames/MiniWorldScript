--[[
Author: xixi_
Date: 2026-09-24 18:04:13
LastEditors: xixi_
LastEditTime: 2026-09-24 18:05:57
FilePath: /xiningyouxiduan-opengame/private/libSimpleMathProblem.lua
Copyright (c) 2017-2026 by xixi_ , All Rights Reserved.
--]] 

--[[ TODO: UpdateProblem/GetProblem/CheckAnswer三流程 ]]

---------
math.randomseed(tonumber(tostring(os.time()):reverse():sub(1, 6)));
math.random(); --[[ 预热 ]]

---------------------------

local MilkshakeSimpleMathProblem = {};
MilkshakeSimpleMathProblem.__index = MilkshakeSimpleMathProblem;

--[[
    难度配置表 
    简单模式： 只有加法和减法，范围是10以内的
    中等模式：只有加法，减法和乘法，范围是0～50
    困难模式：四则运算（加减乘除），范围是10～100
    炼狱模式：四则运算（加减乘除），范围是50～99
]]
MilkshakeSimpleMathProblem.DifficultyConfig = {{
    Name = "简单",
    Min = 1,
    Max = 10,
    OperationList = {'+', '-'}
}, {
    Name = "中等",
    Min = 1,
    Max = 50,
    OperationList = {'+', '-', '*'}
}, {
    Name = "困难",
    Min = 10,
    Max = 100,
    OperationList = {'+', '-', '*', '/'}
}, {
    Name = "炼狱",
    Min = 50,
    Max = 999,
    OperationList = {'+', '-', '*', '/'}
}};

function MilkshakeSimpleMathProblem:New()
    local Obj = {};
    setmetatable(Obj, MilkshakeSimpleMathProblem);
    Obj.Level = 1; --[[ 难度等级 ]]
    Obj.NumberA = nil; --[[ 第一个数字 ]]
    Obj.Operation = ""; --[[ 运算符 ]]
    Obj.NumberB = nil; --[[ 第二个数字 ]]
    Obj.Answer = nil; --[[ 默认没有答案 ]]
    return Obj;
end

function MilkshakeSimpleMathProblem:SetLevel(Level)
    self.Level = math.max(1, math.min(Level, 4)); --[[ 钳位设置 ]]
    --[[ self:Update(); ]]
end

function MilkshakeSimpleMathProblem:Update()
    --[[ 刷新状态 ]]
    self.NumberA = nil;
    self.Operation = ""; 
    self.NumberB = nil; 
    self.Answer = nil;
end

--[[ 获取题目 ]]
function MilkshakeSimpleMathProblem:GetProblem()
    --[[ 拿到难度配置 ]]
    local Config = MilkshakeSimpleMathProblem.DifficultyConfig[self.Level];
    local OperationList = Config.OperationList;

    --[[ 随机运算符 ]]
    self.Operation = OperationList[math.random(#OperationList)];

    --[[ 除法特殊处理，结果只能是整数，不能有小数 ]]
    if (self.Operation == '/') then --[[ 写这一块我CPU烧了 :\ ]]
        --[[ 除数最大不能超过 Max/2，否则商最小为 Min 时被除数会超出 Max ]]
        local MaxDivisor = math.floor(Config.Max / 2);
        if MaxDivisor < 2 then
            MaxDivisor = 2
        end --[[ 防止 Max 太小导致范围无效 ]]

        self.NumberB = math.random(2, MaxDivisor);

        --[[ 商的最大值：保证 被除数 = NumberB × Quotient ≤ Config.Max ]]
        local MaxQuotient = math.floor(Config.Max / self.NumberB);
        if MaxQuotient < Config.Min then
            MaxQuotient = Config.Min
        end

        local Quotient = math.random(Config.Min, MaxQuotient);

        -- 反推被除数，绝对整除
        self.NumberA = self.NumberB * Quotient;
    else
        --[[ N数随机 ]]
        self.NumberA = math.random(Config.Min, Config.Max);
        --[[ 被N数随机 ]]
        self.NumberB = math.random(Config.Min, Config.Max);
    end

    local ProblemTable = {self.NumberA, self.Operation, self.NumberB};
    MilkshakeSimpleMathProblem:CalculateAnswer(ProblemTable); --[[ 更新答案 ]]
    return ProblemTable;
end

--[[ 计算答案 ]]
function MilkshakeSimpleMathProblem:CalculateAnswer(Problem)
    if (Problem[2] == "+") then
        self.Answer = Problem[1] + Problem[3];
    elseif (Problem[2] == "-") then
        self.Answer = Problem[1] - Problem[3];
    elseif (Problem[2] == "*") then
        self.Answer = Problem[1] * Problem[3];
    elseif (Problem[2] == "/") then
        self.Answer = Problem[1] / Problem[3];
    end
end

--[[ 获取正确的答案 ]]
function MilkshakeSimpleMathProblem:GetAnswer(PlayerAnswer)
    return self.Answer;
end

--[[ 检查玩家的答案 ]]
function MilkshakeSimpleMathProblem:CheckAnswer(PlayerAnswer)
    return self.Answer == PlayerAnswer;
end

----------------------------------------------------------------------------------------

return MilkshakeSimpleMathProblem;