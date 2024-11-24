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

local MODULE_LIST = { 'zsh', 'resources' }

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

local install_module = function (module_name, local_dir)
  local install_script_path
  if local_dir then
    install_script_path = './modules/' .. module_name .. '/_INSTALL.lua'
  else
    install_script_path = UPDATER_PATH .. '/modules/' .. module_name .. '/_INSTALL.lua'
  end

  local chunk, err = loadfile(install_script_path)
  if err or not chunk then
    print('Failed to load the install script for module ' .. module_name .. '!')
    print(err)
    os.exit(1)
  end

  local PRE_INSTALL, INSTALL, POST_INSTALL = chunk()

  if not PRE_INSTALL or not INSTALL or not POST_INSTALL then
    print('The install script for module ' .. module_name .. ' is invalid!')
    os.exit(1)
  end

  local log_fn = function (...)
    io.stdout:write('  ' .. module_name .. ': ' .. table.concat({...}, ' ') .. '\n')
  end

  local utils = {
    is_command_available = is_command_available,
    exists = function (path)
      local file = io.open(path, 'r')

      if not file then
        return false
      end

      file:close()

      return true
    end,
    module_dir = local_dir and './modules/' .. module_name or UPDATER_PATH .. '/modules/' .. module_name,
  }

  print()
  print('Running pre-install for module "' .. module_name .. '" ...')
  local pre_install_status = PRE_INSTALL(log_fn, utils)

  if not pre_install_status then
    print('Pre-install for module "' .. module_name .. '" failed!')
    os.exit(1)
  end

  print('Running install for module "' .. module_name .. '" ...')
  local install_status = INSTALL(log_fn, utils)

  if not install_status then
    print('Install for module "' .. module_name .. '" failed!')
    os.exit(1)
  end

  print('Running post-install for module "' .. module_name .. '" ...')
  local post_install_status = POST_INSTALL(log_fn, utils)

  if not post_install_status then
    print('Post-install for module "' .. module_name .. '" failed!')
    os.exit(1)
  end
  print()
end

for _, module_name in ipairs(MODULE_LIST) do
  install_module(module_name, false)
end

print('Finished installing modules!')
