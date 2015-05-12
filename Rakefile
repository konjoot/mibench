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
    Bench.for(:pliny).run_by(:wrk)
  end

  desc 'wrk benchmark for gin-gonic'
  task :gin do
    Bench.for(:gin).run_by(:wrk)
  end
end

namespace :boom do

  desc 'boom benchmark for pliny'
  task :pliny do
    Bench.for(:pliny).run_by(:boom)
  end

  desc 'boom benchmark for gin-gonic'
  task :gin do
    Bench.for(:gin).run_by(:boom)
  end
end