 function keyPress(mods, key)
   return function()
      hs.eventtap.event.newKeyEvent(mods, string.lower(key), true):post()
      hs.eventtap.event.newKeyEvent(mods, string.lower(key), false):post()
   end
end

local function _bind(apps, on_focus, on_blur)
   on_blur()
   apps = apps or {}
   for _, app in ipairs(apps) do
      hs.window.filter.new(app)
         :subscribe(hs.window.filter.windowFocused, on_focus)
         :subscribe(hs.window.filter.windowUnfocused, on_blur)
   end
end

local function bind(is_global, i_mods, i_key, o_mods, o_key, apps)
   local hk = hs.hotkey.new(i_mods, i_key, keyPress(o_mods, o_key))
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

C = {'ctrl'}
C_c = {'ctrl', 'cmd'}
C_S = {'ctrl', 'shift'}
C_a = {'ctrl', 'alt'}
c = {'cmd'}
a = {'alt'}
S = {'shift'}
H = {'alt', 'shift', 'ctrl', 'cmd'}

-- System keys

gBind(C, 'm', nil, 'return', {'Alacritty'}) -- ctrl + M, return
gBind(C, '[', nil, 'escape', {'Alacritty'}) -- ctrl + [, escape
gBind(C, 'h', nil, 'delete') -- ctrl + H, backspace
gBind(C, 'd', nil, 'forwarddelete', {'Alacritty'}) -- ctrl + D, forward delete
lBind(C_S, '/', nil, 'forwarddelete', {'Alacritty'}) -- ctrl + shift + /, forward delete, but only in Alacritty (terminal)
gBind(C, 'i', nil, 'tab') -- ctrl + I, tab

-- Text editing

gBind(C, 'a', c, 'left', {'Alacritty', 'Citrix Viewer'}) -- ctrl + A, go to the beginning of line
gBind(C, 'e', c, 'right', {'Alacritty'}) -- ctrl + E, go to the end of line
gBind(C, 'b', a, 'left', {'Alacritty'}) -- ctrl + B, go to the beginning of the provious word
gBind(C, 'f', a, 'right', {'Alacritty', 'Citrix Viewer'}) -- ctrl + F, go to the beginning of the next word
gBind(C, 'u', c, 'delete', {'Alacritty'}) -- ctrl + U, delete the whole line to the left
gBind(C, 'k', c, 'forwarddelete', {'Alacritty'}) -- ctrl + K, delete the whole line to the right
gBind(C, 'w', a, 'delete', {'Alacritty', 'Citrix Viewer'}) -- ctrl + W, delete the word to the left

