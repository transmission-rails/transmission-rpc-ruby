describe Transmission::Arguments::SessionGet do

  describe '#new' do

    describe 'when fields are declared' do

      before :each do
        @model = Transmission::Arguments::SessionGet.new(['alt-speed-down'])
      end

      it 'should only use the declared fields' do
        expect(@model.arguments.size).to eq(1)
      end

    end

    describe 'when no fields are declared' do
      before :each do
        @model = Transmission::Arguments::SessionGet.new
      end

      it 'should only use the declared fields' do
        expect(@model.arguments.size).to eq(54)
      end
    end

    describe 'when wrong fields are declared' do
      it 'should raise an exception' do
        expect {
          @model = Transmission::Arguments::SessionGet.new(['alt-speed-down', 'i-dont-exist'])
        }.to raise_error(Transmission::Arguments::InvalidArgument)
      end
    end

  end

  describe '#to_arguments' do

    before :each do
      @model = Transmission::Arguments::SessionGet.new
    end

    it 'should return all the arguments' do
      expect(@model.to_arguments.size).to eq(54)
    end

  end

end