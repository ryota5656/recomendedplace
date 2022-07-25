require 'rails_helper'

RSpec.describe "Myplaces",js: true, type: :system do
  let(:user) { create(:user) }
  let!(:place){ create(:place, user_id: user.id)}
  let!(:place2){ create(:place, user_id: user.id)}
  let!(:place3){ create(:place, user_id: user.id)}
  let!(:complete){ create(:complete, user_id: user.id, place_id: place.id)}
  let!(:complete2){ create(:complete, user_id: user.id, place_id: place3.id)}
  let!(:favorite){ create(:favorite, user_id: user.id, place_id: place.id)}

  describe 'Todo関連' do
    before { login(user) }
    context 'ナビゲーションバー' do
     it '行ったに移動' do
      page.driver.browser.switch_to.alert.accept
      visit my_places_todo_path
      click_link '行った'
      expect(current_path).to eq my_places_completes_path
     end
     it 'お気に入りに移動' do
      page.driver.browser.switch_to.alert.accept
      visit my_places_todo_path
      click_link 'お気に入り'
      expect(current_path).to eq my_places_favorites_path
     end
     it 'マイページに移動' do
      page.driver.browser.switch_to.alert.accept
      visit my_places_todo_path
      click_link 'マイページ'
      expect(current_path).to eq user_path(user)
     end
     it 'ログアウト' do
      page.driver.browser.switch_to.alert.accept
      visit my_places_todo_path
      click_link 'ログアウト'
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_content "ログアウトしました。"
     end
    end
    context 'todo-list' do
      it 'コメント・評価・完了' do
        page.driver.browser.switch_to.alert.accept
        visit my_places_todo_path
        page.all('.star')[2].hover
        page.all('.star')[2].click
        fill_in 'comment', with: 'おいしかった'

        click_button '完　了'
        visit my_places_completes_path
        expect(page).to have_content '3.0'
        expect(page).to have_content 'おいしかった'
      end
      it '削除' do
        page.driver.browser.switch_to.alert.accept
        visit my_places_todo_path
        expect{
          click_button '削　除'
          expect(page).not_to have_content "名前"
        }. to change(Place, :count).by(-1)
      end
    end
  end

  describe 'Complete関連' do
    before { login(user) }
    context 'ナビゲーションバー' do
      it '行くとこに移動' do
        page.driver.browser.switch_to.alert.accept
        visit my_places_completes_path
        click_link '行くとこ'
        expect(current_path).to eq my_places_todo_path
       end
       it 'お気に入りに移動' do
        page.driver.browser.switch_to.alert.accept
        visit my_places_completes_path
        click_link 'お気に入り'
        expect(current_path).to eq my_places_favorites_path
       end
       it 'マイページに移動' do
        page.driver.browser.switch_to.alert.accept
        visit my_places_completes_path
        click_link 'マイページ'
        expect(current_path).to eq user_path(user)
       end
       it 'ログアウト' do
        page.driver.browser.switch_to.alert.accept
        visit my_places_completes_path
        click_link 'ログアウト'
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content "ログアウトしました。"
       end
    end
    context 'complete-list' do
      fit 'お気に入り登録' do
        page.driver.browser.switch_to.alert.accept
        visit my_places_completes_path
        click_button 'お気に入り登録'
        visit my_places_favorites_path
        expect(page).to have_content '東京駅'
      end
      it '登録解除' do
        page.driver.browser.switch_to.alert.accept
        visit my_places_completes_path
        click_button '登録解除'
        expect(page).not_to have_content '登録解除'
      end
      it '編集' do
        page.driver.browser.switch_to.alert.accept
        visit my_places_completes_path
        #page.save_screenshot 'hoge.png'
        page.all('.edit-btn')[0].click
        expect(current_path).to eq edit_my_place_path(complete)
      end
    end
  end

  describe 'Favorite関連' do
    before { login(user) }
    context 'ナビゲーションバー' do
      it '行くとこに移動' do
        page.driver.browser.switch_to.alert.accept
        visit my_places_completes_path
        click_link '行くとこ'
        expect(current_path).to eq my_places_todo_path
       end
       it '行ったに移動' do
        page.driver.browser.switch_to.alert.accept
        visit my_places_todo_path
        click_link '行った'
        expect(current_path).to eq my_places_completes_path
       end
       it 'マイページに移動' do
        page.driver.browser.switch_to.alert.accept
        visit my_places_completes_path
        click_link 'マイページ'
        expect(current_path).to eq user_path(user)
       end
       it 'ログアウト' do
        page.driver.browser.switch_to.alert.accept
        visit my_places_completes_path
        click_link 'ログアウト'
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content "ログアウトしました。"
       end
    end
    context 'favorite-list'do
      it '登録解除' do
        page.driver.browser.switch_to.alert.accept
        visit my_places_favorites_path
        expect{
          click_button '登録解除'
          expect(page).not_to have_content "登録解除"
        }. to change(Favorite, :count).by(-1)
      end
      it '編集' do
        page.driver.browser.switch_to.alert.accept
        visit my_places_favorites_path
        click_link '編集'
        expect(current_path).to eq edit_my_place_path(complete)
      end
    end

  end
end
