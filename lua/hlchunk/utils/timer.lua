local M = {}
local uv = vim.loop

---@param fn function The function to be called after the delay
---@param delay number The delay in milliseconds
---@vararg any The arguments to be passed to the function
---@return uv_timer_t | nil
function M.setTimeout(fn, delay, ...)
    local timer = uv.new_timer()
    if not timer then
        return nil
    end
    local arg = { ... }
    timer:start(delay, 0, function()
        vim.schedule(function()
            fn(unpack(arg))
        end)
    end)
    return timer
end

---@param fn function The function to be called after the interval
---@param interval number The interval in milliseconds
---@vararg any The arguments to be passed to the function
---@return uv_timer_t | nil
function M.setInterval(fn, interval, ...)
    local timer = uv.new_timer()
    if not timer then
        return nil
    end
    local arg = { ... }
    timer:start(interval, interval, function()
        vim.schedule(function()
            fn(unpack(arg))
        end)
    end)
    return timer
end

return M
