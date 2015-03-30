describe Transmission::Utils do
  let(:utils) {
    Class.new do
      include Transmission::Utils
    end
  }

  subject { utils.new }

  describe '.is_valid_key?' do
    describe 'with dashes' do
      let(:arguments) {[{field: 'test-me'}]}

      it 'should find valid key' do
        expect(subject.is_valid_key?('test_me', arguments)).to eq(true)
      end
    end

    describe 'with camelcase' do
      let(:arguments) {[{field: 'testMe'}]}

      it 'should find valid key' do
        expect(subject.is_valid_key?('test_me', arguments)).to eq(true)
      end
    end

    describe 'with invalid key' do
      let(:arguments) {[{field: 'testMe'}]}

      it 'should not find any key' do
        expect(subject.is_valid_key?('i_dont_exit', arguments)).to eq(false)
      end
    end
  end

  describe '.option_keys' do
    it 'should return the right option keys' do
      options = subject.option_keys('test_me')
      expect(options.include?('testMe')).to eq(true)
      expect(options.include?('test-me')).to eq(true)
    end
  end

  describe '.option_key' do
    describe 'with dashes' do
      let(:arguments) {[{field: 'test-me'}]}

      it 'should return the correct key' do
        expect(subject.option_key('test_me', arguments)).to eq('test-me')
      end
    end

    describe 'with camelcase' do
      let(:arguments) {[{field: 'testMe'}]}

      it 'should return the correct key' do
        expect(subject.option_key('test_me', arguments)).to eq('testMe')
      end
    end

    describe 'with invalid key' do
      let(:arguments) {[{field: 'testMe'}]}

      it 'should return nil' do
        expect(subject.option_key('i_dont_exit', arguments)).to eq(nil)
      end
    end
  end

end