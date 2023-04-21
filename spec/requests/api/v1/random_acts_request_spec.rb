require 'rails_helper'

RSpec.describe 'Random Acts Controller' do
  describe '#index', :vcr do
    it 'returns 3 random activities from the Bored API' do
      get '/api/v1/random_acts'

      expect(response).to be_successful

      parsed_data = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_data).to be_a(Hash)
      expect(parsed_data[:data]).to be_a(Hash)
      expect(parsed_data[:data].keys).to eq(%i[id type attributes])
      expect(parsed_data[:data][:attributes]).to be_a(Hash)
      expect(parsed_data[:data][:attributes].keys).to eq([:deed_names])
      expect(parsed_data[:data][:attributes][:deed_names]).to be_a(Array)
      expect(parsed_data[:data][:attributes][:deed_names].count).to eq(3)
    end
  end
end
