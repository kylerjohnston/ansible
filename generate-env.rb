#!/usr/bin/env ruby

env_vars = {
  'SES_SMTP_USER' => { 'field' => 'username', 'name' => 'SES SMTP muumuus' },
  'SES_SMTP_PASSWORD' => {
    'field' => 'password', 'name' => 'SES SMTP muumuus'
  },
  'SPOTIFY_PASSWORD' => { 'field' => 'password', 'name' => 'spotify.com' },
  'MOPIDY_SPOTIFY_CLIENT_ID' => {
    'field' => 'username', 'name' => 'Mopidy Spotify'
  },
  'MOPIDY_SPOTIFY_CLIENT_SECRET' => {
    'field' => 'password', 'name' => 'Mopidy Spotify'
  },
  'LASTFM_PASSWORD' => { 'field' => 'password', 'name' => 'Last.fm' }
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
  f.puts "#{var}='#{value}'"
end

File.chmod(0770, env_file)
f.close
