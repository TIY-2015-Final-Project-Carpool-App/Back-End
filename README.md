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
3. [Child Model](#child-model)
  * [Index](#children-index)
  * [Create Child](#create-child)
  * [Show Child](#show-a-child)
  * [Update Child](#update-a-child)
  * [Delete Child](#delete-a-child)
4. [Medical Information Model](#medical-information-model)
  * [Show Medical Information](#show-medical-information)
  * [Create Medical Information](#create-medical-information)
  * [Update Medical Information](#update-medical-information)
  * [Delete Medical Information](#delete-medical-information)
5. [Contact Model](#contact-model)
  * [Contact Index for a Child](#contact-index-for-a-child)
  * [Contact Index for a User](#contact-index-for-a-user)
  * [Create Contact for Child](#create-contact-for-child)
  * [Create Contact for User](#create-contact-for-user)
  * [Update Contact](#update-contact)
  * [Delete Contact](#delete-contact)
6. [Carpool Model](#carpool-model)
  * [Carpools Index](#carpools-index)
  * [User's Carpools Index](#users-carpools-index)
  * [Show Carpool](#show-carpool)
  * [Create a Carpool](#create-a-carpool)
  * [Update a Carpool](#update-a-carpool)
  * [Delete a Carpool](#delete-a-carpool)
  * [Remove User from Carpool Group](#remove-user-from-carpool-group)
  * [User's Pending Invitations Index](#users-pending-invitations-index)
  * [Invite a User to Carpool](#invite-a-user-to-carpool)
  * [Activate an Invitation](#activate-an-invitation)
7. [Appointment Model](#appointment-model)
  * [Carpool Appointment Index](#carpool-appointment-index)
  * [User Appointment Index](#user-appointment-index)
  * [Show Appointment](#show-appointment)
  * [Create Appointment](#create-appointment)
  * [Update an Appointment](#update-an-appointment)
  * [Delete Appointment](#delete-appointment)
8. [Rider Model](#rider-model)
  * [Join Appointment (User)](#join-appointment-user)
  * [Join Appointment (Child)](#join-appointment-child)
  * [Update a User's Rider Role](#update-a-users-rider-role)
  * [Remove a User from Appointment](#remove-a-user-from-appointment)
  * [Remove a Child from Appointment](#remove-a-child-from-appointment)
9. [Post Model](#post-model)
  * [Carpool's Post Index](#carpools-post-index)
  * [Show a Post](#show-a-post)
  * [Create a Post](#create-a-post)
  * [Update a Post](#update-a-post)
  * [Delete a Post](#delete-a-post)


## **Pagination**
All request methods that have pagination implemented in its use will state "***Pagination Enabled***" in its description. If no 'page' or 'per' parameter is specified, the API will automatically apply its default. These parameters are passed in the path as a query or in the JSON request.

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
200 | Success | All users were successfully returned.
204 | Success | The server successfully processed the request, but not content was returned due to an empty database.

**Example Response**

```
[
  {
    "id": 1,
    "username": "LilDebbie",
    "first_name": "Lil",
    "last_name": "Debbie",
    "address": "10260 McKee Road, Collegedale, TN 37315",
    "phone_number": "800-522-4499",
    "email": "lil@debbie.com",
    "avatar": "https://i.imgur.com/KOoBDaKb.jpg",
    "latitude": 35.7719376,
    "longitude": 139.7156425
  },
  {
    "id": 2,
    "username": "HostTwinkies",
    "first_name": "Hostess",
    "last_name": "Twinkies",
    "address": "1010 Cake Road, Kansas City, MO",
    "phone_number": "800-876-3942",
    "email": "twinkie@hostess.com",
    "avatar": "",
    "latitude": 42.7719376,
    "longitude": 109.7156425
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
address | string | **Required.** Address of the user's desired location.
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
  "first_name": "Lil",
  "last_name": "Debbie",
  "address": "10260 McKee Road, Collegedale, TN 37315",
  "phone_number": "800-522-4499",
  "email": "lil@debbie.com",
  "avatar": "https://i.imgur.com/KOoBDaKb.jpg",
  "latitude": 35.7719376,
  "longitude": 139.7156425
}
```

**Example Response**

```
{
  "id": 1,
  "username": "LilDebbie",
  "first_name": "Lil",
  "last_name": "Debbie",
  "address": "10260 McKee Road, Collegedale, TN 37315",
  "phone_number": "800-522-4499",
  "email": "lil@debbie.com",
  "avatar": "https://i.imgur.com/KOoBDaKb.jpg",
  "access_token": "1af17e73721dbe0c40011b82ed4bb1a7dbe3ce29",
  "latitude": 35.7719376,
  "longitude": 139.7156425
}
```

#### Show a User

Shows the attributes of a specified user.

Path:
`GET '/user/:username'`

**Parameters**
*None*

Code | Type | Description
---|---|---
200 | Success | Server successfully requested returned user data.
400 | Error | Bad Request. Specified parameters do not match.

**Example Response**

```
{
  "id": 1,
  "username": "LilDebbie",
  "first_name": "Lil",
  "last_name": "Debbie",
  "address": "10260 McKee Road, Collegedale, TN 37315",
  "phone_number": "800-522-4499",
  "email": "lil@debbie.com",
  "avatar": "https://i.imgur.com/KOoBDaKb.jpg",
  "latitude": 35.7719376,
  "longitude": 139.7156425
}
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
address | string | **Required.** Address of the user's desired location.
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
  "first_name": "Lil",
  "last_name": "Teddie",
  "address": "10260 McKee Road, Collegedale, TN 37315",
  "phone_number": "800-522-4499",
  "email": "lil@debbie.com",
  "avatar": "https://i.imgur.com/KOoBDaKb.jpg",
}
```

**Example Response**

```
{
  "id": 1,
  "username": "LilDebbie",
  "first_name": "Lil",
  "last_name": "Teddie",
  "address": "10260 McKee Road, Collegedale, TN 37315",
  "phone_number": "800-522-4499",
  "email": "lil@debbie.com",
  "avatar": "https://i.imgur.com/KOoBDaKb.jpg",
  "latitude": 35.7719376,
  "longitude": 139.7156425
}
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

**Parameters**
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

## **Child Model**

#### Children Index

List of all children that are associated with a specific user.

Path:
`GET '/user/:username/children'`

**Parameters**
*None*

**Status Codes**

Code | Type | Description
---|---|---
200 | Success | All children were successfully returned.
400 | Error | Bad Request. Invalid parameters.

**Example Response**

```
[
  {
    "id": 1,
    "first_name": "Casa",
    "last_name": "Sanchez",
    "age": 7,
    "dob": "2007-12-01",
    "address": "10260 McKee Road, Collegedale, TN 37315",
    "phone_number": "800-522-4499",
    "height": 134,
    "weight": 100,
    "latitude": 35.7719376,
    "longitude": 139.7156425,
    "parent": {
      "id": 1,
      "username": "LilDebbie",
      "first_name": "Lil",
      "last_name": "Teddie",
      "address": "10260 McKee Road, Collegedale, TN 37315",
      "phone_number": "800-522-4499",
      "email": "lil@debbie.com",
      "avatar": "https://i.imgur.com/KOoBDaKb.jpg"
    }
  },
  {
    "id": 2,
    "first_name": "Lobos",
    "last_name": "Sanchez",
    "age": 8,
    "dob": "2006-11-01",
    "address": "10260 McKee Road, Collegedale, TN 37315",
    "phone_number": "800-522-4499",
    "height": 124,
    "weight": 95,
    "latitude": 35.7719376,
    "longitude": 139.7156425,
    "parent": {
      "id": 1,
      "username": "LilDebbie",
      "first_name": "Lil",
      "last_name": "Teddie",
      "address": "10260 McKee Road, Collegedale, TN 37315",
      "phone_number": "800-522-4499",
      "email": "lil@debbie.com",
      "avatar": "https://i.imgur.com/KOoBDaKb.jpg"
    }
  }
]
```

#### Create Child

Creates a child associated to a specifed user.

Path:
`POST '/children'`

**Parameters**

Name | Type | Description
--- | --- | ---
first_name | string | **Required.** Child's first name.
last_name | string | **Required.** Child's last name.
age | integer | Child's current age.
dob | string | Child's date of birth. If this parameter is used, the DD/MM/YYYY format **must** be used. The response for this parameter will be returned in the YYYY-MM-DD format.
address | string | Child's location to be picked up and dropped off.
phone_number | string | Child's phone number if applicable.
height | integer | Child's height in inches (in).
weight | integer | Child's weight in pounds (lb).
blood_type | string | Child's blood type.

**Status Codes**

Code | Type | Description
---|---|---
201 | Success | Server has processed the request and has successfully created the user.
422 | Error | Unprocessable Entry. Specified parameters are invalid.

**Example Input**

```
{
  "username": "LilDebbie",
  "first_name": "Jac",
  "last_name": "Nickelsen",
  "age": 10,
  "dob": "30/5/2005",
  "address": "10260 McKee Road, Collegedale, TN 37315",
  "phone_number": "800-522-4499"
}
```

**Example Response**

```
{
  "id": 1,
  "first_name": "Jac",
  "last_name": "Nickelsen",
  "age": 10,
  "dob": "2005-5-30",
  "address": "10260 McKee Road, Collegedale, TN 37315",
  "phone_number": "800-522-4499",
  "height": null,
  "weight": null,
  "latitude": 35.7719376,
  "longitude": 139.7156425,
  "parent": {
    "id": 1,
    "username": "LilDebbie",
    "first_name": "Lil",
    "last_name": "Teddie",
    "address": "10260 McKee Road, Collegedale, TN 37315",
    "phone_number": "800-522-4499",
    "email": "lil@debbie.com",
    "avatar": "https://i.imgur.com/KOoBDaKb.jpg"
  }
}
```

#### Show a Child

Shows the attributes of a specified child.

Path:
`GET '/child/:id'`

**Parameters**
*None*

**Status Codes**

Code | Type | Description
---|---|---
200 | Success | Server successfully requested returned child data.
400 | Error | Bad Request. Specified parameters do not match.

**Example Response**

```
{
  "id": 1,
  "first_name": "Casa",
  "last_name": "Sanchez",
  "age": 7,
  "dob": "2007-12-01",
  "address": "10260 McKee Road, Collegedale, TN 37315",
  "phone_number": "800-522-4499",
  "height": 134,
  "weight": 100,
  "latitude": 35.7719376,
  "longitude": 139.7156425,
  "parent": {
    "id": 1,
    "username": "LilDebbie",
    "first_name": "Lil",
    "last_name": "Teddie",
    "address": "10260 McKee Road, Collegedale, TN 37315",
    "phone_number": "800-522-4499",
    "email": "lil@debbie.com",
    "avatar": "https://i.imgur.com/KOoBDaKb.jpg"
  }
}
```

#### Update a Child

Updates the specified attributes of a child. Forms should include all required fields to be passed with the request.

Path:
`PUT '/child/:id'`

**Parameters**

Name | Type | Description
--- | --- | ---
first_name | string | **Required.** Child's first name.
last_name | string | **Required.** Child's last name.
age | integer | Child's current age.
dob | string | Child's date of birth. If this parameter is used, the DD/MM/YYYY format **must** be used. The response for this parameter will be returned in the YYYY-MM-DD format.
address | string | Child's location to be picked up and dropped off.
phone_number | string | Child's phone number if applicable.
height | integer | Child's height in inches (in).
weight | integer | Child's weight in pounds (lb).
blood_type | string | Child's blood type.

**Status Codes**

Code | Type | Description
---|---|---
200 | Success | Server has processed the request and has successfully updated the user.
422 | Error | Unprocessable Entry. Specified parameters are invalid.

**Example Input**

```
{
  "username": "LilDebbie",
  "first_name": "Jac",
  "last_name": "Nickelsen",
  "age": 10,
  "dob": "30/5/2005",
  "address": "10260 McKee Road, Collegedale, TN 37315",
  "phone_number": "800-522-4499"
}
```

**Example Response**

```
{
  "id": 1,
  "first_name": "Jac",
  "last_name": "Nickelsen",
  "age": 10,
  "dob": "2005-5-30",
  "address": "10260 McKee Road, Collegedale, TN 37315",
  "phone_number": "800-522-4499",
  "height": null,
  "weight": null,
  "latitude": 35.7719376,
  "longitude": 139.7156425,
  "parent": {
    "id": 1,
    "username": "LilDebbie",
    "first_name": "Lil",
    "last_name": "Teddie",
    "address": "10260 McKee Road, Collegedale, TN 37315",
    "phone_number": "800-522-4499",
    "email": "lil@debbie.com",
    "avatar": "https://i.imgur.com/KOoBDaKb.jpg"
  }
}
```

#### Delete a Child

Deletes a specified child.

Path: 
`DELETE '/child/:id'`

**Parameters**
*None*

**Status Codes**

Code | Type | Description
---|---|---
204 | Success | Request was received and deleted successfully.
400 | Error | Bad Request. Specified parameters do not match.
401 | Error | Unauthorized. A different user is not authorized to delete another user's child.

**Example Response**

```
No message is returned.
```

## **Medical Information Model**

#### Show Medical Information

Shows the medical information for a specified child

Path: 
`GET '/child/:id/medical'`

**Parameters**
*None*

**Status Codes**

Code | Type | Description
---|---|---
200 | Success | Medical information was successfully returned.
204 | Success | No medical information associated with specified child.

**Example Response**

```
{
  "id": 1,
  "child": {
    "id": 1,
    "first_name": "Jac",
    "last_name": "Nickelsen",
    "age": 10,
    "dob": "2005-5-30",
    "address": "10260 McKee Road, Collegedale, TN 37315",
    "phone_number": "800-522-4499",
    "height": null,
    "weight": null,
    "latitude": 35.7719376,
    "longitude": 139.7156425,
    "parent": {
      "id": 1,
      "username": "LilDebbie",
      "first_name": "Lil",
      "last_name": "Teddie",
      "address": "10260 McKee Road, Collegedale, TN 37315",
      "phone_number": "800-522-4499",
      "email": "lil@debbie.com",
      "avatar": "https://i.imgur.com/KOoBDaKb.jpg"
    }
  },
  "conditions": "Diabetes, Eczema",
  "medications": "Lantus",
  "notes": "Use dosage and sliding scale directions provided in his backpack for if insulin administration is needed.",
  "allergies": "None",
  "insurance": "N/A",
  "religious_preference": "N/A",
  "blood_type": "O+"
}
```

#### Create Medical Information

Creates medical information for a specified child.

Path:
`POST '/child/:id/medical'`

**Parameters**

Name | Type | Description
--- | --- | ---
conditions | string | A child's medical conditions.
medications | string | Prescribed medications for the specified child.
notes | string | Any relevant medical information such as medication directions or special needs.
allergies | string | A child's allergies.
insurance | string | A child's medical insurance information.
religious_preference | string | A child's religious affiliation if medically relevant.
blood_type | string | A child's blood type.

**Status Codes**

Code | Type | Description
---|---|---
201 | Success | Server has processed the request and has successfully created the user.
422 | Error | Unprocessable Entry. Specified parameters are invalid.

**Example Input**

```
{
  "conditions": "Diabetes, Eczema",
  "medications": "Lantus",
  "notes": "Use dosage and sliding scale directions provided in his backpack for if insulin administration is needed.",
  "allergies": "None",
  "insurance": "N/A",
  "religious_preference": "N/A",
  "blood_type": "O+"
}
```

**Example Response**

```
  "id": 1,
  "child": {
    "id": 1,
    "first_name": "Jac",
    "last_name": "Nickelsen",
    "age": 10,
    "dob": "2005-5-30",
    "address": "10260 McKee Road, Collegedale, TN 37315",
    "phone_number": "800-522-4499",
    "height": null,
    "weight": null,
    "latitude": 35.7719376,
    "longitude": 139.7156425,
    "parent": {
      "id": 1,
      "username": "LilDebbie",
      "first_name": "Lil",
      "last_name": "Teddie",
      "address": "10260 McKee Road, Collegedale, TN 37315",
      "phone_number": "800-522-4499",
      "email": "lil@debbie.com",
      "avatar": "https://i.imgur.com/KOoBDaKb.jpg"
    }
  },
  "conditions": "Diabetes, Eczema",
  "medications": "Lantus",
  "notes": "Use dosage and sliding scale directions provided in his backpack for if insulin administration is needed.",
  "allergies": "None",
  "insurance": "N/A",
  "religious_preference": "N/A",
  "blood_type": "O+"
}
```

#### Update Medical Information

Updates the medical information of a child. Forms should still include all previous information even if they are not updated with the new parameters.

Path:
`PUT '/child/:id/medical'`

**Parmeters**

Name | Type | Description
--- | --- | ---
conditions | string | A child's medical conditions.
medications | string | Prescribed medications for the specified child.
notes | string | Any relevant medical information such as medication directions or special needs.
allergies | string | A child's allergies.
insurance | string | A child's medical insurance information.
religious_preference | string | A child's religious affiliation if medically relevant.
blood_type | string | A child's blood type.

**Status Codes**

Code | Type | Description
---|---|---
200 | Success | Server has processed the request and has successfully updated the user.
422 | Error | Unprocessable Entry. Specified parameters are invalid.

**Example Input**

```
{
  "conditions": "Eczema",
  "allergies": "Peanuts",
  "insurance": "N/A",
  "religious_preference": "N/A",
}
```

**Example Response**

```
{
  "id": 1,
  "child": {
    "id": 1,
    "first_name": "Jac",
    "last_name": "Nickelsen",
    "age": 10,
    "dob": "2005-5-30",
    "address": "10260 McKee Road, Collegedale, TN 37315",
    "phone_number": "800-522-4499",
    "height": null,
    "weight": null,
    "latitude": 35.7719376,
    "longitude": 139.7156425,
    "parent": {
      "id": 1,
      "username": "LilDebbie",
      "first_name": "Lil",
      "last_name": "Teddie",
      "address": "10260 McKee Road, Collegedale, TN 37315",
      "phone_number": "800-522-4499",
      "email": "lil@debbie.com",
      "avatar": "https://i.imgur.com/KOoBDaKb.jpg"
    }
  },
  "conditions": "Eczema",
  "medications": null,
  "notes": null,
  "allergies": "Peanuts",
  "insurance": "N/A",
  "religious_preference": "N/A",
  "blood_type": null
}
```

#### Delete Medical Information

Deletes the medical information for a specified child.

Path:
`DELETE '/child/:id/medical'`

**Parameters**
*None*

**Status Codes**

Code | Type | Description
---|---|---
204 | Success | Request was received and deleted successfully.
400 | Error | Bad Request. Specified parameters do not match.
401 | Error | Unauthorized. A different user is not authorized to delete another user's child.

**Example Response**

```
No message is returned.
```

## **Contact Model**

#### Contact Index for a Child

List of all contacts that are associated with a specific child. *Note:* The contactable_type is the type of model that the contact belongs to. The contactable_id is the ID number of the Child/User in which the contact belongs to.

Path:
`GET '/child/:id/contacts'`

**Parameters**
*None*

**Status Codes**

Code | Type | Description
---|---|---
200 | Success | All contacts were successfully returned.
204 | Success | The server sucessfully processed the request, but no contacts were found.
400 | Error | Child with the specified ID could not be found in the database.

**Example Response**

```
[
  {
    "id": 1,
    "contactable_id": 2,
    "contactable_type": "Child",
    "first_name": "Luchador",
    "last_name": "Libre",
    "relationship": "Uncle",
    "address": null,
    "phone_number": "800-555-5555",
    "alternate_number": null,
    "latitude": null,
    "longitude": null
  },
  {
    "id": 2,
    "contactable_id": 2,
    "contactable_type": "Child",
    "first_name": "Lochadora",
    "last_name": "Libre",
    "relationship": "Aunt",
    "address": "1234 Fake Street, City, GA, 30000",
    "phone_number": "800-111-1111",
    "alternate_number": "777-777-7777",
    "latitude": 35.7719376,
    "longitude": 139.7156425
  }
]
```

#### Contact Index for a User

List of all contacts that are associated with a specified user. *Note:* The contactable_type is the type of model that the contact belongs to. The contactable_id is the ID number of the Child/User in which the contact belongs to.

Path:
`GET '/user/:username/contacts'`

**Parameters**
*None*

**Status Codes**

Code | Type | Description
---|---|---
200 | Success | All contacts were successfully returned.
204 | Success | The server sucessfully processed the request, but no contacts were found.
400 | Error | User with the specified username could not be found in the database.

**Example Response**

```
[
  {
    "id": 1,
    "contactable_id": 2,
    "contactable_type": "User",
    "first_name": "Luchador",
    "last_name": "Libre",
    "relationship": "Uncle",
    "address": null,
    "phone_number": "800-555-5555",
    "alternate_number": null,
    "latitude": null,
    "longitude": null
  },
  {
    "id": 2,
    "contactable_id": 2,
    "contactable_type": "User",
    "first_name": "Lochadora",
    "last_name": "Libre",
    "relationship": "Aunt",
    "address": "1234 Fake Street, City, GA, 30000",
    "phone_number": "800-111-1111",
    "alternate_number": "777-777-7777",
    "latitude": 35.7719376,
    "longitude": 139.7156425
  }
]
```

#### Create Contact for Child

Creates a contact for a specified child.

Path: 
`POST '/child/:id/contacts'`

**Parameters**

Name | Type | Description
--- | --- | ---
first_name | string | **Required.** Contact's first name.
last_name | string | **Required.** Contact's last name.
relationship | string | **Required.** Contact's relation to the child.
address | string | Contact's home/work address.
phone_number | string | **Required.** Contact's primary phone number to contact in case of emergency.
alternate_number | string | An alternate phone number in which the contact can be reached.

**Status Codes**

Code | Type | Description
---|---|---
201 | Success | Contact for the specified child was created successfully.
422 | Error | Unprocessable Entry. Specified parameters are invalid.

**Example Input**

```
{
  "first_name": "Luchador",
  "last_name": "Libre",
  "relationship": "Uncle",
  "phone_number": "800-555-5555"
}
```

**Example Response**

```
{
  "id": 1,
  "contactable_id": 2,
  "contactable_type": "Child",
  "first_name": "Luchador",
  "last_name": "Libre",
  "relationship": "Uncle",
  "address": null,
  "phone_number": "800-555-5555",
  "alternate_number": null,
  "latitude": null,
  "longitude": null
}
```

#### Create Contact for User

Creates a contact for the user that is currently logged in.

Path: 
`POST 'users/contacts'`

**Parameters**

Name | Type | Description
--- | --- | ---
first_name | string | **Required.** Contact's first name.
last_name | string | **Required.** Contact's last name.
relationship | string | **Required.** Contact's relation to the child.
address | string | Contact's home/work address.
phone_number | string | **Required.** Contact's primary phone number to contact in case of emergency.
alternate_number | string | An alternate phone number in which the contact can be reached.

**Status Codes**

Code | Type | Description
---|---|---
201 | Success | Contact for the specified user was created successfully.
422 | Error | Unprocessable Entry. Specified parameters are invalid.

**Example Input**

```
{
  "first_name": "Luchador",
  "last_name": "Libre",
  "relationship": "Uncle",
  "phone_number": "800-555-5555"
}
```

**Example Response**

```
{
  "id": 1,
  "contactable_id": 2,
  "contactable_type": "User",
  "first_name": "Luchador",
  "last_name": "Libre",
  "relationship": "Uncle",
  "address": null,
  "phone_number": "800-555-5555",
  "alternate_number": null,
  "latitude": null,
  "longitude": null
}
```

#### Update Contact

Updates the contact information for a specified contact.

Path:
`PUT '/contact/:id'`

**Parameters**

Name | Type | Description
--- | --- | ---
first_name | string | Contact's first name.
last_name | string | Contact's last name.
relationship | string | Contact's relation to the child.
address | string | Contact's home/work address.
phone_number | string | Contact's primary phone number to contact in case of emergency.
alternate_number | string | An alternate phone number in which the contact can be reached.

**Status Codes**

Code | Type | Description
---|---|---
200 | Success | Contact was successfully updated.
422 | Error | Unprocessable Entry. Specified parameters are invalid.

**Example Input**

```
{
  "phone_number": "800-555-9999",
  "alternate_number": "999-999-9999"
}
```

**Example Response**

```
{
  "id": 1,
  "contactable_id": 2,
  "contactable_type": "User",
  "first_name": "Luchador",
  "last_name": "Libre",
  "relationship": "Uncle",
  "address": null,
  "phone_number": "800-555-9999",
  "alternate_number": "999-999-9999",
  "latitude": null,
  "longitude": null
}
```

#### Delete Contact

Deletes the contact information for a specifed contact.

Path:
`DELETE '/contact/:id'`

**Parameters**
*None*

**Status Codes**

Code | Type | Description
---|---|---
204 | Success | Request was received and deleted successfully.
400 | Error | Bad Request. Specified parameters do not match.
401 | Error | Unauthorized. A different user is not authorized to delete another user's contacts.

## **Carpool Model**

#### Carpools Index

List of all carpools currently available.

Path: 
`GET '/carpools'`

**Parameters**
*None*

**Status Codes**

Code | Type | Description
---|---|---
200 | Success | List of carpools were successfully returned.
400 | Error | No carpools found.

**Example Response**

```
[
  {
    "id": 1,
    "creator": {
      "id": 1,
      "username": "LilDebbie",
      "first_name": "Lil",
      "last_name": "Debbie",
      "address": "10260 McKee Road, Collegedale, TN 37315",
      "phone_number": "800-522-4499",
      "email": "lil@debbie.com",
      "avatar": "https://i.imgur.com/KOoBDaKb.jpg"
      "latitude": 35.7719376,
      "longitude": 139.7156425
    },
    "title": "Work Carpool",
    "description": null,
    "users": [
      {
        "id": 1,
        "username": "LilDebbie",
        "first_name": "Lil",
        "last_name": "Debbie",
        "address": "10260 McKee Road, Collegedale, TN 37315",
        "phone_number": "800-522-4499",
        "email": "lil@debbie.com",
        "avatar": "https://i.imgur.com/KOoBDaKb.jpg",
        "latitude": 35.7719376,
        "longitude": 139.7156425,
        "activated": true,
        "join_token": null
      }
    ]
  },
  {
    "id": 2,
    "creator": {
      "id": 2,
      "username": "HostTwinkies",
      "first_name": "Hostess",
      "last_name": "Twinkies",
      "address": "1010 Cake Road, Kansas City, MO",
      "phone_number": "800-876-3942",
      "email": "twinkie@hostess.com",
      "avatar": "",
      "latitude": 35.7719376,
      "longitude": 139.7156425
    },
    "title": "Mall Carpool",
    "description": null,
    "users": [
      {
        "id": 2,
        "username": "HostTwinkies",
        "first_name": "Hostess",
        "last_name": "Twinkies",
        "address": "1010 Cake Road, Kansas City, MO",
        "phone_number": "800-876-3942",
        "email": "twinkie@hostess.com",
        "avatar": "",
        "latitude": 35.7719376,
        "longitude": 139.7156425,
        "activated": true,
        "join_token": "5b77de39ba63c420d3a77a9da30488e4"
      },
      {
        "id": 1,
        "username": "LilDebbie",
        "first_name": "Lil",
        "last_name": "Debbie",
        "address": "10260 McKee Road, Collegedale, TN 37315",
        "phone_number": "800-522-4499",
        "email": "lil@debbie.com",
        "avatar": "https://i.imgur.com/KOoBDaKb.jpg",
        "latitude": 35.7719376,
        "longitude": 139.7156425
        "activated": false,
        "join_token": "5b77de39ba63c420d3a77a9da30488e4"
      }
    ]
  },
]
```

#### User's Carpools Index

List of carpools that a user has joined or has been invited to.

Path:
`GET '/user/:username/carpools'`

**Parameters**
*None*

**Status Codes**

Code | Type | Description
---|---|---
200 | Success | List of carpools were successfully returned.
400 | Error | No carpools found.

**Example Response**

```
[
  {
    "id": 1,
    "creator": {
      "id": 1,
      "username": "LilDebbie",
      "first_name": "Lil",
      "last_name": "Debbie",
      "address": "10260 McKee Road, Collegedale, TN 37315",
      "phone_number": "800-522-4499",
      "email": "lil@debbie.com",
      "avatar": "https://i.imgur.com/KOoBDaKb.jpg",
      "latitude": 35.7719376,
      "longitude": 139.7156425
    },
    "title": "Work Carpool",
    "description": null,
    "users": [
      {
        "id": 1,
        "username": "LilDebbie",
        "first_name": "Lil",
        "last_name": "Debbie",
        "address": "10260 McKee Road, Collegedale, TN 37315",
        "phone_number": "800-522-4499",
        "email": "lil@debbie.com",
        "avatar": "https://i.imgur.com/KOoBDaKb.jpg",
        "latitude": 35.7719376,
        "longitude": 139.7156425,
        "activated": true,
        "join_token": null
      }
    ]
  },
  {
    "id": 2,
    "creator": {
      "id": 2,
      "username": "HostTwinkies",
      "first_name": "Hostess",
      "last_name": "Twinkies",
      "address": "1010 Cake Road, Kansas City, MO",
      "phone_number": "800-876-3942",
      "email": "twinkie@hostess.com"
      "avatar": "",
      "latitude": 35.7719376,
      "longitude": 139.7156425
    },
    "title": "Mall Carpool",
    "description": null,
    "users": [
      {
        "id": 2,
        "username": "HostTwinkies",
        "first_name": "Hostess",
        "last_name": "Twinkies",
        "address": "1010 Cake Road, Kansas City, MO",
        "phone_number": "800-876-3942",
        "email": "twinkie@hostess.com",
        "avatar": "",
        "latitude": 35.7719376,
        "longitude": 139.7156425,
        "activated": true,
        "join_token": "5b77de39ba63c420d3a77a9da30488e4"
      },
      {
        "id": 1,
        "username": "LilDebbie",
        "first_name": "Lil",
        "last_name": "Debbie",
        "address": "10260 McKee Road, Collegedale, TN 37315",
        "phone_number": "800-522-4499",
        "email": "lil@debbie.com",
        "avatar": "https://i.imgur.com/KOoBDaKb.jpg",
        "latitude": 35.7719376,
        "longitude": 139.7156425,
        "activated": false,
        "join_token": "5b77de39ba63c420d3a77a9da30488e4"
      }
    ]
  },
]
```

#### Show Carpool

Shows the information for a specified carpool group.

Path: 
`GET '/carpool/:id'`

**Parameters**
*None*

**Status Codes**

Code | Type | Description
---|---|---
200 | Success | Carpool information was successfully returned.
400 | Error | No carpool with specified ID found.

**Example Response**

```
{
  "id": 10,
  "creator": {
    "id": 1,
    "username": "LilDebbie",
    "first_name": "Lil",
    "last_name": "Debbie",
    "address": "10260 McKee Road, Collegedale, TN 37315",
    "phone_number": "800-522-4499",
    "email": "lil@debbie.com",
    "avatar": "https://i.imgur.com/KOoBDaKb.jpg",
    "latitude": 35.7719376,
    "longitude": 139.7156425
  },
  "title": "School Carpool",
  "description": null,
  "users": [
    {
      "id": 1,
      "username": "LilDebbie",
      "first_name": "Lil",
      "last_name": "Debbie",
      "address": "10260 McKee Road, Collegedale, TN 37315",
      "phone_number": "800-522-4499",
      "email": "lil@debbie.com",
      "avatar": "https://i.imgur.com/KOoBDaKb.jpg",
      "latitude": 35.7719376,
      "longitude": 139.7156425,
      "activated": true,
      "join_token": "e335a93e71f52e008ed8146b8892e842"
    },
    {
      "id": 2,
      "username": "HostTwinkies",
      "first_name": "Hostess",
      "last_name": "Twinkies",
      "address": "1010 Cake Road, Kansas City, MO",
      "phone_number": "800-876-3942",
      "email": "twinkie@hostess.com",
      "avatar": "",
      "latitude": 35.7719376,
      "longitude": 139.7156425,
      "activated": true,
      "join_token": "5b77de39ba63c420d3a77a9da30488e4"
    }
  ]
}
```

#### Create a Carpool

Creates a carpool group that is owned by the currently logged in user. The creator of a carpool is automatically added to the members list and activated (in this case the join_token will not be used).

Path: 
`POST '/carpools'`

**Parameters**

Name | Type | Description
--- | --- | ---
title | string | **Required.** Carpool group's title.
description | string | A description of a carpool.

**Status Codes**

Code | Type | Description
---|---|---
201 | Success | Server has processed the request and has successfully created the carpool.
422 | Error | Unprocessable Entry. Specified parameters are invalid.

**Example Input**

```
{
  "title": "School Group",
  "description": "Take the kiddies to school."
}
```

**Example Response**

```
{
  "id": 14,
  "creator": {
    "id": 1,
    "username": "LilDebbie",
    "first_name": "Lil",
    "last_name": "Debbie",
    "address": "10260 McKee Road, Collegedale, TN 37315",
    "phone_number": "800-522-4499",
    "email": "lil@debbie.com",
    "avatar": "https://i.imgur.com/KOoBDaKb.jpg",
    "latitude": 35.7719376,
    "longitude": 139.7156425
  },
  "title": "School Group",
  "description": "Take the kiddies to school.",
  "users": [
    {
      "id": 1,
      "username": "LilDebbie",
      "first_name": "Lil",
      "last_name": "Debbie",
      "address": "10260 McKee Road, Collegedale, TN 37315",
      "phone_number": "800-522-4499",
      "email": "lil@debbie.com",
      "avatar": "https://i.imgur.com/KOoBDaKb.jpg",
      "latitude": 35.7719376,
      "longitude": 139.7156425,
      "activated": true,
      "join_token": "8bc6e6cc28616688a8158cc482d2e45b"
    }
  ]
}
```

#### Update a Carpool

Updates the information for a specified carpool.

Path:
`PUT '/carpool/:id'`

**Parameters**

Name | Type | Description
--- | --- | ---
title | string | **Required.** Carpool group's title.
description | string | A description of a carpool.


**Status Codes**

Code | Type | Description
---|---|---
200 | Success | Server has processed the request and has successfully updated the carpool.
422 | Error | Unprocessable Entry. Specified parameters are invalid.

**Example Input**

```
{
  "title": "High School Group",
  "description": "Take the teens to school."
}
```

**Example Response**

```
{
  "id": 14,
  "creator": {
    "id": 1,
    "username": "LilDebbie",
    "first_name": "Lil",
    "last_name": "Debbie",
    "address": "10260 McKee Road, Collegedale, TN 37315",
    "phone_number": "800-522-4499",
    "email": "lil@debbie.com",
    "avatar": "https://i.imgur.com/KOoBDaKb.jpg",
    "latitude": 35.7719376,
    "longitude": 139.7156425
  },
  "title": "High School Group",
  "description": "Take the teens to school.",
  "users": [
    {
      "id": 1,
      "username": "LilDebbie",
      "first_name": "Lil",
      "last_name": "Debbie",
      "address": "10260 McKee Road, Collegedale, TN 37315",
      "phone_number": "800-522-4499",
      "email": "lil@debbie.com",
      "avatar": "https://i.imgur.com/KOoBDaKb.jpg",
      "latitude": 35.7719376,
      "longitude": 139.7156425,
      "activated": true,
      "join_token": "8bc6e6cc28616688a8158cc482d2e45b"
    }
  ]
}
```

#### Delete a Carpool

Deletes a specified carpool group.

Path:
`DELETE '/carpool/:id'`

**Parameters**
*None*

**Status Codes**

Code | Type | Description
---|---|---
204 | Success | Request was received and deleted successfully.
400 | Error | Bad Request. Specified parameters do not match.
401 | Error | Unauthorized. A different user is not authorized to delete another user's carpool.

**Example Response**

```
No message is returned.
```

#### Remove User from Carpool Group

Removes a specified user (member) from a specified carpool group.

Path:
`DELETE '/carpool/:id/user/:username'`

**Parameters**
*None*

**Status Codes**

Code | Type | Description
---|---|---
200 | Success | Request was received and deleted successfully, will return updated carpool information with specified user removed.
400 | Error | Bad Request. Specified parameters do not match.
401 | Error | Unauthorized. Only the creator of the carpool, and the user being removed, can remove a user from a specified carpool.

**Example Route**

`DELETE '/carpool/10/user/HostTwinkies`

**Example Response**

```
{
  "id": 10,
  "creator": {
    "id": 1,
    "username": "LilDebbie",
    "first_name": "Lil",
    "last_name": "Debbie",
    "address": "10260 McKee Road, Collegedale, TN 37315",
    "phone_number": "800-522-4499",
    "email": "lil@debbie.com",
    "avatar": "https://i.imgur.com/KOoBDaKb.jpg",
    "latitude": 35.7719376,
    "longitude": 139.7156425
  },
  "title": "School Carpool",
  "description": "Take the kiddies to school.",
  "users": [
    {
      "id": 1,
      "username": "LilDebbie",
      "first_name": "Lil",
      "last_name": "Debbie",
      "address": "10260 McKee Road, Collegedale, TN 37315",
      "phone_number": "800-522-4499",
      "email": "lil@debbie.com",
      "avatar": "https://i.imgur.com/KOoBDaKb.jpg",
      "latitude": 35.7719376,
      "longitude": 139.7156425,
      "activated": true,
      "join_token": "e335a93e71f52e008ed8146b8892e842"
    }
  ]
}
```

#### User's Pending Invitations Index

List of all pending invitations for a specified user that has not been activated.

Path: 
`GET '/user/:username/invites'`

**Parameters**
*None*

**Status Codes**

Code | Type | Description
---|---|---
200 | Success | Invitation information was successfully returned.
400 | Error | No user with specified username found.

**Example Route**

`GET '/user/HostTwinkies/invites'`

**Example Response**

```
[
  {
    "id": 22,
    "carpool": {
      "id": 15,
      "creator": {
        "id": 1,
        "username": "LilDebbie",
        "first_name": "Lil",
        "last_name": "Debbie",
        "address": "10260 McKee Road, Collegedale, TN 37315",
        "phone_number": "800-522-4499",
        "email": "lil@debbie.com",
        "avatar": "https://i.imgur.com/KOoBDaKb.jpg",
        "latitude": 35.7719376,
        "longitude": 139.7156425
      },
      "title": "School Group",
      "description": "Take the kiddies to school.",
      "users": [
        {
          "id": 1,
          "username": "LilDebbie",
          "first_name": "Lil",
          "last_name": "Debbie",
          "address": "10260 McKee Road, Collegedale, TN 37315",
          "phone_number": "800-522-4499",
          "email": "lil@debbie.com",
          "avatar": "https://i.imgur.com/KOoBDaKb.jpg",
          "latitude": 35.7719376,
          "longitude": 139.7156425
          "activated": true,
          "join_token": "a7f28e052b67729324e89473d6588c69"
        },
        {
          "id": 2,
          "username": "HostTwinkies",
          "first_name": "Hostess",
          "last_name": "Twinkies",
          "address": "1010 Cake Road, Kansas City, MO",
          "phone_number": "800-876-3942",
          "email": "twinkie@hostess.com",
          "avatar": "",
          "latitude": 35.7719376,
          "longitude": 139.7156425,
          "activated": false,
          "join_token": "cf8e0bfdd05805a11cd030cba9aaf6f1"
        }
      ]
    },
    "invited_user": {
      "id": 2,
      "username": "HostTwinkies",
      "first_name": "Hostess",
      "last_name": "Twinkies",
      "address": "1010 Cake Road, Kansas City, MO",
      "phone_number": "800-876-3942",
      "email": "twinkie@hostess.com",
      "avatar": "",
      "latitude": 35.7719376,
      "longitude": 139.7156425,
      "activated": false,
      "join_token": "cf8e0bfdd05805a11cd030cba9aaf6f1"
    }
  }
]
```

#### Invite a User to Carpool

Creates an invitation to for a specified user to a carpool group. Currently requires the user to be added to have an account with the website. (Will add functionality for non-users when Mailer is setup).

Path: 
`POST '/carpool/:id'`

**Parameters**

Name | Type | Description
--- | --- | ---
emails | array | **Required.** A list of emails associated with a user to be invited to a carpool.

**Status Codes**

Code | Type | Description
---|---|---
201 | Success | Server has processed the request and has successfully created the invitation.
422 | Error | Unprocessable Entry. Specified parameters are invalid.

**Example Input**

```
{
  "emails": ["lionking@diznay.com", "twinkie@hostess.com"]
}
```

**Example Response**

```
[
  {
    "id": 22,
    "carpool": {
      "id": 15,
      "creator": {
        "id": 3,
        "username": "LilDebbie",
        "first_name": "Lil",
        "last_name": "Debbie",
        "address": "10260 McKee Road, Collegedale, TN 37315",
        "phone_number": "800-522-4499",
        "email": "lil@debbie.com",
        "avatar": "https://i.imgur.com/KOoBDaKb.jpg",
        "latitude": 35.7719376,
        "longitude": 139.7156425
      },
      "title": "School Group",
      "description": "Take the kiddies to school.",
      "users": [
        {
          "id": 1,
          "username": "LKing",
          "first_name": "Simba",
          "last_name": "King",
          "address": "10260 McKee Road, Collegedale, TN 37315",
          "phone_number": "777-777-7777",
          "email": "lionking@diznay.com",
          "avatar": "https://i.imgur.com/KOoBDaKb.jpg",
          "latitude": 35.7719376,
          "longitude": 139.7156425
          "activated": false,
          "join_token": "a7f28e052b67729324e89473d6588c69"
        },
        {
          "id": 2,
          "username": "HostTwinkies",
          "first_name": "Hostess",
          "last_name": "Twinkies",
          "address": "1010 Cake Road, Kansas City, MO",
          "phone_number": "800-876-3942",
          "email": "twinkie@hostess.com",
          "avatar": "",
          "latitude": 35.7719376,
          "longitude": 139.7156425,
          "activated": false,
          "join_token": "cf8e0bfdd05805a11cd030cba9aaf6f1"
        }
      ]
    },
    "invited_user": {
      "id": 1,
      "username": "LKing",
      "first_name": "Simba",
      "last_name": "King",
      "address": "10260 McKee Road, Collegedale, TN 37315",
      "phone_number": "777-777-7777",
      "email": "lionking@diznay.com",
      "avatar": "https://i.imgur.com/KOoBDaKb.jpg",
      "latitude": 35.7719376,
      "longitude": 139.7156425
      "activated": false,
      "join_token": "a7f28e052b67729324e89473d6588c69"
    }
  },
  {
    "id": 22,
    "carpool": {
      "id": 15,
      "creator": {
        "id": 3,
        "username": "LilDebbie",
        "first_name": "Lil",
        "last_name": "Debbie",
        "address": "10260 McKee Road, Collegedale, TN 37315",
        "phone_number": "800-522-4499",
        "email": "lil@debbie.com",
        "avatar": "https://i.imgur.com/KOoBDaKb.jpg",
        "latitude": 35.7719376,
        "longitude": 139.7156425
      },
      "title": "School Group",
      "description": "Take the kiddies to school.",
      "users": [
        {
          "id": 1,
          "username": "LKing",
          "first_name": "Simba",
          "last_name": "King",
          "address": "10260 McKee Road, Collegedale, TN 37315",
          "phone_number": "777-777-7777",
          "email": "lionking@diznay.com",
          "avatar": "https://i.imgur.com/KOoBDaKb.jpg",
          "latitude": 35.7719376,
          "longitude": 139.7156425
          "activated": false,
          "join_token": "a7f28e052b67729324e89473d6588c69"
        },
        {
          "id": 2,
          "username": "HostTwinkies",
          "first_name": "Hostess",
          "last_name": "Twinkies",
          "address": "1010 Cake Road, Kansas City, MO",
          "phone_number": "800-876-3942",
          "email": "twinkie@hostess.com",
          "avatar": "",
          "latitude": 35.7719376,
          "longitude": 139.7156425,
          "activated": false,
          "join_token": "cf8e0bfdd05805a11cd030cba9aaf6f1"
        }
      ]
    },
    "invited_user": {
      "id": 2,
      "username": "HostTwinkies",
      "first_name": "Hostess",
      "last_name": "Twinkies",
      "address": "1010 Cake Road, Kansas City, MO",
      "phone_number": "800-876-3942",
      "email": "twinkie@hostess.com",
      "avatar": "",
      "latitude": 35.7719376,
      "longitude": 139.7156425,
      "activated": false,
      "join_token": "cf8e0bfdd05805a11cd030cba9aaf6f1"
    }
  }
]
```

#### Activate an Invitation

Activates an invitation for a specified user and carpool. Only the invited user can accept an invitation (must be logged in).

Path:
`PUT '/carpool/:id/activate'`

**Parameters**

Name | Type | Description
--- | --- | ---
join_token | string | **Required.** Token used to accept invitation.

**Status Codes**

Code | Type | Description
---|---|---
200 | Success | Server has processed the request and has successfully accepted the invitation.
422 | Error | Unprocessable Entry. Specified parameters are invalid.

**Example Input**

```
{
  "join_token": "cf8e0bfdd05805a11cd030cba9aaf6f1"
}
```

**Example Response**

```
[
  {
    "id": 22,
    "carpool": {
      "id": 15,
      "creator": {
        "id": 1,
        "username": "LilDebbie",
        "first_name": "Lil",
        "last_name": "Debbie",
        "address": "10260 McKee Road, Collegedale, TN 37315",
        "phone_number": "800-522-4499",
        "email": "lil@debbie.com",
        "avatar": "https://i.imgur.com/KOoBDaKb.jpg",
        "latitude": 35.7719376,
        "longitude": 139.7156425
      },
      "title": "School Group",
      "description": "Take the kiddies to school.",
      "users": [
        {
          "id": 1,
          "username": "LilDebbie",
          "first_name": "Lil",
          "last_name": "Debbie",
          "address": "10260 McKee Road, Collegedale, TN 37315",
          "phone_number": "800-522-4499",
          "email": "lil@debbie.com",
          "avatar": "https://i.imgur.com/KOoBDaKb.jpg",
          "latitude": 35.7719376,
          "longitude": 139.7156425,
          "activated": true,
          "join_token": "a7f28e052b67729324e89473d6588c69"
        },
        {
          "id": 2,
          "username": "HostTwinkies",
          "first_name": "Hostess",
          "last_name": "Twinkies",
          "address": "1010 Cake Road, Kansas City, MO",
          "phone_number": "800-876-3942",
          "email": "twinkie@hostess.com",
          "avatar": "",
          "latitude": 35.7719376,
          "longitude": 139.7156425,
          "activated": true,
          "join_token": "cf8e0bfdd05805a11cd030cba9aaf6f1"
        }
      ]
    },
    "invited_user": {
      "id": 2,
      "username": "HostTwinkies",
      "first_name": "Hostess",
      "last_name": "Twinkies",
      "address": "1010 Cake Road, Kansas City, MO",
      "phone_number": "800-876-3942",
      "email": "twinkie@hostess.com",
      "avatar": "",
      "latitude": 35.7719376,
      "longitude": 139.7156425,  
      "activated": true,
      "join_token": "cf8e0bfdd05805a11cd030cba9aaf6f1"
    }
  }
]
```

## **Appointment Model**

#### Carpool Appointment Index

List of all appointments in a carpool

Path:
`GET '/carpool/:id/appointments'`

**Parameters**
*None*

**Status Codes**

Code | Type | Description
---|---|---
200 | Success | All users were successfully returned.
404 | Error | Not Found. Specified parameters do not match.

**Example Response**

```
[
  {
    "id": 20,
    "carpool_id": 17,
    "creator": {
      "username": "testuser23",
      "first_name": "test",
      "last_name": "user22",
      "address": "100 Peachtree St NE Atlanta, GA",
      "phone_number": "(404) 221-2540",
      "email": "test23@email.com",
      "avatar": "http://i.imgur.com/nepC0uk.jpg",
      "latitude": 33.7868171,
      "longitude": -84.3827744
    },
    "start": "2015-01-30T10:00:00.000-05:00",
    "title": "Something",
    "description": "none",
    "origin": "190 Marietta St NW, Atlanta, GA 30303",
    "origin_latitude": 32.3182314,
    "origin_longitude": -86.902298,
    "destination": "225 Baker St NW, Atlanta, GA 30313",
    "destination_latitude": 27.6648274,
    "destination_longitude": -81.5157535,
    "riders": [
      {
        "appointment_id": 20,
        "rider": {
          "id": 11,
          "username": "testuser23",
          "first_name": "test",
          "last_name": "user23",
          "address": "100 Peachtree St NE Atlanta, GA",
          "phone_number": "(404) 221-2540",
          "email": "test23@email.com",
          "avatar": "http://i.imgur.com/nepC0uk.jpg",
          "latitude": 33.7868171,
          "longitude": -84.3827744
        },
        "ridable_type": "User",
        "distance_from_origin": 2,
        "distance_from_destination": 455
        "rider_role": "Driver"
      }
    ]
  },
  {
    "id": 28,
    "carpool_id": 17,
    "creator": {
      "id": 11,
      "username": "testuser23",
      "first_name": "test",
      "last_name": "user22",
      "address": "100 Peachtree St NE Atlanta, GA",
      "phone_number": "(404) 221-2540",
      "email": "test23@email.com",
      "avatar": "http://i.imgur.com/nepC0uk.jpg",
      "latitude": 33.7868171,
      "longitude": -84.3827744
    },
    "start": "2015-01-30T10:00:00.000-05:00",
    "title": "Something",
    "description": "none",
    "origin": "atlanta, ga",
    "origin_latitude": 33.7489954,
    "origin_longitude": -84.3879824,
    "destination": "florida",
    "destination_latitude": 27.6648274,
    "destination_longitude": -81.5157535,
    "riders": [
      {
        "appointment_id": 28,
        "rider": {
          "id": 11,
          "username": "testuser23",
          "first_name": "test",
          "last_name": "user23",
          "address": "100 Peachtree St NE Atlanta, GA",
          "phone_number": "(404) 221-2540",
          "email": "test23@email.com",
          "avatar": "http://i.imgur.com/nepC0uk.jpg",
          "latitude": 33.7868171,
          "longitude": -84.3827744
        },
        "ridable_type": "User",
        "distance_from_origin": 2,
        "distance_from_destination": 455
        "rider_role": "Driver"
      },
      {
        "appointment_id": 28,
        "rider": {
          "id": 12,
          "username": "testuser24",
          "first_name": "test",
          "last_name": "user24",
          "address": "100 Something St Atlanta, GA",
          "phone_number": "(404) 221-2540",
          "email": "test24@email.com",
          "avatar": "",
          "latitude": 33.7868171,
          "longitude": -84.3827744
        },
        "ridable_type": "User",
        "distance_from_origin": 10,
        "distance_from_destination": 455
      },
    ]
  },
]
```

#### User Appointment Index

List of all appointments a user is associated with.

Path:
`GET '/user/:username/appointments'`

**Parameters**
*None*

**Status Codes**

Code | Type | Description
---|---|---
200 | Success | All users were successfully returned.
404 | Error | Not Found. Specified parameters do not match.

**Example Response**

```
[
  {
    "id": 28,
    "carpool_id": 17,
    "creator": {
      "id": 11,
      "username": "testuser23",
      "first_name": "test",
      "last_name": "user22",
      "address": "100 Peachtree St NE Atlanta, GA",
      "phone_number": "(404) 221-2540",
      "email": "test23@email.com",
      "avatar": "http://i.imgur.com/nepC0uk.jpg",
      "latitude": 33.7868171,
      "longitude": -84.3827744
    },
    "start": "2015-01-30T10:00:00.000-05:00",
    "title": "Something",
    "description": "none",
    "origin": "atlanta, ga",
    "origin_latitude": 33.7489954,
    "origin_longitude": -84.3879824,
    "destination": "florida",
    "destination_latitude": 27.6648274,
    "destination_longitude": -81.5157535,
    "distance_filter": 400,
    "riders": [
      {
        "appointment_id": 28,
        "rider": {
          "id": 11,
          "username": "testuser23",
          "first_name": "test",
          "last_name": "user22",
          "address": "100 Peachtree St NE Atlanta, GA",
          "phone_number": "(404) 221-2540",
          "email": "test23@email.com",
          "avatar": "http://i.imgur.com/nepC0uk.jpg",
          "latitude": 33.7868171,
          "longitude": -84.3827744
        },
        "ridable_type": "User",
        "distance_from_origin": 2,
        "distance_from_destination": 455,
        "rider_role": "Driver"
      }
    ],
    "appointment_id": 28,
    "rider": {
      "id": 11,
      "username": "testuser23",
      "first_name": "test",
      "last_name": "user22",
      "address": "100 Peachtree St NE Atlanta, GA",
      "phone_number": "(404) 221-2540",
      "email": "test23@email.com",
      "avatar": "http://i.imgur.com/nepC0uk.jpg",
      "latitude": 33.7868171,
      "longitude": -84.3827744
    },
    "ridable_type": "User",
    "distance_from_origin": 2,
    "distance_from_destination": 455,
    "rider_role": "Driver"
  }
]
```

#### Show Appointment

Shows the attributes of a specified appointment.

Path:
`GET '/appointment/:id'`

**Parameters**
*None*

**Status Codes**

Code | Type | Description
---|---|---
200 | Success | All users were successfully returned.
404 | Error | Not Found. Specified parameters do not match.

**Example Response**

```
{
  "id": 28,
  "carpool_id": 17,
  "creator": {
    "id": 11,
    "username": "testuser23",
    "first_name": "test",
    "last_name": "user22",
    "address": "100 Peachtree St NE Atlanta, GA",
    "phone_number": "(404) 221-2540",
    "email": "test23@email.com",
    "avatar": "http://i.imgur.com/nepC0uk.jpg",
    "latitude": 33.7868171,
    "longitude": -84.3827744
  },
  "start": "2015-01-30T10:00:00.000-05:00",
  "title": "Something",
  "description": "none",
  "origin": "atlanta, ga",
  "origin_latitude": 33.7489954,
  "origin_longitude": -84.3879824,
  "destination": "florida",
  "destination_latitude": 27.6648274,
  "destination_longitude": -81.5157535,
  "distance_filter": 400,
  "riders": [
    {
      "appointment_id": 28,
      "rider": {
        "id": 11,
        "username": "testuser23",
        "first_name": "test",
        "last_name": "user22",
        "address": "100 Peachtree St NE Atlanta, GA",
        "phone_number": "(404) 221-2540",
        "email": "test23@email.com",
        "avatar": "http://i.imgur.com/nepC0uk.jpg",
        "latitude": 33.7868171,
        "longitude": -84.3827744
      },
      "ridable_type": "User",
      "distance_from_origin": 2,
      "distance_from_destination": 455,
      "rider_role": "Driver"
    }
  ]
}
```

#### Create Appointment

Creates an appointment for a specified carpool.

Path:
`POST '/carpool/:id/appointments'`

**Parameters**

Name | Type | Description
--- | --- | ---
start | datetime | **Required.** The start time of the appointment in DateTime format. ( DD/MM/YYYY HH:MM:SS )
title | string | **Required.** Title of the appointment
description | string | Description of the appointment.
origin | string | **Required.** Address of the intended intial pickup location (usually the driver's address).
destination | string | **Required.** Address of the intended destination.
distance_filter | integer | **Required.** Distance (in **miles**) the driver is willing to drive per added user. (Will reject any user that attempts to join the appointment but is farther than the input distance.)

**Status Codes**

Code | Type | Description
--- | --- | ---
201 | Success | Server has processed the request and has successfully created the appointment.
422 | Error | Unprocessable Entry. Specified parameters are invalid.

**Example Input**

```
{
  "start": "15-7-2015 09:00",
  "title": "Appointment Title",
  "origin": "10800 Alpharetta Hwy Roswell, GA",
  "destination": "650 Ponce De Leon Ave NE Atlanta, GA",
  "distance_filter": 40
}
```

**Example Response**

```
{
  "id": 30,
  "carpool_id": 17,
  "creator": {
    "id": 11,
    "username": "testuser23",
    "first_name": "test",
    "last_name": "user22",
    "address": "100 Peachtree St NE Atlanta, GA",
    "phone_number": "(404) 221-2540",
    "email": "test23@email.com",
    "avatar": "http://i.imgur.com/nepC0uk.jpg",
    "latitude": 33.7868171,
    "longitude": -84.3827744
  },
  "start": "2015-07-15T09:00:00.000-04:00",
  "title": "Appointment Title",
  "description": null,
  "origin": "10800 Alpharetta Hwy Roswell, GA",
  "origin_latitude": 34.0437521,
  "origin_longitude": -84.3419778,
  "destination": "650 Ponce De Leon Ave NE Atlanta, GA",
  "destination_latitude": 33.7770005,
  "destination_longitude": -84.36652889999999,
  "distance_filter": 50,
  "riders": [
    {
      "appointment_id": 30,
      "rider": {
        "id": 11,
        "username": "testuser23",
        "first_name": "test",
        "last_name": "user23",
        "address": "100 Peachtree St NE Atlanta, GA",
        "phone_number": "(404) 221-2540",
        "email": "test23@email.com",
        "avatar": "http://i.imgur.com/nepC0uk.jpg",
        "latitude": 33.7868171,
        "longitude": -84.3827744
      },
      "ridable_type": "User",
      "distance_from_origin": 17,
      "distance_from_destination": 1,
      "rider_role": "Driver"
    }
  ]
}
```

#### Update an Appointment

Updates the specified attributes for a specified appointment. Forms should include all required fields to be passed with the request.

Path:
`PUT '/appointment/:id'`

**Parameters**

Name | Type | Description
--- | --- | ---
start | datetime | **Required.** The start time of the appointment in DateTime format. ( DD/MM/YYYY HH:MM:SS )
title | string | **Required.** Title of the appointment
description | string | Description of the appointment.
origin | string | **Required.** Address of the intended intial pickup location (usually the driver's address).
destination | string | **Required.** Address of the intended destination.
distance_filter | integer | **Required.** Distance (in **miles**) the driver is willing to drive per added user. (Will reject any user that attempts to join the appointment but is farther than the input distance.)

**Status Codes**

Code | Type | Description
---|---|---
200 | Success | Server has processed the request and has successfully updated the user.
422 | Error | Unprocessable Entry. Specified parameters are invalid.

**Example Input**

```
{
  "start": "15-7-2015 19:00",
  "title": "New Appointment Title",
}
```

**Example Response**

```
{
  "id": 30,
  "carpool_id": 17,
  "creator": {
    "id": 11,
    "username": "testuser23",
    "first_name": "test",
    "last_name": "user22",
    "address": "100 Peachtree St NE Atlanta, GA",
    "phone_number": "(404) 221-2540",
    "email": "test23@email.com",
    "avatar": "http://i.imgur.com/nepC0uk.jpg",
    "latitude": 33.7868171,
    "longitude": -84.3827744
  },
  "start": "2015-07-15T19:00:00.000-04:00",
  "title": "New Appointment Title",
  "description": null,
  "origin": "10800 Alpharetta Hwy Roswell, GA",
  "origin_latitude": 34.0437521,
  "origin_longitude": -84.3419778,
  "destination": "650 Ponce De Leon Ave NE Atlanta, GA",
  "destination_latitude": 33.7770005,
  "destination_longitude": -84.36652889999999,
  "distance_filter": 50,
  "riders": [
    {
      "appointment_id": 30,
      "rider": {
        "id": 11,
        "username": "testuser23",
        "first_name": "test",
        "last_name": "user22",
        "address": "100 Peachtree St NE Atlanta, GA",
        "phone_number": "(404) 221-2540",
        "email": "test23@email.com",
        "avatar": "http://i.imgur.com/nepC0uk.jpg",
        "latitude": 33.7868171,
        "longitude": -84.3827744
      },
      "ridable_type": "User",
      "distance_from_origin": 17,
      "distance_from_destination": 1,
      "rider_role": "Driver"
    }
  ]
}
```

#### Delete Appointment

Deletes a specified appointment.

Path:
`DELETE '/appointment/:id'`

**Parameters**
*None*

**Status Codes**

Code | Type | Description
---|---|---
204 | Success | Request was received and deleted successfully.
404 | Error | Not Found. Specified parameters do not match.
401 | Error | Unauthorized. A different user is not authorized to delete another user's appointment.

**Example Resonse**

```
No message is returned.
```

## **Rider Model**

This is an individual that is participating in a specific appointment. This can be a user or child. The view for these riders are available in the Appointment model.

#### Join Appointment (User)

Joins a specified user to an appointment. Only the logged in user is allowed to join an appointment. A user cannot add a different user to an appointment. User's rider_role is automatically generated to "Passenger." This can be modified using the update path (below) if desired.

Path: 
`POST '/user/:username/appointment/:id/join'`

**Parameters**
*None*

**Status Codes**

Code | Type | Description
---|---|---
201 | Success | Server has processed the request and has successfully created the user.
422 | Error | Unprocessable Entry. Specified parameters are invalid.

**Example Response**

```
{
  "id": 30,
  "carpool_id": 17,
  "creator": {
    "id": 11,
    "username": "testuser23",
    "first_name": "test",
    "last_name": "user22",
    "address": "100 Peachtree St NE Atlanta, GA",
    "phone_number": "(404) 221-2540",
    "email": "test23@email.com",
    "avatar": "http://i.imgur.com/nepC0uk.jpg",
    "latitude": 33.7868171,
    "longitude": -84.3827744
  },
  "start": "2015-07-15T19:00:00.000-04:00",
  "title": "New Appointment Title",
  "description": null,
  "origin": "10800 Alpharetta Hwy Roswell, GA",
  "origin_latitude": 34.0437521,
  "origin_longitude": -84.3419778,
  "destination": "650 Ponce De Leon Ave NE Atlanta, GA",
  "destination_latitude": 33.7770005,
  "destination_longitude": -84.3665289,
  "distance_filter": 50,
  "riders": [
    {
      "appointment_id": 30,
      "rider": {
        "id": 11,
        "username": "testuser23",
        "first_name": "test",
        "last_name": "user22",
        "address": "100 Peachtree St NE Atlanta, GA",
        "phone_number": "(404) 221-2540",
        "email": "test23@email.com",
        "avatar": "http://i.imgur.com/nepC0uk.jpg",
        "latitude": 33.7868171,
        "longitude": -84.3827744
      },
      "ridable_type": "User",
      "distance_from_origin": 17,
      "distance_from_destination": 1,
      "rider_role": "Driver"
    },
    {
      "appointment_id": 30,
      "rider": {
        "id": 15,
        "username": "testuser28",
        "first_name": "test",
        "last_name": "user28",
        "address": "206 Washington St SW, Atlanta, GA 30334",
        "phone_number": null,
        "email": "testuser28@email.com",
        "avatar": null,
        "latitude": 33.748994,
        "longitude": -84.3880503
      },
      "ridable_type": "User",
      "distance_from_origin": 20,
      "distance_from_destination": 2,
      "rider_role": "Passenger"
    }
  ]
}
```

#### Join Appointment (Child)

Joins a specified user to an appointment. Only the logged in user is allowed to join an appointment. A user cannot add a different user to an appointment. Child's rider_role is automatically generated to "Passenger".

Path: 
`POST '/child/:child_id/appointment/:id/join'`

**Parameters**
*None*

**Status Codes**

Code | Type | Description
---|---|---
201 | Success | Server has processed the request and has successfully created the user.
422 | Error | Unprocessable Entry. Specified parameters are invalid.

**Example Response**
```
{
  "id": 30,
  "carpool_id": 17,
  "creator": {
    "id": 11,
    "username": "testuser23",
    "first_name": "test",
    "last_name": "user22",
    "address": "100 Peachtree St NE Atlanta, GA",
    "phone_number": "(404) 221-2540",
    "email": "test23@email.com",
    "avatar": "http://i.imgur.com/nepC0uk.jpg",
    "latitude": 33.7868171,
    "longitude": -84.3827744
  },
  "start": "2015-07-15T19:00:00.000-04:00",
  "title": "New Appointment Title",
  "description": null,
  "origin": "10800 Alpharetta Hwy Roswell, GA",
  "origin_latitude": 34.0437521,
  "origin_longitude": -84.3419778,
  "destination": "650 Ponce De Leon Ave NE Atlanta, GA",
  "destination_latitude": 33.7770005,
  "destination_longitude": -84.3665289,
  "distance_filter": 50,
  "riders": [
    {
      "appointment_id": 30,
      "rider": {
        "id": 11,
        "username": "testuser23",
        "first_name": "test",
        "last_name": "user22",
        "address": "100 Peachtree St NE Atlanta, GA",
        "phone_number": "(404) 221-2540",
        "email": "test23@email.com",
        "avatar": "http://i.imgur.com/nepC0uk.jpg",
        "latitude": 33.7868171,
        "longitude": -84.3827744
      },
      "ridable_type": "User",
      "distance_from_origin": 17,
      "distance_from_destination": 1,
      "rider_role": "Driver"
    },
    {
      "appointment_id": 30,
      "rider": {
        "id": 15,
        "username": "testuser28",
        "first_name": "test",
        "last_name": "user28",
        "address": "206 Washington St SW, Atlanta, GA 30334",
        "phone_number": null,
        "email": "testuser28@email.com",
        "avatar": null,
        "latitude": 33.748994,
        "longitude": -84.3880503
      },
      "ridable_type": "User",
      "distance_from_origin": 20,
      "distance_from_destination": 2,
      "rider_role": "Passenger"
    },
    {
      "appointment_id": 30,
      "rider": {
        "id": 15,
        "username": "testuser28",
        "first_name": "test",
        "last_name": "user28",
        "address": "206 Washington St SW, Atlanta, GA 30334",
        "phone_number": null,
        "email": "testuser28@email.com",
        "avatar": null,
        "latitude": 33.748994,
        "longitude": -84.3880503
      },
      "ridable_type": "User",
      "distance_from_origin": 20,
      "distance_from_destination": 2,
      "rider_role": "Passenger"
    },
    {
      "appointment_id": 30,
      "rider": {
        "id": 20,
        "first_name": "Child",
        "last_name": "Name",
        "age": 9,
        "dob": "2005-12-15",
        "address": "206 Washington St SW, Atlanta, GA 30334",
        "phone_number": "(404) 221-2540",
        "height": 100,
        "weight": 100,
        "latitude": 33.748994,
        "longitude": -84.3880503,
        "parent": {
          "id": 15,
          "username": "testuser28",
          "first_name": "test",
          "last_name": "user28",
          "address": "206 Washington St SW, Atlanta, GA 30334",
          "phone_number": null,
          "email": "testuser28@email.com",
          "avatar": null,
          "latitude": 33.748994,
          "longitude": -84.3880503
        },
        "medical": null,
        "contacts": null
      },
      "ridable_type": "Child",
      "distance_from_origin": 20,
      "distance_from_destination": 2,
      "rider_role": "Passenger"
    }
  ]
}
```

#### Update a User's Rider Role

Allows the user's rider type to change between "Driver" and "Passenger".

Path:
`PUT '/user/:username/appointment/:id'`

**Parameters**

Name | Type | Description
--- | --- | ---
rider_role | string | **Required** The user's role in the appointment, either "Driver" or "Passenger".

**Status Codes**

Code | Type | Description
---|---|---
200 | Success | Server has processed the request and has successfully updated the user.
422 | Error | Unprocessable Entry. Specified parameters are invalid.

**Example Input**

```
{
  "rider_role": "Driver"
}
```

**Example Response**

```
{
  "id": 30,
  "carpool_id": 17,
  "creator": {
    "id": 11,
    "username": "testuser23",
    "first_name": "test",
    "last_name": "user22",
    "address": "100 Peachtree St NE Atlanta, GA",
    "phone_number": "(404) 221-2540",
    "email": "test23@email.com",
    "avatar": "http://i.imgur.com/nepC0uk.jpg",
    "latitude": 33.7868171,
    "longitude": -84.3827744
  },
  "start": "2015-07-15T19:00:00.000-04:00",
  "title": "New Appointment Title",
  "description": null,
  "origin": "10800 Alpharetta Hwy Roswell, GA",
  "origin_latitude": 34.0437521,
  "origin_longitude": -84.3419778,
  "destination": "650 Ponce De Leon Ave NE Atlanta, GA",
  "destination_latitude": 33.7770005,
  "destination_longitude": -84.3665289,
  "distance_filter": 50,
  "riders": [
    {
      "appointment_id": 30,
      "rider": {
        "id": 11,
        "username": "testuser23",
        "first_name": "test",
        "last_name": "user22",
        "address": "100 Peachtree St NE Atlanta, GA",
        "phone_number": "(404) 221-2540",
        "email": "test23@email.com",
        "avatar": "http://i.imgur.com/nepC0uk.jpg",
        "latitude": 33.7868171,
        "longitude": -84.3827744
      },
      "ridable_type": "User",
      "distance_from_origin": 17,
      "distance_from_destination": 1,
      "rider_role": "Driver"
    },
    {
      "appointment_id": 30,
      "rider": {
        "id": 20,
        "first_name": "Child",
        "last_name": "Name",
        "age": 9,
        "dob": "2005-12-15",
        "address": "206 Washington St SW, Atlanta, GA 30334",
        "phone_number": "(404) 221-2540",
        "height": 100,
        "weight": 100,
        "latitude": 33.748994,
        "longitude": -84.3880503,
        "parent": {
          "id": 15,
          "username": "testuser28",
          "first_name": "test",
          "last_name": "user28",
          "address": "206 Washington St SW, Atlanta, GA 30334",
          "phone_number": null,
          "email": "testuser28@email.com",
          "avatar": null,
          "latitude": 33.748994,
          "longitude": -84.3880503
        },
        "medical": null,
        "contacts": null
      },
      "ridable_type": "Child",
      "distance_from_origin": 20,
      "distance_from_destination": 2,
      "rider_role": "Passenger"
    },
    {
      "appointment_id": 30,
      "rider": {
        "id": 15,
        "username": "testuser28",
        "first_name": "test",
        "last_name": "user28",
        "address": "206 Washington St SW, Atlanta, GA 30334",
        "phone_number": null,
        "email": "testuser28@email.com",
        "avatar": null,
        "latitude": 33.748994,
        "longitude": -84.3880503
      },
      "ridable_type": "User",
      "distance_from_origin": 20,
      "distance_from_destination": 2,
      "rider_role": "Driver"
    }
  ]
}
```

#### Remove a User from Appointment

Deletes a user from a specified appointment.

Path: 
`DELETE '/user/:username/appointment/:id'`

**Parameters**
*None*

**Status Code**

Code | Type | Description
---|---|---
204 | Success | Request was received and deleted successfully.
400 | Error | Bad Request. Specified parameters do not match.
401 | Error | Unauthorized. A different user is not authorized to delete another user's appointment.

**Example Response**

```
No message is returned.
```

#### Remove a Child from Appointment

Deletes a child from a specified appointment.

Path: 
`DELETE '/child/:child_id/appointment/:id'`

**Parameters**
*None*

**Status Code**

Code | Type | Description
---|---|---
204 | Success | Request was received and deleted successfully.
400 | Error | Bad Request. Specified parameters do not match.
401 | Error | Unauthorized. A different user is not authorized to delete another user's child appointment.

**Example Response**

```
No message is returned.
```

## **Post Model**

#### Carpool's Post Index

List of all posts in a carpool

Path:
`GET '/carpool/:id/posts'`

**Parameters**
*None*

**Status Codes**

Code | Type | Description
---|---|---
200 | Success | All posts were successfully returned.
404 | Error | Not Found. Specified parameters do not match.

**Example Response**

```
[
  {
    "id": 3,
    "carpool": {
      "id": 17,
      "creator": {
        "id": 11,
        "username": "testuser23",
        "first_name": "test",
        "last_name": "user22",
        "address": "100 Peachtree St NE Atlanta, GA",
        "phone_number": "(404) 221-2540",
        "email": "test23@email.com",
        "avatar": "http://i.imgur.com/nepC0uk.jpg",
        "latitude": 33.7868171,
        "longitude": -84.3827744
      },
      "title": "Something",
      "description": "desc1"
    },
    "user": {
      "id": 15,
      "username": "testuser28",
      "first_name": "test",
      "last_name": "user28",
      "address": "206 Washington St SW, Atlanta, GA 30334",
      "phone_number": null,
      "email": "testuser28@email.com",
      "avatar": null,
      "latitude": 33.748994,
      "longitude": -84.3880503
    },
    "urgency": "High",
    "title": "Post Title1",
    "body": "I need someone to take me to PostTitle1.",
    "updated_at": "2015-07-18T00:21:37.713-04:00"
  },
  {
    "id": 4,
    "carpool": {
      "id": 17,
      "creator": {
        "id": 11,
        "username": "testuser23",
        "first_name": "test",
        "last_name": "user22",
        "address": "100 Peachtree St NE Atlanta, GA",
        "phone_number": "(404) 221-2540",
        "email": "test23@email.com",
        "avatar": "http://i.imgur.com/nepC0uk.jpg",
        "latitude": 33.7868171,
        "longitude": -84.3827744
      },
      "title": "Something",
      "description": "desc1"
    },
    "user": {
      "id": 15,
      "username": "testuser28",
      "first_name": "test",
      "last_name": "user28",
      "address": "206 Washington St SW, Atlanta, GA 30334",
      "phone_number": null,
      "email": "testuser28@email.com",
      "avatar": null,
      "latitude": 33.748994,
      "longitude": -84.3880503
    },
    "urgency": "Low",
    "title": "Post Title2",
    "body": "Joy Ride!",
    "updated_at": "2015-07-18T00:22:42.532-04:00"
  }
]
```

#### Show a Post

Shows the attributes of a specified post.

Path: 
`GET '/post/:id'`

**Parameters**
*None*

**Status Codes**

Code | Type | Description
---|---|---
200 | Success | All users were successfully returned.
404 | Error | Not Found. Specified parameters do not match.

**Example Response**

```
{
  "id": 3,
  "carpool": {
    "id": 17,
    "creator": {
      "id": 11,
      "username": "testuser23",
      "first_name": "test",
      "last_name": "user22",
      "address": "100 Peachtree St NE Atlanta, GA",
      "phone_number": "(404) 221-2540",
      "email": "test23@email.com",
      "avatar": "http://i.imgur.com/nepC0uk.jpg",
      "latitude": 33.7868171,
      "longitude": -84.3827744
    },
    "title": "Something",
    "description": "desc1"
  },
  "user": {
    "id": 15,
    "username": "testuser28",
    "first_name": "test",
    "last_name": "user28",
    "address": "206 Washington St SW, Atlanta, GA 30334",
    "phone_number": null,
    "email": "testuser28@email.com",
    "avatar": null,
    "latitude": 33.748994,
    "longitude": -84.3880503
  },
  "urgency": "High",
  "title": "Post Title1",
  "body": "I need someone to take me to PostTitle1.",
  "updated_at": "2015-07-18T00:21:37.713-04:00"
}
```

#### Create a Post

Creates a post associated with a specified carpool. Forms should include all required fields to be passed with the request.

Path: 
`POST '/carpool/:id/posts'`

**Parameters**

Name | Type | Description
--- | --- | ---
urgency | string | The designated urgency of a post. (Recommended: Low, Medium, High)
title | string | **Required.** The title of a post.
body | text | **Required.** The main body of a post.

**Status Codes**

Code | Type | Description
--- | --- | ---
201 | Success | Server has processed the request and has successfully created the post.
422 | Error | Unprocessable Entry. Specified parameters are invalid.

**Example Input**

```
{
  "title": "School Pickup",
  "urgency": "Medium",
  "body": "I need someone to take my child (Bobby) to school on this upcoming Monday."
}
```

**Example Response**

```
{
  "id": 5,
  "carpool": {
    "id": 17,
    "creator": {
      "id": 11,
      "username": "testuser23",
      "first_name": "test",
      "last_name": "user22",
      "address": "100 Peachtree St NE Atlanta, GA",
      "phone_number": "(404) 221-2540",
      "email": "test23@email.com",
      "avatar": "http://i.imgur.com/nepC0uk.jpg",
      "latitude": 33.7868171,
      "longitude": -84.3827744
    },
    "title": "Something",
    "description": "desc1"
  },
  "user": {
    "id": 15,
    "username": "testuser28",
    "first_name": "test",
    "last_name": "user28",
    "address": "206 Washington St SW, Atlanta, GA 30334",
    "phone_number": null,
    "email": "testuser28@email.com",
    "avatar": null,
    "latitude": 33.748994,
    "longitude": -84.3880503
  },
  "urgency": "Medium",
  "title": "School Pickup",
  "body": "I need someone to take my child (Bobby) to school on this upcoming Monday.",
  "updated_at": "2015-07-18T00:30:31.675-04:00"
}
```

#### Update a Post

Updates the specified attributes for a specified post. Forms should include all required fields to be passed with the request.

Path: 
`PUT '/post/:id'`

**Parameters**

**Parameters**

Name | Type | Description
--- | --- | ---
urgency | string | The designated urgency of a post. (Recommended: Low, Medium, High)
title | string | **Required.** The title of a post.
body | text | **Required.** The main body of a post.

**Status Codes**

Code | Type | Description
--- | --- | ---
200 | Success | Server has processed the request and has successfully updated the post.
422 | Error | Unprocessable Entry. Specified parameters are invalid.

**Example Input**

```
{
  "urgency": "High",
  "body": "I need someone to take my child (Bobby) to school on this upcoming Monday. (IT'S TOMORROW NOW!!! PLEASE!)"
}
```

**Example Response**

```
{
  "id": 5,
  "carpool": {
    "id": 17,
    "creator": {
      "id": 11,
      "username": "testuser23",
      "first_name": "test",
      "last_name": "user22",
      "address": "100 Peachtree St NE Atlanta, GA",
      "phone_number": "(404) 221-2540",
      "email": "test23@email.com",
      "avatar": "http://i.imgur.com/nepC0uk.jpg",
      "latitude": 33.7868171,
      "longitude": -84.3827744
    },
    "title": "Something",
    "description": "desc1"
  },
  "user": {
    "id": 15,
    "username": "testuser28",
    "first_name": "test",
    "last_name": "user28",
    "address": "206 Washington St SW, Atlanta, GA 30334",
    "phone_number": null,
    "email": "testuser28@email.com",
    "avatar": null,
    "latitude": 33.748994,
    "longitude": -84.3880503
  },
  "urgency": "High",
  "title": "School Pickup",
  "body": "I need someone to take my child (Bobby) to school on this upcoming Monday. (IT'S TOMORROW NOW!!! PLEASE!)",
  "updated_at": "2015-07-18T00:35:11.458-04:00"
}
```

#### Delete a Post

Deletes a specified post.

Path:
`DELETE '/post/:id'`

**Parameters**
*None*

**Status Codes**

Code | Type | Description
---|---|---
204 | Success | Request was received and deleted successfully.
404 | Error | Not Found. Specified parameters do not match.

**Example Response**

```
No message returned.
```


