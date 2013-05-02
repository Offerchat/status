ActiveAdmin::Dashboards.build do
  section "Automatic Announcements" do
    table_for Announcement.where(:auto => true).order("created_at desc").group(:title) do
      column :title
      column :body
    end
  end # content

  section "Recent Announcements" do
    table_for Announcement.where(:auto => false).order("created_at desc").limit(5) do
      column :title
      column :body
    end
    strong { link_to "Make an Announcement", new_admin_announcement_path }
  end # content

end