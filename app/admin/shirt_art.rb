ActiveAdmin.register_page "Shirt Art" do

  menu :priority => 10, :label => "Shirt Art", :parent=>"Dashboard"

  content :title => "Shirt Art" do

    olympiad = Olympiad.featured_olympiad(:registrations, :teams)
    olympiad.registrations.each do |r|
      span reg_icon(r, "double no-frills")
    end

  end # content

end
