*** Settings ***
Library     SeleniumLibrary
Library     OperatingSystem
Library     DateTime
Library     Process
Library     DateTime
Library     String
Resource    Enviroments.robot

*** Variables ***
${BANNER_XPATH}         //*[@class='slick-slider kfin-slider slick-initialized']
${EXPECTED_WIDTH}       312
${EXPECTED_HEIGHT}      458

*** Test Cases ***
Login to Store banner check
    [Documentation]    Banner By Kfinace
    Log    Automation By Kfinace
    Open Browser    ${LIVE}    browser=${BROWSER}    executable_path=${Driver_Path}
    Maximize Browser Window
    # Saving Present Browser
    ${current_window}    Get Window Handles
    Set Suite Variable    ${current_window}    ${current_window[0]}
    # login.
    Input Text    //input[@id='UserName']    ${Username}
    Input Text    //*[@id='Password']    ${Password}
    Click Button    //*[@name='quan-ly']
    Sleep    2
    Wait Until Element Is Visible    //div[@class='kfin-touch-title-icon']
    # Wait banner kfinance touch
    Mouse Over    //div[@class='kfin-touch-title-icon']
    # click kfinance banner
    Click Element    //*[@class='kfin-name']
    Wait Until Page Contains Element    //*[@class='slick-slider kfin-slider slick-initialized']
    ${banner_size}    Get Element Size    ${BANNER_XPATH}
    # Banner size Log
    Log    Banner size true: ${EXPECTED_WIDTH} x ${EXPECTED_HEIGHT}
    Log    Banenr size present: ${banner_size}
    # Banner width
    ${width}    Set Variable    ${banner_size[0]}
    Should Be True    ${width}    > 0    # Width size
    Should Be Equal As Numbers    ${width}    ${EXPECTED_WIDTH}    Banner Width is true to size
    # Banenr height
    ${height}    Set Variable    ${banner_size[1]}
    Should Be True    ${height} > 0 #Height size
    Should Be Equal As Numbers    ${height}    ${EXPECTED_HEIGHT}    Banner Height is true to size
    # Checking banner detail
    # Btn register now exits
    # Check 1st Slide
    ${button_LoanManager}    Run Keyword And Return Status
    ...    Element Should Be Visible
    ...    (//*[@class='kfin-touch-btn' and text()='Đăng ký vay ngay'])
    IF    ${button_LoanManager}
        Log    Button exists
    ELSE
        Log    Button does not exist
    END
    Sleep    0.5
    # Check 2nd Slide
    Mouse Over    //*[@class='slick-slider kfin-slider slick-initialized']
    Click Element    //*[@class='slick-arrow slick-next']
    # Check btn Find'd more
    ${button_Findmore}    Run Keyword And Return Status
    ...    Element Should Be Visible
    ...    ((//*[@class='kfin-touch-btn' and text()='Tìm hiểu thêm'])[2])
    IF    ${button_Findmore}
        Log    Button exists
    ELSE
        Log    Button does not exist
    END
    # Link to lending form
    Click Element    (//*[@class='kfin-touch-btn' and text()='Tìm hiểu thêm'])[2]
    ${all_windows}    Get Window Handles
    IF    '${all_windows[0]}' != '${current_window[0]}'
        ${new_window}    Set Variable    ${all_windows[0]}
    ELSE
        ${new_window}    Set Variable    ${all_windows[1]}
    END
    # Lending form
    ${is_active}    Run Keyword And Return Status    Switch Window    ${new_window}
    IF    not ${is_active}    Fail    Failed to switch to the Lending Form
    # back to KF banner
    Switch Window    ${current_window}
    Wait Until Element Is Visible    //*[@class='slick-slider kfin-slider slick-initialized']
    Mouse Over    //*[@class='slick-slider kfin-slider slick-initialized']
    Click Element    //*[@class='slick-arrow slick-next']
    Wait Until Element Is Visible    //*[@class='kfin-touch-btn' and text()='Đăng ký vay ngay']
    Click Element    //*[@class='kfin-touch-btn' and text()='Đăng ký vay ngay']
    # lending form is show
    # Switch to lending form
    ${all_windows}    Get Window Handles
    IF    '${all_windows[0]}' != '${current_window[0]}'
        ${new_window}    Set Variable    ${all_windows[0]}
    ELSE
        ${new_window}    Set Variable    ${all_windows[1]}
    END
    Log    Kfin banner touch Stil Works Fine
    Close All Browsers
