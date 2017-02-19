local meter = KEYS[1]
local total = KEYS[2]
local progress = KEYS[3]

local total_key = "meter_total:::" .. meter
local progress_key  = "meter_progress:::" .. meter

if redis.call("EXISTS", total_key) == 1 then
  return "already exists"

else
  redis.call("SET", total_key, total)
  redis.call("SET", progress_key, progress)
  return "ok"
end
