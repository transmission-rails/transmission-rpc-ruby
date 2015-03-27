describe Transmission::Arguments do

  [
      {className: Transmission::Arguments::SessionGet, arguments: ['alt-speed-down']},
      {className: Transmission::Arguments::SessionSet, arguments: ['alt-speed-down']},
      {className: Transmission::Arguments::SessionStats, arguments: ['activeTorrentCount']},
      {className: Transmission::Arguments::TorrentAdd, arguments: ['cookies']},
      {className: Transmission::Arguments::TorrentGet, arguments: ['id']},
      {className: Transmission::Arguments::TorrentSet, arguments: ['bandwidthPriority']}
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
            klass[:className].new ['i-dont-exist']
          }.to raise_error(Transmission::Arguments::InvalidArgument)
        end
      end
    end

  end

end