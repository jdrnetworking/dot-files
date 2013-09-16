def qbm
  s = Time.now.to_f
  ret = yield
  puts "#{(Time.now.to_f - s).round(3)}s"
  ret
end

if defined?(PryDebugger)
  Pry.commands.alias_command 'c', 'continue'
  Pry.commands.alias_command 's', 'step'
  Pry.commands.alias_command 'n', 'next'
  Pry.commands.alias_command 'f', 'finish'
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
end

class String
  def to_clipboard
    IO::popen(%w(pbcopy), 'w') { |io| io.write self } && self
  end
end

# vim: syntax=ruby
