#!/usr/bin/env ruby

env_vars = {
  'SES_SMTP_USER' => {'field' => 'username', 'name' => 'SES SMTP muumuus'},
  'SES_SMTP_PASSWORD' => {'field' => 'password', 'name' => 'SES SMTP muumuus'}
}

email = 'kylerjohnston@gmail.com'
env_file = '.env'

if `lpass status`.include?('Not')
  system('lpass', 'login', email)
end

f = File.open(env_file, 'w')
f.puts 'DOTENV=True'

env_vars.each_key do |var|
  value = `lpass show --#{env_vars[var]['field']} "#{env_vars[var]['name']}"`
  f.puts "#{var}=#{value}"
end

File.chmod(0770, env_file)
f.close
