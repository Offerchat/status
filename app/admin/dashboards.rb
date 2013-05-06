ActiveAdmin::Dashboards.build do
  section "Automatic Announcements" do
    autos = Announcement.select('DISTINCT Announcements.title, Announcements.body').where(:auto => true)
    unless autos.blank?
      table_for auto do
        column :title
        column :body
      end
    end
  end # content

  section "Recent Announcements" do
    announcements = Announcement.where(:auto => false).order("created_at desc").limit(5)
    unless announcements.blank?
      table_for announcements do
        column :title
        column :body
      end    
    end
    strong { link_to "Make an Announcement", new_admin_announcement_path }
  end # content

end