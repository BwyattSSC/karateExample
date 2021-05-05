# Commented sections are broken at the moment...

Feature: Simple Karate example

  Background:
    * url 'https://pokeapi.co/api/v2'

  Scenario: get stats about pikachu
    Given path 'pokemon', 'pikachu'
    When method get
    Then status 200
    And match $.name == 'pikachu'

    # Actual
    * def stats = $.stats
    * def statNames = $.stats..name
    * def statSpeed = get[0] $.stats..stat[?(@.name=='speed')].name
    * def statSpecialDefense = get[0] $.stats..stat[?(@.name=='special-defense')].name
    * def statSpecialAttack = get[0] $.stats..stat[?(@.name=='special-attack')].name

    # Assert
    * match statSpeed == 'speed'
    * match statSpecialDefense == 'special-defense'
    * match statSpecialAttack == 'special-attack'
