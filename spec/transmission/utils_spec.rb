describe Transmission::Utils do
  let(:utils) {
    Class.new do
      include Transmission::Utils
    end
  }

  subject { utils.new }

  

end
