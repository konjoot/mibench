require 'sshkit'
require 'sshkit/dsl'

class Test
  def initialize
    run
  end

  def run
    run_locally do
      within '/tmp' do
        puts capture(:ls)
      end
    end
  end
end

Test.new
