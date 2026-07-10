-- 简繁同列：在每个候选后追加其繁体版本（若与简体不同），简繁均可选，无需切换。
-- 使用 Rime 内置 OpenCC 配置 s2t.json（通用/香港繁体）。
-- 如需台湾繁体，把 s2t.json 改为 s2tw.json（或 s2twp.json 含词汇转换）。
local M = {}

function M.init(env)
    env.opencc = Opencc("s2t.json")
end

function M.func(input, env)
    local opencc = env.opencc
    for cand in input:iter() do
        yield(cand)
        local trad = opencc and opencc:convert(cand.text)
        if trad and trad ~= cand.text then
            yield(ShadowCandidate(cand, cand.type, trad, cand.comment))
        end
    end
end

return M
