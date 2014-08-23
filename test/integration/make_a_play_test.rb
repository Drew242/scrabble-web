class MakeAPlayTest < ActionDispatch::IntegrationTest
  def test_a_word_is_played_and_scored
    visit '/plays'
    click_link_or_button 'Play New Word'
    fill_in 'play[word]', :with => "HELLO"
    click_link_or_button 'Play!'
    assert_equal '/plays', current_path

    within('#plays:first') do
      assert page.has_content('hello')
      assert page.has_content('8')
    end
  end

  def test_blank_word_is_not_played
    visit '/plays'
    click_link_or_button 'Play New Word'
    fill_in 'play[word]', :with => ""
    click_link_or_button 'Play!'

    assert_equal '/plays/new', current_path
    within('#errors') do
      assert page.has_content('blank')
    end
  end

  def test_words_with_non_letters_are_rejected
    ['exclaim!', '37numbers'].each do |word|
      visit '/plays'
      click_link_or_button 'Play New Word'
      fill_in 'play[word]', :with => word
      click_link_or_button 'Play!'

      assert_equal '/plays/new', current_path
      within('#errors') do
        assert page.has_content('letters')
      end
    end
  end
end
