describe Transmission::Arguments do

  [
      {className: Transmission::Arguments::SessionSet, arguments: {'alt-speed-down' => 5}},
      {className: Transmission::Arguments::TorrentAdd, arguments: {'paused' => true}},
      {className: Transmission::Arguments::TorrentSet, arguments: {'location' => '/location'}}
  ].each do |klass|

    describe "#{klass[:className]}" do
      describe '#new' do
        it 'should create an instance with correct arguments' do
          instance = klass[:className].new
          expect(instance.arguments.size).to eq(klass[:className]::ATTRIBUTES.size)
        end

        it 'should create an instance with given arguments' do
          instance = klass[:className].new klass[:arguments]
          expect(instance.arguments.size).to eq(1)
        end

        it 'should raise an error if invalid arguments is given' do
          expect {
            klass[:className].new 'i-dont-exist' => ''
          }.to raise_error(Transmission::Arguments::InvalidArgument)
        end
      end
    end

  end

  describe '.is_valid?' do
    describe 'with valid key' do
      it 'should return true' do
        stub_const("Transmission::Arguments::ATTRIBUTES", [{field: 'test-me'}])
        expect(Transmission::Arguments.is_valid?('test_me')).to eq(true)
      end
    end

    describe 'with invalid key' do
      it 'should return true' do
        stub_const("Transmission::Arguments::ATTRIBUTES", [{field: 'test-me'}])
        expect(Transmission::Arguments.is_valid?('testMee')).to eq(false)
      end
    end
  end

  describe '.real_key' do
    describe 'with valid key' do
      it 'should return real key' do
        stub_const("Transmission::Arguments::ATTRIBUTES", [{field: 'test-me'}])
        expect(Transmission::Arguments.real_key('test_me')).to eq('test-me')
      end
    end

    describe 'with invalid key' do
      it 'should return nil' do
        stub_const("Transmission::Arguments::ATTRIBUTES", [{field: 'test-me'}])
        expect(Transmission::Arguments.real_key('testMee')).to eq(nil)
      end
    end
  end

  describe '.filter' do
    describe 'with valid keys' do
      it 'should filter the correct keys' do
        stub_const("Transmission::Arguments::ATTRIBUTES", [{field: 'test-me'}])
        hash = {'test-me' => 'some-value'}
        expect(Transmission::Arguments.filter(hash)).to eq(hash)
      end
    end

    describe 'with invalid keys' do
      it 'should filter out the incorrect keys' do
        stub_const("Transmission::Arguments::ATTRIBUTES", [{field: 'test-me'}])
        hash = {'test-me' => 'some-value', 'incorrect-key' => 'some-value'}
        expect(Transmission::Arguments.filter(hash)).to eq({'test-me' => 'some-value'})
      end
    end
  end

end