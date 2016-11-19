def qbm
  s = Time.now.to_f
  ret = yield
  puts "#{(Time.now.to_f - s).round(3)}s"
  ret
end

if defined?(PryByebug)
  Pry.commands.alias_command 'c', 'continue'
  Pry.commands.alias_command 's', 'step'
  Pry.commands.alias_command 'n', 'next'
  Pry.commands.alias_command 'f', 'finish'

  # Hit Enter to repeat last command
  Pry::Commands.command /^$/, "repeat last command" do
    _pry_.run_command Pry.history.to_a.last
  end
end

if defined?(ActiveRecord)
  class ActiveRecord::Base
    def self.sample
      self.offset(rand(self.count)).first
    end
  end

  class ActiveRecord::Relation
    def sample
      self.offset(rand(self.count)).first
    end
  end

  def toggle_logger
    @_old_logger, ActiveRecord::Base.logger = ActiveRecord::Base.logger, @_old_logger
    @_old_logger ? 'Logging Off' : 'Logging On'
  end

  def tail_app_events
    toggle_logger if ActiveRecord::Base.logger
    last_event = AppEvent.order(:id).last
    loop do
      events = AppEvent.where('id > ?', last_event)
      events.each do |event|
        puts event.details
        last_event = event
      end
      sleep 1
    end
  end
end

class String
  def to_clipboard
    IO::popen(%w(pbcopy), 'w') { |io| io.write self } && self
  end
end

# vim: syntax=ruby
