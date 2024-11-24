if _VERSION < 'Lua 5.4' then
  print('You need Lua 5.4 or later to run this script!')
  os.exit(1)
end

local is_command_available = function (command_name)
  local handle = io.popen('which ' .. command_name .. ' > /dev/null 2>&1; echo $?')

  if not handle then
    return false
  end

  local result = handle:read("*a")

  handle:close()

  return tonumber(result) == 0
end

if not is_command_available('git') then
  print('You need to install git!')
  os.exit(1)
end

local UPDATER_REPOSITORY = 'isrcalebe/dotfiles'
local UPDATER_BRANCH = 'main'
local UPDATER_PATH = '/tmp/dotfiles'

local cmd_clone = 'git clone https://github.com/' .. UPDATER_REPOSITORY .. ' --branch ' .. UPDATER_BRANCH .. ' --single-branch ' .. UPDATER_PATH
local cmd_clone_handle = io.popen(cmd_clone .. ' 2>&1')

if not cmd_clone_handle then
  print('Failed to clone the updater repository!')
  os.exit(1)
end

local cmd_clone_output = cmd_clone_handle:read("*a")
local cmd_clone_success = cmd_clone_handle:close()

if not cmd_clone_success then
  print('Failed to clone the updater repository!')
  print(cmd_clone_output)
  os.exit(1)
end

print('Cloned the updater repository successfully!')
