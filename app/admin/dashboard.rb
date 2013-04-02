ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do
    # div :class => "blank_slate_container", :id => "dashboard_default_message" do
    #   span :class => "blank_slate" do
    #     span "Welcome to Active Admin. This is the default dashboard page."
    #     small "To add dashboard sections, checkout 'app/admin/dashboards.rb'"
    #   end
    # end

    columns do
      olympiad = Olympiad.next_olympiad
      olympiad.teams.each do |team|
        column do
          h2 :style=>"color:#{team.color1_code};" do
            span team.name
          end
          panel "Athletes (#{team.athletes.count})" do
            team.registrations.where(:athlete=>true).order(:uniform_number).each do |r|
              span reg_icon(r)
            end
          end # panel
          panel "Fans/Supporters (#{team.supporters.count})" do
            ul do
              team.supporters.each do |u|
                li u.name
              end
            end
          end # panel
        end # column
      end # Teams.each
      column do
        h2 "Unaffiliated"
        panel "Users (#{olympiad.unsigned_users.count})" do
          ul do
            olympiad.unsigned_users.each do |u|
              li u.name
            end
          end
        end # panel
      end # column
    end # columns

  end # content

end
