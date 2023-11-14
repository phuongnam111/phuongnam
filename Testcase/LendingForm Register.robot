*** Settings ***
Library     SeleniumLibrary
Library     OperatingSystem
Library     Process
Library     MongoDBLibrary
Library     String
Library     RobotMongoDBLibrary.Delete

*** Variables ***
${BROWSER}              Firefox
${URL}                  https://lending-dev.kiotfinance.vn/application-form
${Driver_Path}          D:\geckodriver.exe
# ${MDBHost}    admin:f6XPinsVTx@10.24.22.32
# ${MDBPort}    ${27017}
# ${MONGODB_URL}    mongodb://admin:f6XPinsVTx@10.24.22.32:27017/?readPreference=primary&directConnection=true&ssl=false
${retailer_name}        linhvd1
${Username}             admin
${Password}             123
${phone}                0988888888
${fullname}             Autotest
${identifyNumber}       001454654
${birthday}             12/10/2000
${address}              Automation test is running
${businessName}         $smaker
${locator}              An Giang
${amount}               500000000
${time}                 12 tháng
${purpose}              Nhập thêm hàng hóa
${gender}               Nam
${DBName}               merchants
${CollectionName}       lending_forms


*** Test Cases ***
Lending Form
    [Documentation]    Lending form Register step
    # Connect To MongoDB    ${MONGODB_URL} ${DBName}
    # ${collection}    Get Mongodb Collections    ${CollectionName}
    # ${query}    Set Variable    {"merchant_id": 3365}
    # Delete One    ${collection}    ${query}
    # openbrowser
    Open Browser    ${URL}    browser=${BROWSER}    executable_path=${Driver_Path}
    Maximize Browser Window
    #Set Window Size    1920    1080
    Input Text    //input[@id='RetailerCode']    ${retailer_name}
    Input Text    //input[@id='UserName']    ${Username}
    Input Text    //*[@id='Password']    ${Password}
    Click Button    //*[@name='quan-ly']
    ### pick loan packaged
    # Waiting for Element
    Sleep    2s
    Input Text    //*[@id='amount']    ${amount}
    # time to loan
    Sleep    1s
    Click Element    //*[@id="amountOfTime"]
    Sleep    1s
    Click Element    //div[contains(text(),'200 tháng')]
    # pick loan purpose
    Click Element    //*[@id="purpose"]
    Click Element    //div[contains(text(),'Mua thêm thiết bị')]
    # next screen - next step
    Click Button    //*[@type='submit']
    # enter fullname
    Input Text    //*[@id='fullName']    ${fullname}
    # enter indentify number
    Input Text    //*[@id='identifyNumber']    ${identifyNumber}
    # enter birthday
    Input Text    //*[@id='birthday']    ${birthday}
    # enter gender
    Click Element    //div[@class=' css-mqrcsz']
    Click Element    //div[contains(text(),'Nam')]
    Sleep    0.5s
    # enter phone number
    Input Text    //*[@id='phone']    ${phone}
    # next srceen
    Click Button    //*[@type='submit']
    # enter bussiness name
    Input Text    //*[@id='businessName']    ${businessName}
    # enter address
    Input Text    //*[@id='address']    ${address}
    # pick locator
    Sleep    1s
    Click Element    //*[@id="__next"]/div/main/div/form/div[2]/div[3]/div/div
    Click Element    //div[contains(text(),'An Giang - Huyện Phú Tân')]
    # pick ward
    Click Element    //*[@id="__next"]/div/main/div/form/div[2]/div[4]/div/div
    Click Element    //div[contains(text(),'Thị trấn Phú Mỹ')]
    # next srceen
    Click Button    //*[@type='submit']
    # click confirm lending form
    # Scroll Element Into View    //span[@class='text-text-primary-default']
    Execute JavaScript    window.scrollTo(0, 400);
    Sleep    1s
    Click Element    //*[@class='chakra-checkbox__control css-14kn98t']
    Click Element    //button[contains(text(),'Xác nhận')]
    # verify contain lendingform
    Click Element    //button[contains(text(),'Xem lại hồ sơ')]
    ##check content
    ${Loanprofile_contain} =    Run Keyword And Return Status
    ...    Element Should Be Visible
    ...    //p[contains(text(),'Hồ sơ đăng ký vay')]
    IF    ${Loanprofile_contain}
        Log    Content had exists
    ELSE
        Log    Content does not exist
    END
    Sleep    1s
    # check button Loan register exits
    # verify done
    Execute JavaScript    window.scrollTo(0, 400);
    # back to final screen
    Click Element    //button[contains(text(),'Xác nhận')]
    # check btn done
    ${register_confirm} =    Run Keyword And Return Status
    ...    Element Should Be Visible
    ...    //p[contains(text(),'Hoàn thành đăng ký')]
    IF    ${register_confirm}
        Log    Content had exists
    ELSE
        Log    Content does not exist
    END
    Sleep    1s
    Close All Browsers
