-- tmux 前缀（Ctrl+L）后的下一个键不进拼音，直接交给终端
-- 只在 squirrel.custom.yaml 的 app_options 里开了 tmux_prefix 的 App（Ghostty）生效
local tmux = {}

function tmux.func(key, env)
    local context = env.engine.context
    if key:release() or not context:get_option('tmux_prefix') then return 2 end -- kNoop
    if env.armed then
        env.armed = false
        return 0 -- kRejected：输入法不处理，按键原样交给终端
    end
    if key:repr() == 'Control+l' and not context:is_composing() then env.armed = true end
    return 2
end

return tmux
