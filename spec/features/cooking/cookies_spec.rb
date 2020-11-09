feature 'Cooking cookies' do
  scenario 'Cooking a single cookie' do
    user = create_and_signin
    oven = user.ovens.first

    visit oven_path(oven)

    expect(page).to_not have_content 'Chocolate Chip'
    expect(page).to_not have_content 'Your Cookie is Ready'

    # Prepare a cookie
    click_link_or_button "prepare-cookie"
    fill_in 'Fillings', with: 'Chocolate Chip'
    click_button 'Mix and bake'

    expect(page).to have_content 'Chocolate Chip'
    expect(page).to_not have_content 'Your Cookie is Ready'

    # When the cookie is baked
    Cookie.last.update!(ready: true)

    refresh
    expect(page).to have_content 'Your Cookie is Ready'

    click_button 'Retrieve Cookie'
    expect(page).to_not have_content 'Chocolate Chip'
    expect(page).to_not have_content 'Your Cookie is Ready'

    visit root_path
    within '.store-inventory' do
      expect(page).to have_content '1 Cookie'
    end
  end

  scenario 'Trying to bake a cookie while oven is full' do
    user = create_and_signin
    oven = user.ovens.first

    oven = FactoryGirl.create(:oven, user: user)
    visit oven_path(oven)

    click_link_or_button "prepare-cookie"
    fill_in 'Fillings', with: 'Chocolate Chip'
    click_button 'Mix and bake'

    click_link_or_button  "prepare-cookie"
    expect(page).to have_content "There's something is already in the oven"
    expect(current_path).to eq(oven_path(oven))
    expect(page).to_not have_button 'Mix and bake'
  end

  scenario 'Baking multiple cookies' do
    user = create_and_signin
    oven = user.ovens.first

    oven = FactoryGirl.create(:oven, user: user)
    visit oven_path(oven)

    3.times do
      click_link_or_button "prepare-cookie"
      fill_in 'Fillings', with: 'Chocolate Chip'
      click_button 'Mix and bake'

      # When the cookie is baked
      Cookie.last.update!(ready: true)

      refresh

      click_button 'Retrieve Cookie'
    end

    visit root_path
    within '.store-inventory' do
      expect(page).to have_content '3 Cookies'
    end
  end

  scenario 'Baking a sheet of cookies' do
    user = create_and_signin
    oven = user.ovens.first

    oven = FactoryGirl.create(:oven, user: user)
    visit oven_path(oven)

    click_link_or_button "prepare-sheet"
    fill_in 'Fillings', with: 'Chocolate Chip'
    click_button 'Mix and bake'

    # When the cookie is baked
    Sheet.last.update!(ready: true)

    refresh

    click_button 'Retrieve Cookies'
    
    visit root_path
    within '.store-inventory' do
      expect(page).to have_content '5 Cookies'
    end
  end
end
