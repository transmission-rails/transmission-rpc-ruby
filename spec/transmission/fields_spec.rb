describe Transmission::Fields do

  [
      {className: Transmission::Fields::SessionGet, fields: ['alt-speed-down']},
      {className: Transmission::Fields::TorrentGet, fields: ['doneDate']},
      {className: Transmission::Fields::SessionStats, fields: ['activeTorrentCount']}
  ].each do |klass|

    describe "#{klass[:className]}" do
      describe '#new' do
        it 'should create an instance with correct fields' do
          instance = klass[:className].new
          expect(instance.fields.size).to eq(klass[:className]::ATTRIBUTES.size)
        end

        it 'should create an instance with given fields' do
          instance = klass[:className].new klass[:fields]
          expect(instance.fields.size).to eq(1)
        end

        it 'should raise an error if invalid arguments is given' do
          expect {
            klass[:className].new 'i-dont-exist' => ''
          }.to raise_error(Transmission::Fields::InvalidField)
        end
      end
    end

  end

end