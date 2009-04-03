module NavigationHelpers
  def path_to(page_name)
    case page_name

    when /home/
      '/'

    when /new post/
      '/posts/new'

    when /sign in/
      '/sessions/new'

    else
      raise "Can't find mapping from \"#{page_name}\" to a path."
    end
  end
end

World do |world|
  world.extend NavigationHelpers
  world
end
