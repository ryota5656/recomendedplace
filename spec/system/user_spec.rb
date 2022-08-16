require 'rails_helper'

RSpec.describe "User", type: :system do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  describe 'User CRUD' do
    describe 'ログイン前' do
      describe 'ユーザー新規登録' do
        context 'フォームの入力値が正常' do
          it 'ユーザーの新規作成が成功' do
            visit new_user_registration_path
            fill_in 'メールアドレス', with: 'test@example.com'
            fill_in 'パスワード', with: 'password'
            fill_in 'もう一度パスワードを入力してください', with: 'password'
            click_button 'アカウントを作成する'
            # places_home_pathへ遷移することを期待する
            expect(current_path).to eq places_home_path
            expect(page).to have_content 'アカウント登録が完了しました。'
          end
        end

        context 'メールアドレス未記入' do
          it 'ユーザーの新規作成が失敗' do
            visit new_user_registration_path
            fill_in 'メールアドレス', with: nil
            fill_in 'パスワード', with: 'password'
            fill_in 'もう一度パスワードを入力してください', with: 'password'
            click_button 'アカウントを作成する'
            # user_registration_pathへ遷移することを期待する
            expect(current_path).to eq user_registration_path
            expect(page).to have_content "メールアドレス translation missing"
          end
        end

        context '登録済メールアドレス' do
          it 'ユーザーの新規作成が失敗' do
            visit new_user_registration_path
            fill_in 'メールアドレス', with: user.email
            fill_in 'パスワード', with: 'password'
            fill_in 'もう一度パスワードを入力してください', with: 'password'
            click_button 'アカウントを作成する'
            # user_registration_pathへ遷移することを期待する
            expect(current_path).to eq user_registration_path
            expect(page).to have_content "メールアドレス translation missing"
          end
        end
      end
    end

    describe 'ログイン後' do
      # ログイン状態
      before { login(user) }

      describe 'ユーザー編集'
      context 'フォームの入力値が正常' do
        it 'ユーザーの編集が成功' do
          visit edit_user_registration_path(user)
          fill_in 'メールアドレス', with: 'test@example.com'
          fill_in 'パスワード', with: 'test'
          fill_in 'パスワード(確認)', with: 'test'
          fill_in '現在のパスワード', with: user.password
          click_button '更新する'
          expect(current_path).to eq root_path
          expect(page).to have_content 'アカウント情報を変更しました。'
        end
      end

      context 'メールアドレス未記入' do
        it 'ユーザーの編集が失敗' do
          visit edit_user_registration_path(user)
          fill_in 'メールアドレス', with: nil
          fill_in 'パスワード', with: 'test'
          fill_in 'パスワード(確認)', with: 'test'
          fill_in '現在のパスワード', with: user.password
          click_button '更新する'
          # 編集後root_pathへ遷移することを期待する
          expect(current_path).to eq user_registration_path
          expect(page).to have_content 'エラーが発生したため ユーザー は保存されませんでした。'
        end
      end
    end
  end
end
