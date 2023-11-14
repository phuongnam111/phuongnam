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
    # login
    Input Text    //*[@id='RetailerCode']    ${retailer_name}
    Input Text    //input[@id='UserName']    ${Username}
    Input Text    //*[@id='Password']    ${Password}
    Click Button  //*[@name='quan-ly']
    Wait Until Element Is Visible  //button[contains(@class, 'bg-support-warning-500') and text()='Thử lại']
    Click Button    //button[contains(@class, 'bg-support-warning-500') and text()='Thử lại']
    # Merchant = No revenue 6 month
    Element Should Be Visible    //p[contains(text(),'Không tải được dữ liệu')]
    ${banner_text} =    Get Text    //p[contains(text(),'Không tải được dữ liệu')]
    Should Be Equal    ${banner_text}    Không tải được dữ liệu
    Sleep    2s
    # verify contain notification
    Element Should Be Visible
    ...    //p[contains(text(),"Nhấn Thử lại hoặc quay lại sau vài phút. Nếu dữ liệu vẫn không hiển thị, hãy liên hệ tổng đài 1900 6522 để được hỗ trợ")]
    ${banner_notifi} =    Get Text
    ...    //p[contains(text(),'Nhấn Thử lại hoặc quay lại sau vài phút. Nếu dữ liệu vẫn không hiển thị, hãy liên hệ tổng đài 1900 6522 để được hỗ trợ')]
    Should Be Equal
    ...    ${banner_notifi}
    ...    Nhấn Thử lại hoặc quay lại sau vài phút. Nếu dữ liệu vẫn không hiển thị, hãy liên hệ tổng đài 1900 6522 để được hỗ trợ
    Close Browser
