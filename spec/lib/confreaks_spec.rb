require 'spec_helper'

RSpec.describe Confreaks do
  include_context 'confreaks list'
  let(:conf) { Confreaks.new("2015") }
  let(:invalid_conf) { Confreaks.new("820982039") }

  context '.initialize' do
    it 'returns an instance of Confreaks object' do
      expect(conf).to be_an_instance_of Confreaks
    end

    it 'returns constructor of Confreaks object' do
      expect(conf.year).to eq "2015"
    end
  end

  context '.event_of_year' do
    describe 'with a field - for example: ruby, js or python' do
      it 'returns a list of conferences of a field in year - for example: ruby' do
        expect(conf.events_of_year("ruby").rows.count).to eq 2
      end

      it 'creates terminal table object' do
        expect(conf.events_of_year("ruby")).to be_an_instance_of Terminal::Table
      end
    end

    describe 'without a field' do
      it 'return a list of conferences in year' do
        expect(conf.events_of_year.rows.count).to eq 4
      end

      it 'creates terminal table object' do
        expect(conf.events_of_year).to be_an_instance_of Terminal::Table
      end
    end

    context 'with invalid year' do
      it 'returns nil if the year argument invalid' do
        expect(invalid_conf.events_of_year).to be_nil
        expect(invalid_conf.events_of_year('python')).to be_nil
      end
    end
  end
end
