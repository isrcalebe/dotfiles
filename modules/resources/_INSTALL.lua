local PRE_INSTALL = function (log, utils)
  local timestamp = os.date('%Y%m%d%H%M%S')

  local git_config_backup_path = os.getenv('HOME') .. '/.gitconfig.' .. timestamp
  local gpg_backup_path = os.getenv('HOME') .. '/.gnupg/gpg.conf.' .. timestamp
  local gpg_agent_backup_path = os.getenv('HOME') .. '/.gnupg/gpg-agent.conf.' .. timestamp

  if utils.exists(os.getenv('HOME') .. '/.gitconfig') then
    os.execute('mv ' .. os.getenv('HOME') .. '/.gitconfig ' .. git_config_backup_path)
    log('Backed up the current .gitconfig file to ' .. git_config_backup_path)
  end

  if utils.exists(os.getenv('HOME') .. '/.gnupg/gpg.conf') then
    os.execute('mv ' .. os.getenv('HOME') .. '/.gnupg/gpg.conf ' .. gpg_backup_path)
    log('Backed up the current gpg.conf file to ' .. gpg_backup_path)
  end

  if utils.exists(os.getenv('HOME') .. '/.gnupg/gpg-agent.conf') then
    os.execute('mv ' .. os.getenv('HOME') .. '/.gnupg/gpg-agent.conf ' .. gpg_agent_backup_path)
    log('Backed up the current gpg-agent.conf file to ' .. gpg_agent_backup_path)
  end

  return true
end
local INSTALL = function (log, utils)
  log('Installing .gitconfig file...')
  os.execute('cp ' .. utils.module_dir .. '/gitconfig ' .. os.getenv('HOME') .. '/.gitconfig')

  if not utils.exists(os.getenv('HOME') .. '/.gnupg') then
    os.execute('mkdir -p ' .. os.getenv('HOME') .. '/.gnupg')
  end

  log('Installing gpg.conf and gpg-agent.conf files...')
  os.execute('cp ' .. utils.module_dir .. '/gnupg/gpg.conf ' .. os.getenv('HOME') .. '/.gnupg/gpg.conf')
  os.execute('cp ' .. utils.module_dir .. '/gnupg/gpg-agent.conf ' .. os.getenv('HOME') .. '/.gnupg/gpg-agent.conf')

  return true
end
local POST_INSTALL = function (log, utils)
  log('Reloading the gpg-agent')
  os.execute('gpgconf --kill gpg-agent')

  return true
end

return PRE_INSTALL, INSTALL, POST_INSTALL
