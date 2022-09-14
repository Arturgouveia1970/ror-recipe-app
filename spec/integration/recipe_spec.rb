require 'rails_helper'

RSpec.describe 'Posts index page', type: :system do
  before do
    driven_by(:rack_test)
    @user = User.create(name: 'admin',
                        email: 'admin@email.com',
                        password: 'password', password_confirmation: 'password')
    @user.save
    @recipe = Recipe.create(user_id: @user.id, name: 'Recipe 1', preparation_time: 10, cooking_time: 20,
                            description: 'This is test recipe and it is very delicious', public: true)
    visit 'user/sign_in'
    within('#new_user') do
      fill_in 'Email', with: 'admin@email.com'
      fill_in 'Password', with: 'password'
    end
    find_button('Log in').click
  end

  it 'I can browse the public recipes.' do
    expect(page).to have_content('Signed in successfully.')
    expect(page).to have_content('Recipe 1')
  end

  it 'I can see the My recipes.' do
    click_link('New Recipe')
    expect(page).to have_selector('input[type="text"]')
  end

  it 'I can create new recipes.' do
    click_link('New Recipe')
    fill_in 'Recipe name', with: 'Stake'
    fill_in 'Preparation time', with: '30'
    fill_in 'Cooking time', with: '60'
    fill_in 'Description', with: 'stake is very tasty and amazing'
    find_button('Save Recipe').click
    expect(page).to have_content('Stake')
    expect(page).to have_content('stake is very tasty and amazing')
  end

  it 'I can delete recipes.' do
    visit user_recipe_index_path(user_id: @recipe)
    expect(page).to have_content('Remove')
  end
end
