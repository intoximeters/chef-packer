require 'spec_helper'

describe 'packer::default' do
  subject { chef_run }

  let(:chef_run) do
    ChefSpec::SoloRunner.new.converge described_recipe
  end

  before do
    allow(File).to receive(:exist?).and_call_original
  end

  it 'include the ark recipe' do
    expect(subject).to include_recipe 'ark'
  end

  it 'installs packer with ark' do
    expect(subject).to install_ark 'packer'
  end

  context 'when /usr/local/packer-packer_0.11.0/packer does not exist' do
    before do
      allow(File).to receive(:exist?).with('/usr/local/packer-packer_0.11.0/packer').and_return(false)
    end

    it 'links packer to packer-packer' do
      expect(subject).to create_link 'packer-to-packer-packer'
    end
  end

  context 'when /usr/local/packer-packer_0.11.0/packer exists' do
    before do
      allow(File).to receive(:exist?).with('/usr/local/packer-packer_0.11.0/packer').and_return(true)
    end

    it 'does not link packer to packer-packer' do
      expect(subject).to_not create_link 'packer-to-packer-packer'
    end
  end
end
