local PRE_INSTALL = function (log, utils)
  if not utils.is_command_available('zsh') then
    log('zsh is not installed!')
    return false
  end

  local timestamp = os.date('%Y%m%d%H%M%S')
  local backup_file = os.getenv('HOME') .. '/.zshrc.' .. timestamp

  os.execute('mv ' .. os.getenv('HOME') .. '/.zshrc ' .. backup_file)
  os.execute('touch ' .. os.getenv('HOME') .. '/.zshrc')

  log('Backed up the current .zshrc file to ' .. backup_file)

  local zsh_dir = os.getenv('HOME') .. '/.config/zsh'
  os.execute('mkdir -p ' .. zsh_dir)

  log('Created ' .. zsh_dir)

  return true
end
local INSTALL = function (log, utils)
  local zsh_dir = os.getenv('HOME') .. '/.config/zsh'
  os.execute('cp -r ' .. utils.module_dir .. '/* ' .. zsh_dir)
  os.execute('rm ' .. zsh_dir .. '/_INSTALL.lua')

  log('Copied all files from ' .. utils.module_dir .. ' to ' .. zsh_dir)

  local zshrc_file = os.getenv('HOME') .. '/.zshrc'
  local line = 'source "$HOME/.config/zsh/init.zsh"'

  local file = io.open(zshrc_file, 'a')

  if file == nil then
    log('Failed to open ' .. zshrc_file)
    return false
  end

  file:write(line .. '\n')
  file:close()

  return true
end
local POST_INSTALL = function (log, utils)
  log('Sourcing the new .zshrc file')
  os.execute('zsh -c "source $HOME/.zshrc"')

  return true
end

return PRE_INSTALL, INSTALL, POST_INSTALL
