Feature: Create posts

  As an author, I would like to create posts, so I can communicate to my
  readers.

  Scenario: Create a new post
    When I go to the new post page
    And I fill in "Title" with "A post title"
    And I fill in "body" with "A post body"
    And I press "Create Post"
    And I should see "A post title"
    And I should see "A post body"
