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

end