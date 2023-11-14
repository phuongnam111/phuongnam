*** Settings ***
Library     SeleniumLibrary
Library     OperatingSystem
Library     Process
Resource    Enviroments.robot

*** Variables ***
${retailer_name}    testz9
${Username}         admin
${Password}         123

*** Test Cases ***
Login to Store
    [Documentation]    Login to the online store.
    Open Browser    ${FORMLIVE}    browser=${BROWSER}    executable_path=${Driver_Path}
    Maximize Browser Window
    Input Text    //input[@id='RetailerCode']    ${retailer_name}
    Input Text    //input[@id='UserName']    ${Username}
    Input Text    //*[@id='Password']    ${Password}
    Click Button    //*[@name='quan-ly']

    # check presanning notification
    Element Should Be Visible
    ...    //*[contains(text(),'Chưa đủ điều kiện vay vốn. Vui lòng liên hệ tổng đài 1800 6162 để được tư vấn.')]
    ${banner_text} =    Get Text
    ...    //*[contains(text(),'Chưa đủ điều kiện vay vốn. Vui lòng liên hệ tổng đài 1800 6162 để được tư vấn.')]
    Should Be Equal    ${banner_text}    Chưa đủ điều kiện vay vốn. Vui lòng liên hệ tổng đài 1800 6162 để được tư vấn.
    Sleep    2s
    Close All Browsers
