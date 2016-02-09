require 'spec_helper'

RSpec.describe StackOverFlow do
  include_context 'questions list'
  let(:stackoverflow) { StackOverFlow.new('something missing') }
  let(:invalid_stackoverflow) { StackOverFlow.new('something right') }

  context '.initialize' do
    it 'returns an instance of StackOverFlow object' do
      expect(stackoverflow).to be_an_instance_of StackOverFlow
    end

    it 'returns constructor of StackOverFlow object' do
      expect(stackoverflow.options).to eq({ query: { pagesize: 10, q: 'something missing', accepted: true, site: 'stackoverflow' } })
    end
  end

  context '.questions' do
    describe 'with valid options' do
      let(:questions) { questions = stackoverflow.questions }
      it 'creates terminal table object' do
        expect(questions).to be_an_instance_of Terminal::Table
      end

      it 'returns a table have 4 columns' do
        expect(questions.number_of_columns).to eq 4
      end

      it 'returns a table have 10 rows' do
        expect(questions.rows.count).to eq 10
      end
    end

    describe 'with invalid options' do
      it 'returns nil' do
        expect(invalid_stackoverflow.questions).to be_nil
      end
    end
  end
end
