require 'spec_helper'

RSpec.describe StackOverFlow do
  include_context 'questions list'
  let(:stackoverflow) { StackOverFlow.new('something missing', true) }
  let(:invalid_stackoverflow) { StackOverFlow.new('something right', true) }

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
      it 'returns array list of questions' do
        expect(questions.count).to eq 10
        expect(questions).to be_a_kind_of Array
      end

      [:tags, :owner, :answer_count, :accepted_answer_link, :title, :link].each do |el|
        it "returns questions list have element: #{el}" do
          expect(questions.sample).to have_key(el)
        end
      end
    end

    describe 'with invalid options' do
      it 'returns nil' do
        expect(invalid_stackoverflow.questions).to be_nil
      end
    end
  end
end
