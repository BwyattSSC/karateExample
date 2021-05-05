# Modification from From: https://github.com/intuit/karate/blob/master/karate-demo/src/test/java/demo/graphql/graphql.feature
# Orginal (defuncted): https://graphql-pokemon.now.sh
# New: https://graphql-pokeapi.vercel.app/api/graphql

Feature: test graphql end point

  Background:
    * def demoBaseUrl = 'https://graphql-pokeapi.vercel.app/api'
    * url demoBaseUrl + '/graphql'
    # this live url should work if you want to try this on your own
    # * url 'https://graphql-pokeapi.vercel.app/api'

  Scenario: simple graphql request
    # note the use of text instead of def since this is NOT json
    Given text query =
    """
    {
      pokemon(name: "pikachu") {
        id
        name
        moves {
          move {
            name
          }
        }
      }
    }
    """
    And request { query: '#(query)' }
    When method post
    Then status 200

    # pretty print the response
    * print 'response:', response

    # json-path makes it easy to focus only on the parts you are interested in
    # which is especially useful for graph-ql as responses tend to be heavily nested
    # '$' happens to be a JsonPath-friendly short-cut for the 'response' variable
    * match $.data.pokemon.id == 25
    * match $.data.pokemon.name == 'pikachu'

    # the '..' wildcard is useful for traversing deeply nested parts of the json
    * def moves = get[0] response..moves
    * match moves contains { "move": { "name": 'thunderbolt' } }

  # # TODO: Update feature once the API's variable feature is fixed
  # Scenario: graphql from a file and variables
    # here the query is read from a file
    # note that the 'replace' keyword (not used here) can also be very useful for dynamic query building
    # Given def query = read('./queries/attacks-by-name.graphql')
    # And def variables = { name: 'Charmander' }
    # And request { query: '#(query)', variables: '#(variables)' }
    # When method post
    # Then status 200

#    * def expected = [{ name: 'Flame Burst', type: 'Fire', damage: 30 }, { name: 'Flamethrower', type: 'Fire', damage: 55 }, { name: 'Flame Charge', type: 'Fire', damage: 25 }]
#    # this one liner does quite a lot! Note how the order of elements in teh above array does not matter
#    * match $.data.pokemon contains { number: '004', name: 'Charmander', attacks: { special: '#(^expected)' } }
