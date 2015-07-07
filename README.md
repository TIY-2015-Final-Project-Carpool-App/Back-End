# API Documentation for Carpool-App

## Table of Contents
1. [Pagination](#pagination)
2. [User Model](#user-model)
  * [Index](#users-index)
  * [Register](#register-user)
  * [Show User](#show-a-user)
  * [Update](#update-a-user)
  * [Login](#user-login)
  * [Delete](#delete-a-user)

## **Pagination**
All request methods that have pagination implemented in its use will will state "***Pagination Enabled***" in its description. If no 'page' or 'per' parameter is specified, the API will automatically apply its default. These parameters are passed in the path as a query or in the JSON request.

**Parameters**

Name | Default | Description
--- | --- | ---
page | 1 | **Optional.** Set the page of data to access.
per | 25 | **Optional.** Set how many items will be retrieved per page.

**Example Path**

`GET '/users?page=4&per=50'`

OR

`GET '/users?page=4'`

## **User Model**

#### Users Index

***Pagination Enabled:***
List of all users in the database.

Path:
`GET '/users'`

**Parameters**
*None*

**Status Codes**

Code | Type | Description
---|---|---
200 | Success | All posts were successfully returned.
204 | Success | The server successfully processed the request, but not content was returned due to an empty database.

**Example Response**

```
[
  {
    "id": 1,
    "username": "LilDebbie",
    "full_name": "Lil",
    "last_name": "Debbie",
    "address": "10260 McKee Road, Collegedale, TN 37315",
    "phone_number": "800-522-4499",
    "email": "lil@debbie.com"
    "avatar": "https://i.imgur.com/KOoBDaKb.jpg"
  },
  {
    "id": 2,
    "username": "HostTwinkies",
    "full_name": "Hostess",
    "last_name": "Twinkies",
    "address": "1010 Cake Road, Kansas City, MO",
    "phone_number": "800-876-3942",
    "email": "twinkie@hostess.com"
    "avatar": ""
  }
]

```

#### Register User

Allows the registration of a new user.

Path:
`POST '/users'`

**Parameters**

Name | Type | Description
--- | --- | ---
username | string | **Required.** Unique username for a new user.
password | string | **Required.** Password provided must be at least 6 characters long.
first_name | string | **Required.** First name of the user.
last_name | string | **Required.** Last name of the user.
email | string | **Required.** User's contact email.
address | string | **Optional.** Address of the user's desired location.
phone_number | string | **Optional.** User's contact number.
avatar | string | **Optional.** User's profile picture image link.

**Status Codes**

Code | Type | Description
---|---|---
201 | Success | Server has processed the request and has successfully created the user.
422 | Error | Unprocessable Entry. Specified parameters are invalid.

**Example Input**

```
{
  "username": "LilDebbie",
  "password": "secretpassword",
  "full_name": "Lil",
  "last_name": "Debbie",
  "address": "10260 McKee Road, Collegedale, TN 37315",
  "phone_number": "800-522-4499",
  "email": "lil@debbie.com"
  "avatar": "https://i.imgur.com/KOoBDaKb.jpg",
}
```

**Example Response**

```
[
  {
    "id": 1,
    "username": "LilDebbie",
    "full_name": "Lil",
    "last_name": "Debbie",
    "address": "10260 McKee Road, Collegedale, TN 37315",
    "phone_number": "800-522-4499",
    "email": "lil@debbie.com"
    "avatar": "https://i.imgur.com/KOoBDaKb.jpg",
    "access_token": "1af17e73721dbe0c40011b82ed4bb1a7dbe3ce29"
  }
]
```

#### Show a User

Shows the attributes of a specified user.

Path:
`GET '/user/:username'`

**Parameters**
*None*

Code | Type | Description
---|---|---
200 | Success | Server successfully requested returned post data.
400 | Error | Bad Request. Specified parameters do not match.

**Example Response**

```
[
  {
    "id": 1,
    "username": "LilDebbie",
    "full_name": "Lil",
    "last_name": "Debbie",
    "address": "10260 McKee Road, Collegedale, TN 37315",
    "phone_number": "800-522-4499",
    "email": "lil@debbie.com"
    "avatar": "https://i.imgur.com/KOoBDaKb.jpg"
  }
]
```

#### Update a User

Updates the specified attributes of a user. Forms should include all required fields to be passed with the request.

Path:
`PUT '/user/:username'`

**Parameters**

Name | Type | Description
--- | --- | ---
username | string | **Required.** Unique username for a new user.
password | string | **Required.** Password provided must be at least 6 characters long.
first_name | string | **Required.** First name of the user.
last_name | string | **Required.** Last name of the user.
email | string | **Required.** User's contact email.
address | string | **Optional.** Address of the user's desired location.
phone_number | string | **Optional.** User's contact number.
avatar | string | **Optional.** User's profile picture image link.

**Status Codes**

Code | Type | Description
---|---|---
200 | Success | Server has processed the request and has successfully updated the user.
422 | Error | Unprocessable Entry. Specified parameters are invalid.

**Example Input**

```
{
  "username": "LilDebbie",
  "password": "newsecretpassword",
  "full_name": "Lil",
  "last_name": "Teddie",
  "address": "10260 McKee Road, Collegedale, TN 37315",
  "phone_number": "800-522-4499",
  "email": "lil@debbie.com"
  "avatar": "https://i.imgur.com/KOoBDaKb.jpg"
}
```

**Example Response**

```
[
  {
    "id": 1,
    "username": "LilDebbie",
    "full_name": "Lil",
    "last_name": "Teddie",
    "address": "10260 McKee Road, Collegedale, TN 37315",
    "phone_number": "800-522-4499",
    "email": "lil@debbie.com"
    "avatar": "https://i.imgur.com/KOoBDaKb.jpg"
  }
]
```

#### User Login

Allows the login of a user to supply an access token.

Path: 
`POST '/users/login'`

**Parameters**

Name | Type | Description
--- | --- | ---
username | string | User's username as specified in the database.
password | string | User's password as specified in the database.

**Status Codes**

Code | Type | Description
---|---|---
201 | Success | Server has processed the request and has successfully supplied the user with an access token.
401 | Error | Unauthorized. Incorrect username and/or password combination.

**Example Input**

```
{
  "username": "LilDebbie",
  "password": "secretpassword"
}
```

**Example Response**

```
{
  "id": 1
  "username": "LilDebbie",
  "email": "lil@debbie.com",
  "access_token": "1af17e73721dbe0c40011b82ed4bb1a7dbe3ce29"
}
```

#### Delete a User

Deletes a specified user's account.

Path: 
`DELETE '/user/:username'`

**Params**
*None*

Code | Type | Description
---|---|---
204 | Success | Request was received and deleted successfully.
400 | Error | Bad Request. Specified parameters do not match.
401 | Error | Unauthorized. A different user is not authorized to delete another user's account.

**Example Response**

```
No message is returned. 
```




