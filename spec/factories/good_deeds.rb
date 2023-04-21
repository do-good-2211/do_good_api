FactoryBot.define do
  factory :good_deed do
    name { Faker::Lorem.sentence(word_count: 3, supplemental: false, random_words_to_add: 4) }
    date { Faker::Date.between(from: '2023-05-23', to: '2024-09-25') }
    time { '16:00' }
    media_link { Faker::Internet.url }
    host_id { Faker::Number.number(digits: 1) }
    # notes { Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 3) }
  end
end
