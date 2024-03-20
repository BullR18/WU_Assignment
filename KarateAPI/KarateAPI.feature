Feature: API testing using Karate
  Background:
    * url 'https://restful-booker.herokuapp.com'
    Given path '/auth'
    And request {"username" : "admin","password" : "password123"}
    And header Content-Type = 'application/json'
    When method POST
    Then status 200

    * def token = response.token

    * print 'Value of the token ' + token

  Scenario: Verify whether data being retried from server using GET method
    Given path '/booking'
    When method GET
    Then status 200
    * print response

  Scenario: Verify whether data being created using POST method
    Given path '/booking'
    And header Content-Type = 'application/json'
    And header accept = 'application/json'
    #And request read ('classpath:data/post.json')
    And request
    """
    {
    "firstname" : "Jim",
    "lastname" : "Brown",
    "totalprice" : 111,
    "depositpaid" : true,
    "bookingdates" : {
        "checkin" : "2018-01-01",
        "checkout" : "2019-01-01"
    },
    "additionalneeds" : "Breakfast"
    }
    """
    When method POST
    Then status 200
    * print response


  Scenario: Verify whether data being updated to server using PUT method
    Given path '/booking/:id'
    And header Authorization = 'Bearer' + token
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    #And header Cookie = 'token=abc123'
    And request
    """
    {
    "firstname" : "James",
    "lastname" : "Brown",
    "totalprice" : 111,
    "depositpaid" : true,
    "bookingdates" : {
        "checkin" : "2018-01-01",
        "checkout" : "2019-01-01"
    },
    "additionalneeds" : "Breakfast"
}
    """
    When method PUT
    Then status 200
    * print response

  Scenario: Verify whether data being updated to server using PATCH method
    Given path '/booking/:id'
    And header Authorization = 'Bearer' + token
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And request
    """
    {
    "firstname" : "James",
    "lastname" : "Brown"
}
    """
    When method PATCH
    Then status 200
    * print response

  Scenario: Verify whether data being deleted from server using DELETE method
    Given path '/booking/1'
    And header Authorization = 'Bearer' + token
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    When method DELETE
    Then status 200
    * print response

