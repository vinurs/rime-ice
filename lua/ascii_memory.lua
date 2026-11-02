-- 鼠须管切窗口 / 标签会销毁再新建会话，新会话默认中文：记住最后一次中英状态，新会话沿用
-- 状态存在模块里，librime-lua 各会话共用一个 Lua 环境，所以跨会话有效（重新部署后清零）
local M = { last = nil }

function M.init(env)
    local context = env.engine.context
    if M.last ~= nil then context:set_option('ascii_mode', M.last) end
    env.conn = context.option_update_notifier:connect(function(ctx, name)
        if name == 'ascii_mode' then M.last = ctx:get_option('ascii_mode') end
    end)
end

function M.fini(env)
    env.conn:disconnect()
end

function M.func()
    return 2 -- kNoop
end

return M
