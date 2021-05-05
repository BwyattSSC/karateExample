Feature: Verify JSON Structure

  Background:
    * url 'https://swapi.dev/api'

  Scenario Outline: Verify return types
    * def structure = read('./JsonStructure/<endPoint>.json')

    Given path '<endPoint>', 1
    When method get
    Then status 200
    And match response contains structure

    Examples:
    | endPoint |
    | people   |
    | planets  |

