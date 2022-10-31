*** Settings ***
Library    SeleniumLibrary
Library    Collections
Test Setup    Start Broswer And Maximize
Test Teardown    Close Broswer Windows

*** Variables ***
${url}    https://uibank.uipath.com/register-account
${browser}    Chrome

*** Keywords ***
Start Broswer And Maximize
    Log To Console    "Opening Broswer"
    Open Browser    ${url}    ${browser}
    Maximize Browser Window

Close Broswer Windows
    Log To Console    "Closing Broswer"
    Close Browser

*** Test Cases ***
TC01 Check for the main heading of the form
    # Method 1
    Page Should Contain    Register
    # Method 2
    Element Text Should Be     xpath:/html/body/app-root/body/div/app-register/div/div[2]/h1    Register
    Log To Console  TEST PASSED

TC02 Check the availability of form input fields
    Page Should Contain Element    xpath://*[@id="firstName"]
    Page Should Contain Element    xpath://*[@id="title"]
    Page Should Contain Element    xpath://*[@id="middleName"]
    Page Should Contain Element    xpath://*[@id="lastName"]
    Page Should Contain Element    xpath://*[@id="sex"]
    Page Should Contain Element    xpath://*[@id="employmentStatus"]
    Page Should Contain Element    xpath://*[@id="age"]
    Page Should Contain Element    xpath://*[@id="maritalStatus"]
    Page Should Contain Element    xpath://*[@id="numberOfDependents"]
    Page Should Contain Element    xpath://*[@id="username"]
    Page Should Contain Element    xpath://*[@id="email"]
    Page Should Contain Element    xpath://*[@id="password"]
    Log To Console  TEST PASSED

TC03 Check the Placeholder of different input fields
    ${f_name}    Get Element Attribute    xpath://*[@id="firstName"]    placeholder
    Input Text    xpath://*[@id="firstName"]        ${f_name}
    ${m_name}   Get Element Attribute    xpath://*[@id="title"]    placeholder
    Input Text    xpath://*[@id="middleName"]        ${m_name}
    ${l_name}   Get Element Attribute    xpath://*[@id="lastName"]    placeholder
    Input Text    xpath://*[@id="middleName"]        ${l_name}
    ${age}   Get Element Attribute    xpath://*[@id="age"]    placeholder
    Input Text    xpath://*[@id="age"]        ${age}
    ${numberOfDependents}   Get Element Attribute    xpath://*[@id="numberOfDependents"]    placeholder
    Input Text    xpath://*[@id="numberOfDependents"]        ${numberOfDependents}
    ${username}   Get Element Attribute    xpath://*[@id="username"]    placeholder
    Input Text    xpath://*[@id="username"]        ${username}
    ${email}   Get Element Attribute    xpath://*[@id="email"]    placeholder
    Input Text    xpath://*[@id="email"]        ${email}
    ${password}   Get Element Attribute    xpath://*[@id="password"]    placeholder
    Input Text    xpath://*[@id="password"]        ${password}
    Log To Console  TEST PASSED

TC04 Check the Title field for given list items
    @{titles}    Get List Items  xpath://*[@id="title"]
    ${fisrtTitle}    Get From List    ${titles}    0
    ${secondTitle}    Get From List    ${titles}    1
    ${thirdTitle}    Get From List    ${titles}    2
    Should Be Equal    ${fisrtTitle}    Ms
    Should Be Equal    ${secondTitle}    Mrs
    Should Be Equal    ${thirdTitle}    Mr
    Log To Console  TEST PASSED

TC05 Check the Sex Field for given list items
    @{genders}    Get List Items  xpath://*[@id="sex"]
    ${male}    Get From List    ${genders}    0
    ${female}    Get From List    ${genders}    1
    Should Be Equal    ${male}    Male
    Should Be Equal    ${female}    Female
    Log To Console  TEST PASSED

TC06 Check the Employment Status Field
    ${employmentStatus}  Get Webelement  xpath://*[@id="employmentStatus"]
    Should Be Equal    ${employmentStatus.tag_name}    select
    Log To Console  TEST PASSED

TC07 Check the Marital Status Field
    @{maritalStatus}    Get List Items  xpath://*[@id="maritalStatus"]
    ${listSize}    Get Length    ${maritalStatus}
    should be equal as numbers  ${listSize}  4
    Log To Console  TEST PASSED

TC08 Check the Email Field
    ${email}    Get Element Attribute    xpath://*[@id="email"]    type
    Should Be Equal    ${email}    email
    Log To Console  TEST PASSED

TC09 Check the Password Field
    ${password}    Get Element Attribute    xpath://*[@id="password"]    type
    Should Be Equal    ${password}    password
    Log To Console  TEST PASSED

TC10 Submit the form with test data and verify the result

    Input Text    xpath://*[@id="firstName"]        Thawar
    Select From List By Index    xpath://*[@id="title"]  2
    Input Text    xpath://*[@id="middleName"]        T
    Input Text    xpath://*[@id="lastName"]        Das
    Select From List By Index    xpath://*[@id="sex"]  0
    Select From List By Index    xpath://*[@id="employmentStatus"]  0
    Input Text    xpath://*[@id="age"]        22
    Select From List By Index    xpath://*[@id="maritalStatus"]  0
    Input Text    xpath://*[@id="numberOfDependents"]        0
    Input Text    xpath://*[@id="username"]        Thawar22
    Input Text    xpath://*[@id="email"]        thawar@gmail.com
    Input Text    xpath://*[@id="password"]        123456
    Click Button    xpath:/html/body/app-root/body/div/app-register/div/div[2]/form/button
    Wait Until Element Contains  xpath:/html/body/app-root/body/div/app-register-success/div[1]/div/div[3]/div/h2    Welcome To The UiBank Family!
    Log To Console  TEST PASSED