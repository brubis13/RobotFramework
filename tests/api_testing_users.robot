*** Settings ***
Resource    ../resources/api_testing_users.resource

*** Variables ***


*** Test Cases ***

Scenario 01: Registering a New User Successfully in ServeRest
    Create a new user
    Registering a user using the ServeRest API
    Check if the user was registered correctly
