module Bench

  def for (app)
    App.new(app).start
    return Bencher.new()
  end

  module_function :for

  class App
    attr_reader :app, :name

    APPS = %w{pliny, gin}.freeze

    def initialize(name)
      @name = name
      @app  = build_app
    end

    def start
      app.start
    end

    def build_app
      raise 'unknown app name' if invalid?
      app_cls = name.to_s.camelize.constantize
      return app_cls.new if app_cls.respond_to? :new
      raise "can't initialize #{name}"
    end

    def valid?
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
      @config = Config.new(NAME)
    end

    def start
      return "#{NAME} allready running!" if running?
      %x{#{cname} #{args}}
    end

    def running?
    end

    def cname
    end

    def args
    end
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
