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

      it 'returns list of gems match with query' do
        expect(gems).to be_a_kind_of Array
      end

      [:name, :info, :url, :authors, :downloads].each do |el|
        it "returns list of gems have element: #{el}" do
          expect(gems.sample).to have_key(el)
        end
      end
    end

    describe 'with invalid option' do
      it 'returns nil' do
        expect(invalid_rubygem.gems).to be_nil
      end
    end
  end
end
