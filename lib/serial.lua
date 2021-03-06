local ffi = require"ffi"
local S = require"lib.ljsyscall"
local U = require"lib.util"

local serial = {}

function serial.open(dev)
  local s = {}
  s.fd = U.assert(S.open(dev, "rdwr"))
  return setmetatable(s, {__index=serial})
end

function serial:set_baud(baud)
  local t = assert(self.fd:tcgetattr())
  t.speed = baud
  t:makeraw()
  self.fd:tcsetattr("now", t)
end

return serial
