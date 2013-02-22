#!/usr/bin/env ruby

require 'irb/completion'
require 'irb/ext/save-history'

begin
  require 'interactive_editor'
rescue LoadError
end

IRB.conf[:SAVE_HISTORY] = 1000  
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"
IRB.conf[:PROMPT_MODE]  = :SIMPLE
IRB.conf[:AUTO_INDENT]  = true

# Stinkyink specific configuration
if defined?(Stinkyink)
  
  # Enable Auditing
  Auditor::User.current_user = User.find_by_email("rob@stinkyink.com") if defined?(Auditor)
end

class Object

  include Rails::ConsoleMethods if defined?(Rails)

  def vim(method_name)
    file, line = method(method_name).source_location
    fork do
      exec("vim +#{line} '#{file}'")
    end
    Process.wait
    reload! if defined?(Rails)
  end

  alias :v :vim
end
