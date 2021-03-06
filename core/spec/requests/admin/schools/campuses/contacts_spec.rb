require 'spec_helper'

describe 'Admin School Campus Contact' do

  stub_authorization!

  let(:school) { create(:school) }
  let(:contact_type) { create(:contact_type, :name => 'email') }
  let(:contact) { create(:contact, :contact_type => contact_type) }
  let(:contact2) { create(:contact, :data => 'gaku2@example.com', :contact_type => contact_type) }
  before :all do
    set_resource "admin-school-campus-contact"
  end


  context 'new', :js => true do
    before do
      contact_type
      visit gaku.admin_school_campus_path(school, school.campuses.first)
      click new_link
      wait_until_visible submit
    end

    it "creates and shows" do
      expect do
        select 'email', :from => 'contact_contact_type_id'
        fill_in "contact_data", :with => "The contact data"
        fill_in "contact_details", :with => "The contact details"
        click submit
        wait_until_invisible form
      end.to change(school.campuses.first.contacts, :count).by 1

      page.should have_content "The contact data"
      page.should have_content "The contact details"
      within(count_div) { page.should have_content 'Contacts list(1)' }
      flash_created?
    end

    it 'cancels creating', :cancel => true do
      ensure_cancel_creating_is_working
    end
  end

  context "existing", :js => true do
    before do
      school.campuses.first.contacts << contact
    end

    context 'edit' do
      before do
        contact_type
        visit gaku.admin_school_campus_path(school, school.campuses.first)
        click edit_link
        wait_until_visible modal
      end

      it "edits" do
        fill_in 'contact_data', :with => 'example@genshin.org'
        click submit

        wait_until_invisible modal
        page.should have_content 'example@genshin.org'
        flash_updated?
      end

      it 'cancels editting', :cancel => true do
        ensure_cancel_modal_is_working
      end
    end

    it "sets as primary" do

      school.campuses.first.contacts << contact2

      visit gaku.admin_school_campus_path(school, school.campuses.first)

      school.campuses.first.contacts.first.is_primary? == true
      school.campuses.first.contacts.second.is_primary? == false

      within('table#admin-school-campus-contacts-index tr#contact-2') { click_link 'set-primary-link' }
      accept_alert

      school.campuses.first.contacts.first.is_primary? == false
      school.campuses.first.contacts.second.is_primary? == true
    end

    it "deletes" do
      visit gaku.admin_school_campus_path(school, school.campuses.first)

      within(count_div) { page.should have_content 'Contacts list(1)' }
      page.should have_content(contact.data)

      expect do
        ensure_delete_is_working
      end.to change(school.campuses.first.contacts, :count).by -1

      page.should_not have_content(contact.data)
      within(count_div) { page.should_not have_content 'Contacts list(1)' }
      flash_destroyed?
    end
  end
end
