#!/usr/bin/env ruby
# frozen_string_literal: true

require 'date'
require 'English'

help_message = <<~EOF
  borg_check.rb - Prints the days since last borg backup.

  Usage:
    borg_check.rb BORG_REPO
EOF

borg_repo = $ARGV[0]

unless borg_repo
  puts help_message
  raise ArgumentError
end

begin
  last_backup = Date.strptime(
    `borg list #{borg_repo} 2&>/dev/null | tail -n 1`.split(' ')[2],
    '%Y-%m-%d'
  )
  puts (Date.today - last_backup).to_i
rescue
  # If there's any issue checking the backup status,
  # the backup should be assumed to be bad.
  # Put a big number.
  puts '9999'
end
