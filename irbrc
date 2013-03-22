#!/usr/bin/env ruby

require 'irb/completion'
require 'irb/ext/save-history'

begin
  require 'interactive_editor'
rescue LoadError
end

IRB.conf[:SAVE_HISTORY] = 10000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"
IRB.conf[:PROMPT_MODE]  = :SIMPLE
IRB.conf[:AUTO_INDENT]  = true
