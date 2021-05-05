# From: https://github.com/intuit/karate/blob/master/karate-demo/src/test/java/demo/graphql/graphql.feature


# TODO: Update feature once the API's variable feature is fixed
  # Feature: test graphql end point

    # Background:
    # * def demoBaseUrl = 'https://graphql-pokemon.now.sh'
    # * url demoBaseUrl + '/graphql'
    # this live url should work if you want to try this on your own
    # * url 'https://graphql-pokemon.now.sh'

  # Scenario Outline: graphql from a file and variables
    # here the query is read from a file
    # note that the 'replace' keyword (not used here) can also be very useful for dynamic query building
    # Given def query = read('./queries/evolutions-by-name.graphql')
    # And def variables = { name: '<name>' }
    # And request { query: '#(query)', variables: '#(variables)' }
    # When method post
    # Then match $.data.pokemon.name == '<name>'
    # And match $.data.pokemon.number == '<number>'
    # And match $.data.pokemon.evolutions == '#null'

    Examples:
    | name          | number  |
    | Lapras        | 131     |
    | Aerodactyl    | 142     |
    | Mewtwo        | 150     |

