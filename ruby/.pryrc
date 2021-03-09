begin
  require 'hirb'
rescue LoadError
  # Missing goodies, bummer
end

if defined? Hirb
  # Slightly dirty hack to fully support in-session Hirb.disable/enable toggling
  Hirb::View.instance_eval do
    def enable_output_method
      @output_method = true
      @old_print = Pry.config.print
      Pry.config.print = proc do |*args|
        Hirb::View.view_or_page_output(args[1]) || @old_print.call(*args)
      end
    end

    def disable_output_method
      Pry.config.print = @old_print
      @output_method = nil
    end
  end

  Hirb.enable
end

def qbm
  s = Time.now.to_f
  ret = yield
  puts "#{(Time.now.to_f - s).round(3)}s"
  ret
end

def _table(collection, headers: nil, total: [])
  column_sizes = (headers ? [headers] + collection : collection).reduce([]) do |lengths, row|
    row.each_with_index.map{|iterand, index| [lengths[index] || 0, iterand.to_s.length].max}
  end
  raise ArgumentError, "Must specify headers with total" if total.size.nonzero? && !headers
  totals = total.map { |col| headers.index(col) }.each_with_object({}) { |col_index, o| o[col_index] = 0 }
  row_separator = '-' * (column_sizes.inject(&:+) + (3 * column_sizes.count) + 1) + "\n"
  t = row_separator
  if headers
    t += '| ' + headers.each_with_index.map { |v, i| v = v.to_s + ' ' * (column_sizes[i] - v.to_s.length) }.join(' | ') + ' |' + "\n"
    t += row_separator
  end
  t += collection.map { |row|
    totals.each_key { |col_index| totals[col_index] += row[col_index] }
    row = row.fill(nil, row.size..(column_sizes.size - 1))
    row = row.each_with_index.map { |v, i| v = v.to_s + ' ' * (column_sizes[i] - v.to_s.length) }
    '| ' + row.join(' | ') + ' |' + "\n"
  }.join
  t += row_separator
  unless total.empty?
    totals.transform_values! { |v| v.round(4) }
    t += '| ' +
      headers.each_index.map { |col_index|
        if totals.key?(col_index)
          totals[col_index].to_s + ' ' * [(column_sizes[col_index] - totals[col_index].to_s.length), 0].max
        else
          ' ' * column_sizes[col_index]
        end
      }.join(' | ') + ' |' + "\n"
    t += row_separator
  end
  puts t
end

if defined?(PryByebug)
  Pry.commands.alias_command 'c', 'continue'
  Pry.commands.alias_command 's', 'step'
  Pry.commands.alias_command 'n', 'next'
  Pry.commands.alias_command 'f', 'finish'
  Pry.commands.alias_command 'bda', 'break --delete-all'

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

class Integer
  def factors
    return nil unless self >= 1
    (1..Math.sqrt(self).floor).flat_map { |i| (self % i).zero? ? [i, self/i] : [] }.uniq.sort
  end
end

# vim: syntax=ruby
