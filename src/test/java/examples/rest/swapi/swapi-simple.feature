Feature: Simple Karate example

  Background:
    * url 'https://swapi.dev/api'

  Scenario: get the id for Boba Fett
    Given path 'people', 22
    When method get
    Then status 200

    # Expected
    * def expected_films =
    """
    [
      "http://swapi.dev/api/films/2/",
      "http://swapi.dev/api/films/3/",
      "http://swapi.dev/api/films/5/"
    ]
    """

    # Assert
    * match $.name == 'Boba Fett'
    * match $.films == '#[3]'
    * match $.films == expected_films
