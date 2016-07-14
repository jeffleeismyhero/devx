Devx::Article.all.try(:each) do |a|

  case a.tag_list.first
  when 1
    a.tag_list = 'Brothers of the Sacred Heart'
  when 2
    a.tag_list = 'Academics'
  when 4
    a.tag_list = 'Admissions'
  when 'Test'
    puts 'found one'
    a.tag_list = 'Testing'
  else
    puts "failed to find one for #{a}"
  end
  a.save
end