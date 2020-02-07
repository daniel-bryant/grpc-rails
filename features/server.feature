Feature: Server
  In order to accept grpc calls
  As a CLI
  I want to start a grpc server

  Scenario: Running the server
    When I run `grpc-rails server`
    Then the output should contain "The server must be run from a Rails directory."

  Scenario: Running the server, shorthand
    When I run `grpc-rails s`
    Then the output should contain "The server must be run from a Rails directory."
