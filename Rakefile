require_relative 'bench'

desc 'pliny benchmark'
task pliny: ['wrk:pliny', 'boom:pliny']

desc 'gin-gonic benchmark'
task gin: ['wrk:gin', 'boom:gin']

desc 'all'
task all: [:pliny, :gin]

task default: :all

namespace :wrk do

  desc 'wrk benchmark for pliny'
  task :pliny do
    Bench::mark do
      with(:pliny) { run :wrk }
    end
  end

  desc 'wrk benchmark for gin-gonic'
  task :gin do
    Bench::mark do
      with(:gin) { run :wrk }
    end
  end
end

namespace :boom do

  desc 'boom benchmark for pliny'
  task :pliny do
    Bench::mark do
      with(:pliny) { run :boom }
    end
  end

  desc 'boom benchmark for gin-gonic'
  task :gin do
    Bench::mark do
      with(:gin) { run :boom }
    end
  end
end