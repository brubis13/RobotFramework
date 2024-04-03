*** Settings ***
Resource    ../resources/api_testing_users.resource

*** Variables ***


*** Test Cases ***

Scenario 01: Registering a New User Successfully in ServeRest
    Create a new user
    Registering a user using the ServeRest API      email=${EMAIL_TEST}     status_code=201
    Check if the user was registered correctly

Scenario 02: Registering an existing user
    Create a new user
    Registering a user using the ServeRest API      email=${EMAIL_TEST}    status_code=201
    Repeat user registrantion
    Check if the API did not register a repeat user

Scenario 03:
    Create a new user
    Registering a user using the ServeRest API      email=${EMAIL_TEST}    status_code=201
    Query data for a new user
    Verify returned data

Scenario 04: Logging in
    Create a new user
    Registering a user using the ServeRest API      email=${EMAIL_TEST}     status_code=201
    Logging in the system    email=${EMAIL_TEST}    password=1234
