require 'sshkit'
require 'sshkit/dsl'
require 'active_support/core_ext/string/inflections'
SSHKit.config.output_verbosity = :debug

module Bench
  attr_reader :name, :app, :bencher

  def mark(&block)
    self.instance_eval &block
  end

  def with(name, &block)
    puts 'test'
  end


  module_function :mark, :with

  private

  def app
    @app ||= App.new(name)
  end

  module_function :app

  def bencher
    @bencher ||= Bencher.new()
  end

  module_function :bencher

  class App
    attr_reader :app, :name, :f_name

    APPS = %i{pliny gin}.freeze

    def initialize(name)
      @name = name
      @f_name = "Bench::#{name.to_s.camelize}"
      @app  = build_app
    end

    def start
      app.start
    end

    def build_app
      raise 'unknown app name' if invalid?
      p f_name
      app_cls = f_name.constantize
      return app_cls.new if app_cls.respond_to? :new
      raise "can't initialize #{name}"
    end

    def valid?
      p APPS
      APPS.include?(name)
    end

    def invalid?
      !valid?
    end

  end

  class Pliny

    attr_reader :config

    NAME = :pliny

    def initialize
      @config = Bench::Config.new(NAME)
    end

    def start
      run_locally do
        within '/home/konjoot/projects/microservice_experiments/pliny' do
          with rack_env: :production, daemonize: :true do
            execute :rvm, '2.2.1@pliny', :do, :foreman, :start
          end
        end
      end
      # return "#{NAME} allready running!" if running?
      # %x{#{cname} #{args}}
    end

    def running?
    end

    def cname
    end

    def args
    end
  end

  class Config
    attr_reader :name

    def initialize(name)
      @name = name
    end
  end

  class Gin
  end

  class Bencher
    attr_reader :bname

    def initialize()
    end

    def run_by(bname)
      @bname = bname
      puts 'its alive'
    end
  end
end
