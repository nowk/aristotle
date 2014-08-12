require 'rails_helper'

feature 'User is able to set prizes for completing goals' do
  before :each do
    visit new_user_goal_prize_path(@user.id, @goal.id)
    fill_in 'prize[name]', with: 'Foobarbaz'
    click_button 'save-prize'
  end

  scenario 'User goes to new prize page, enters prize description and clicks submit to see success dialog' do
    expect(page).to have_selector '.notice'
    expect(page).to have_selector 'h2[rel="prize-name"]'
  end

  scenario 'After prize creation, user can see prize in goals prize list' do
    click_link 'Back'
    expect(page).to have_selector '.prize-list'
    expect(page).to have_content 'Foobarbaz'
  end

  scenario 'After prize creation, user clicks on prize link to go to prize show' do
    click_link 'Back'
    click_link 'Foobarbaz'
    expect(page).to have_selector 'h2[rel="prize-name"]'
    expect(page).to have_content 'Foobarbaz'
  end
end
