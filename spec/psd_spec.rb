require 'spec_helper'

describe 'PSD' do
  let(:filename) { 'spec/files/example.psd' }

	it 'should open a file without a block' do
    psd = PSD.new(filename)
    expect(psd).to_not be_parsed
    expect(psd).to be_an_instance_of(PSD)
	end

  it 'should raise an exception if using open without a block' do
    expect {
      PSD.open(filename)
    }.to raise_error(RuntimeError, 'Must supply a block. Otherwise, use PSD.new.')
  end

  it 'should refuse to open a bad filename' do
    expect { PSD.new('') }.to raise_error(Errno::ENOENT)
  end

  it 'should open a file and feed it to a block' do
    PSD.open(filename) do |psd|
      expect(psd).to be_parsed
      expect(psd).to be_an_instance_of(PSD)
    end
  end

  it 'should open a file and feed it to a block DSL style' do
    PSD.open(filename) do |psd|
      expect(psd.parsed?).to eq(true)
      expect(psd.is_a?(PSD)).to eq(true)
    end
  end
end