*** Settings ***
Library    RequestsLibrary   
Library    String

*** Keywords ***
Create a new user
    ${RANDOM_WORD}    Generate Random String    length=4    chars=[LETTERS]
    ${RANDOM_WORD}    Convert To Lower Case    ${RANDOM_WORD}
    Set Test Variable    ${EMAIL}    ${RANDOM_WORD}@emailtest.com
    Log    ${EMAIL}
    
    

