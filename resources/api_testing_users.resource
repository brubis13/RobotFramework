*** Settings ***
Library    RequestsLibrary   
Library    String
Library    Collections

*** Keywords ***
Create a new user
    ${RANDOM_WORD}    Generate Random String    length=4    chars=[LETTERS]
    ${RANDOM_WORD}    Convert To Lower Case    ${RANDOM_WORD}
    Set Test Variable    ${EMAIL_TEST}    ${RANDOM_WORD}@emailtest.com
    Log    ${EMAIL_TEST}

Registering a user using the ServeRest API
    [Arguments]    ${email}    ${status_code}
    ${BODY}    Create Dictionary    
    ...    nome=Bruna Neves    
    ...    email=${EMAIL_TEST}    
    ...    password=1234    
    ...    administrador=true  
    Log    ${BODY}

    Create Session in ServeRest

    ${RESP}    POST On Session    
    ...    alias=ServeRest
    ...    url=/usuarios
    ...    json=${BODY}
    ...    expected_status=${status_code}
    Log    ${RESP.json()}
    IF    ${RESP.status_code} == 201
            Set Test Variable    ${ID_USER}    ${RESP.json()["_id"]}
    END
    Set Test Variable    ${RESPONSE}    ${RESP.json()}
    
Create Session in ServeRest
    ${HEADERS}    Create Dictionary
    ...    accept=application/json
    ...    Content-Type=application/json
    Create Session    alias=ServeRest    url=https://serverest.dev    headers=${HEADERS}

Check if the user was registered correctly
    Log    ${RESPONSE}
    Dictionary Should Contain Item    ${RESPONSE}    message    Cadastro realizado com sucesso
    Dictionary Should Contain Key    ${RESPONSE}    _id

Repeat user registrantion
    Registering a user using the ServeRest API    email=${EMAIL_TEST}    status_code=400

Check if the API did not register a repeat user
    Dictionary Should Contain Item    ${RESPONSE}    message    Este email já está sendo usado

Query data for a new user
    ${response_query}    GET On Session    alias=ServeRest    url=/usuarios/${ID_USER}
    Set Test Variable    ${resp_query}    ${response_query.json()}

Verify returned data
    Log   ${resp_query}
    Dictionary Should Contain Item    ${resp_query}    nome            Bruna Neves
    Dictionary Should Contain Item    ${resp_query}    email           ${EMAIL_TEST}
    Dictionary Should Contain Item    ${resp_query}    password        1234
    Dictionary Should Contain Item    ${resp_query}    administrador   true
    Dictionary Should Contain Item    ${resp_query}    _id             ${ID_USER}
    