FactoryBot.define do
  factory :place do
    name         { '東京駅' }
    latitude     { '35.6809591' }
    longitude    { '139.7673068' }
    price_level  { '2' }
    rating       { '3' }
    place_id     { 'ChIJC3Cf2PuLGGAROO00ukl8JwA' }
    address      { '東京都千代田区丸の内１丁目' }
  end
end
