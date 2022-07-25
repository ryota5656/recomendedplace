require 'rails_helper'

RSpec.describe "Allplaces", js: true, type: :system do
  let(:user) { create(:user) }
  let!(:place){ create(:place, user_id: user.id)}
  let!(:place2){ create(:place, user_id: user.id)}
  let!(:complete){ create(:complete, user_id: user.id, place_id: place.id)}
  let!(:complete2){ create(:complete, user_id: user.id, place_id: place2.id)}

  describe 'ヘッダー関連' do
    it 'Gotoに飛べること' do
      visit all_places_all_path
      click_on 'Go to'
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_content 'search'
    end
    it 'everyoneに飛べること' do
      visit all_places_all_path
      click_on 'Everyone'
      expect(page).to have_content '東　京'
    end
  end

  describe 'メイン関係' do
    context'placeが登録されていること' do
      it 'infowindowが表示されること' do
        visit all_places_all_path
        within('#map')do
          pin = find("map#gmimap1 area", visible: false)
          pin.click
          # infowindowの中身
          expect(page).to have_content "東京駅"
        end
        #page.save_screenshot 'hoge.png'
      end
    end
    context '各エリアが表示されること' do
      it '東京' do
        visit all_places_all_path
        find(".button-tokyo").click
        expect(page).to have_content "35.68944"
        expect(page).to have_content "139.69167"
      end
      it '大阪' do
        visit all_places_all_path
        find(".button-osaka").click
        expect(page).to have_content "34.68639"
        expect(page).to have_content "135.52"
      end
      it '京都' do
        visit all_places_all_path
        find(".button-kyoto").click
        expect(page).to have_content "35.02139"
        expect(page).to have_content "135.75556"
      end
      it '札幌' do
        visit all_places_all_path
        find(".button-sapporo").click
        expect(page).to have_content "43.06417"
        expect(page).to have_content "141.34694"
      end
    end
  end
end
