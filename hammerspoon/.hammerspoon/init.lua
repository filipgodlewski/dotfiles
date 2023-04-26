local eventtap = require("hs.eventtap")
local window = require("hs.window")
local hotkey = require("hs.hotkey")

local function keyPress(mods, key)
   return function()
      eventtap.event.newKeyEvent(mods, string.lower(key), true):post()
      eventtap.event.newKeyEvent(mods, string.lower(key), false):post()
   end
end

local function _bind(apps, on_focus, on_blur)
   on_blur()
   apps = apps or {}
   for _, app in ipairs(apps) do
      window.filter.new(app)
          :subscribe(window.filter.windowFocused, on_focus)
          :subscribe(window.filter.windowUnfocused, on_blur)
   end
end

local function bind(is_global, i_mods, i_key, o_mods, o_key, apps)
   local hk = hotkey.new(i_mods, i_key, keyPress(o_mods, o_key))
   local disable = function() hk:disable() end
   local enable = function() hk:enable() end
   if is_global then _bind(apps, disable, enable) else _bind(apps, enable, disable) end
end

local function lBind(i_mods, i_key, o_mods, o_key, enabled_apps)
   return bind(false, i_mods, i_key, o_mods, o_key, enabled_apps)
end

local function gBind(i_mods, i_key, o_mods, o_key, disabled_apps)
   return bind(true, i_mods, i_key, o_mods, o_key, disabled_apps)
end

-- Text editing
gBind({ "ctrl" }, "b", { "alt" }, "left", { "Alacritty" }) -- ctrl + B, go to the beginning of the provious word
gBind({ "ctrl" }, "f", { "alt" }, "right", { "Alacritty", "Citrix Viewer" }) -- ctrl + F, go to the beginning of the next word
gBind({ "ctrl" }, "u", { "cmd" }, "delete", { "Alacritty" }) -- ctrl + U, delete the whole line to the left
gBind({ "ctrl" }, "k", { "cmd" }, "forwarddelete", { "Alacritty" }) -- ctrl + K, delete the whole line to the right
gBind({ "ctrl" }, "w", { "alt" }, "delete", { "Alacritty", "Citrix Viewer" }) -- ctrl + W, delete the word to the left
