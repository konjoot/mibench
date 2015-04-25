module Bench

  def for (app)
    App.new(app)
  end

  class App
    attr_reader :app

    def initialize(app)
      @app = app
    end

    def run(bencher)
      puts "Benching #{app} with #{bencher}"
    end
  end

  module_function :for
end