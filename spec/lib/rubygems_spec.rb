require 'spec_helper'

RSpec.describe RubyGems do
  include_context 'gems list'
  let(:rubygem) { RubyGems.new('weer') }
  let(:invalid_rubygem) { RubyGems.new('inv4lid') }

  context '.initialize' do
    it 'returns an instance of RubyGems object' do
      expect(rubygem).to be_an_instance_of RubyGems
    end

    it 'returns constructor of RubyGems object' do
      expect(rubygem.option).to eq({ query: { query: 'weer' } })
    end
  end

  context '.gems' do
    describe 'with valid option' do
      let(:gems) { rubygem.gems }

      it 'creates terminal table object' do
        expect(gems).to be_an_instance_of Terminal::Table
      end

      it 'returns a table have 5 columns' do
        expect(gems.number_of_columns).to eq 5
      end
    end

    describe 'with invalid option' do
      it 'returns nil' do
        expect(invalid_rubygem.gems).to be_nil
      end
    end
  end
end
