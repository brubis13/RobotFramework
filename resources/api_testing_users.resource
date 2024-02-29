*** Settings ***
Library    RequestsLibrary   
Library    String
Library    Collections

*** Keywords ***
Create a new user
    ${RANDOM_WORD}    Generate Random String    length=4    chars=[LETTERS]
    ${RANDOM_WORD}    Convert To Lower Case    ${RANDOM_WORD}
    Set Test Variable    ${EMAIL}    ${RANDOM_WORD}@emailtest.com
    Log    ${EMAIL}

Registering a user using the ServeRest API
    ${BODY}    Create Dictionary    
    ...    nome=Bruna Neves    
    ...    email=${EMAIL}    
    ...    password=1234    
    ...    administrador=true  
    Log    ${BODY}

    Create Session in ServeRest

    ${RESP}    POST On Session    
    ...    alias=ServeRest
    ...    url=/usuarios
    ...    json=${BODY}
    Log    ${RESP.json()}
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