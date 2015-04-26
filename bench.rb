require 'active_support/core_ext/string/inflections'
require 'sshkit/dsl'

module Bench

  def for (app)
    App.new(app).start
    return Bencher.new()
  end

  module_function :for

  class App
    attr_reader :app, :name, :f_name

    APPS = %i{pliny gin}

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
      on :localhost do
        within '/home/konjoot/projects/mecroservice_experiments/pliny' do
          with rack_env: :production, daemonize: :true do
            execute :foreman, :start
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
  end

  class Gin
  end

  class Bencher
    attr_reader :bname

    def initialize()
    end

    def run(bname)
      @bname = bname
      puts %x{#{cname} #{args}}
    end
  end
end
