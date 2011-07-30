require 'active_record'
require 'highline/import'

module RdsSlowLog
  class SlowLog < ActiveRecord::Base
    set_table_name 'slow_log'

    def query_time
      time_parse query_time_before_type_cast
    end
    def lock_time
      time_parse lock_time_before_type_cast
    end
    def to_s
      <<EOS
# Time: #{start_time.strftime('%y%m%d %H:%M:%S')}
# User@Host: #{user_host}
# Query_time: #{query_time}  Lock_time: #{lock_time}  Rows_sent: #{rows_sent}  Rows_examined: #{rows_examined}
#{sql_text};
EOS
    end

    def self.print_all
      find(:all, :order => :start_time).each do |query|
        puts query
      end
    end

    private
    def time_parse string
      hours, minutes, seconds = string.to_s.split(/:/)
      hours.to_i * 60 * 60 + minutes.to_i * 60 + seconds.to_i
    end
  end
  def self.print_slow_log hostname, username
    password = ask("Password: ") {|q| q.echo = false}
    ActiveRecord::Base.establish_connection :adapter  => 'mysql',
      :database => 'mysql',
      :hostname => hostname,
      :username => username,
      :password => password
    SlowLog.print_all
  end
end

