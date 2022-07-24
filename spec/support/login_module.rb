module LoginModule
  def login(user)
    visit new_user_session_path
    fill_in 'メールアドレス', with: 'test@email.com'
    fill_in 'パスワード', with: '111111'
    click_button 'ログイン'
  end
end
