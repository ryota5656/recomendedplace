require 'rails_helper'

RSpec.describe "Homes", js: true , type: :system do
  let(:user) { create(:user) }

  describe 'ヘッダー関連' do
    it 'Gotoに飛べること' do
      visit places_home_path
      page.driver.browser.switch_to.alert.accept
      click_on 'Go to'
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_content 'search'
    end
    it 'everyoneに飛べること' do
      visit places_home_path
      page.driver.browser.switch_to.alert.accept
      click_on 'Everyone'
      expect(page).to have_content '東　京'
    end
  end

  describe 'メイン関連' do
    context 'ログインしている場合' do
      before { login(user) }
      it '検索から保存ができること' do
        page.driver.browser.switch_to.alert.accept
        fill_in 'name', with: 'ラーメン'
        select '100', from: 'radius'
        #上野駅付近の緯度経度
        fill_in 'search2', with: '35.71390988758847'
        fill_in 'search3', with: '139.77707476079408'
        click_on '検　索'
        # 検索結果欄が表示される
        page.driver.browser.switch_to.alert.accept

        expect(page).to have_content '検索結果'
        # 登録する

        page.all('.register')[0].click
        expect(current_path).to eq my_places_todo_path
      end
    end
    context 'ログインしていない場合' do
      it '検索はできるが登録ができないこと' do
        visit places_home_path
        page.driver.browser.switch_to.alert.accept
        fill_in 'name', with: 'ラーメン'
        select '100', from: 'radius'
        fill_in 'search2', with: '35.71390988758847'
        fill_in 'search3', with: '139.77707476079408'
        click_on '検　索'
        # 検索結果欄が表示される
        page.driver.browser.switch_to.alert.accept
        take_full_page_screenshot 'hoge.png'
        expect(page).to have_content '検索結果'
        # 登録ボタンはない
        expect(page).not_to have_content "登　録"
      end
    end
  end
end
