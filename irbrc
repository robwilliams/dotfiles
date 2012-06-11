#!/usr/bin/env ruby

require 'irb/completion'
require 'irb/ext/save-history'

IRB.conf[:SAVE_HISTORY] = 1000  
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"
IRB.conf[:PROMPT_MODE]  = :SIMPLE
IRB.conf[:AUTO_INDENT]  = true

# Stinkyink specific configuration
if defined?(Stinkyink)
  
  # Enable Auditing
  Auditor::User.current_user = User.find_by_email("rob@stinkyink.com") if defined?(Auditor)
end
