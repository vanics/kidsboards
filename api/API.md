# API Reference

## About

Kids Boards API is organized around REST. This API has predictable, resource-oriented URLs, and uses HTTP response codes to indicate API errors. JSON(or nothing in case of 204) is returned by all API responses, including errors.

### Authentication

Authentication to the API is performed via token-based system. In most cases token must be sent as a POST parameter.

### Errors

API uses HTTP response codes to indicate the success or failure of an API request. In general, codes 200 and 204 indicate success, codes in the 4xx range indicate an error that failed given the information provided, and 500 code indicates an error with Kids Boards' servers (these are rare).

### HTTP status code summary

 - 200 - OK. Everything worked as expected and there is some response.
 - 204 - OK. Everything worked as expected and there is an empty response.
 - 401 - Unauthorized. No valid token provided.
 - 403 - Forbidden. User has no permissions to run this action.
 - 404 - Not Found. The requested path doesn't exist.
 - 500 - Server Error. Something went wrong on API's end. (These are rare.)

### Common validation errors

 - is invalid
 - can't be blank
 - is too short (minimum is N characters)
 - has wrong format

## User

### Register

Registers new user.

`` POST api.kidsboards.org/v1/user/register ``

Parameters:

 - email
 - password (at least 6 characters)

Possible responses:

 - 200
 - 422

Response example:

```
{
  id: 1
}
```

### Login

Checks presented email and password and returns a token if they are right.

`` POST api.kidsboards.org/v1/user/login ``

Parameters:

 - email
 - password (at least 6 characters)

Possible responses:

 - 200
 - 422

Response example:

```
{
    token: 'abcdef12345'
}
```

Additional validation errors:

  - `` {email: 'Wrong email or password'} ``

### Logout

Marks the token as expired.

`` POST api.kidsboards.org/v1/user/logout ``

Parameters:

 - token

Possible responses:

 - 204
 - 401

### Confirm

Confirms user's email.

`` GET api.kidsboards.org/v1/user/confirm ``

Parameters:

 - token

Possible responses:

 - 204
 - 401

### Password recovery request

Sends an email to the user with instructions to recovery the password.

`` POST api.kidsboards.org/v1/user/request ``

Parameters:

 - email

Possible responses:

 - 204
 - 422

### Password recovery

Changes user's password.

`` POST api.kidsboards.org/v1/user/recovery ``

Parameters:

 - password (at least 6 characters)

Possible responses:

 - 204
 - 401
 - 422

### Pin set

Sets a new pin code. Pin is needed to avoid children to change something. Because in this case our enemies are just kids the security level is very low.

`` PATCH api.kidsboards.org/v1/user/pin ``

Parameters:

 - token
 - pin (4 digits as a string)

Possible responses:

 - 204
 - 401
 - 422

### Pin check

Checks that the pin is correct.

`` GET api.kidsboards.org/v1/user/pin ``

Parameters:

 - token
 - pin (4 digits as a string)

Possible responses:

 - 200
 - 401
 - 422

Response example:

```
{
     equal: true
}
```

## File

### Create a photo

Creates a photo.

`` POST api.kidsboards.org/v1/uploaded/photo ``

Parameters:

 - token
 - file (only images)

Possible responses:

 - 200
 - 401
 - 422

Response example:

```
{
     id: 1,
     photo_url: 'url'
}
```

Additional validation errors:

  - `` {file: 'wrong type'} ``

### List of photos

Shows the list of photos uploaded by the user.

`` GET api.kidsboards.org/v1/uploaded/photo ``

Parameters:

 - token

Possible responses:

 - 200
 - 401

Response example:

```
{
     photos:
     [
         {
             id: 1,
             photo_url: 'url'
         },
         {
             id: 2,
             photo_url: 'url'
         },
         ...
     ]
}
```

### Delete a photo

Deletes the photo.

`` DELETE api.kidsboards.org/v1/uploaded/photo/:id ``

Parameters:

 - token

Possible responses:

 - 204
 - 401
 - 403
 - 422

## Family

### View

Shows information about the family.

`` GET api.kidsboards.org/v1/family ``

Parameters:

 - token

Possible responses:

 - 200
 - 401

Response example:

```
{
   name: Bill,
   photo_url: url,
   adults:
        [
            {
                id: 1,
                name: 'Bill',
                photo_url: 'url'
            },
            {
                id: 2,
                name: 'John',
                photo_url: 'url'
            },
            ...
        ],
   children:
        [
            {
                id: 1,
                name: 'Bill',
                photo_url: 'url'
            },
            {
                id: 2,
                name: 'John',
                photo_url: 'url'
            },
            ...
        ]
}
```

### Update

Updates the family.

`` PUT api.kidsboards.org/v1/family ``

Parameters:

 - token
 - name
 - photo_url

Possible responses:

 - 204
 - 401
 - 422

### Adult

#### Create

Creates an adult.

`` POST api.kidsboards.org/v1/family/adult ``

Parameters:

 - token
 - name
 - photo_url

Possible responses:

 - 200
 - 401
 - 422

Response example:

```
{
  id: 1
}
```

#### Update

Updates the adult.

`` PUT api.kidsboards.org/v1/family/adult/:id ``

Parameters:

 - token
 - name
 - photo_url

Possible responses:

 - 204
 - 401
 - 403
 - 422

#### Delete

Deletes the adult.

`` DELETE api.kidsboards.org/v1/family/adult/:id ``

Parameters:

 - token

Possible responses:

 - 204
 - 401
 - 403

### Child

#### Create

Creates a child.

`` POST api.kidsboards.org/v1/family/child ``

Parameters:

 - token
 - name
 - photo_url

Possible responses:

 - 200
 - 401
 - 422

Response example:

```
{
  id: 1
}
```

#### Update

Updates the child.

`` PUT api.kidsboards.org/v1/family/child/:id ``

Parameters:

 - token
 - name
 - photo_url

Possible responses:

 - 204
 - 401
 - 403
 - 422

#### Delete

Deletes the child.

`` DELETE api.kidsboards.org/v1/family/child/:id ``

Parameters:

 - token

Possible responses:

 - 204
 - 401
 - 403

### Goal

#### Create

Creates a goal.

`` POST api.kidsboards.org/v1/family/child/:id/goal ``

Parameters:

 - token
 - name
 - photo_url
 - target (an integer between 0 and 1000)

Possible responses:

 - 200
 - 401
 - 403
 - 422

Response example:

```
{
  id: 1
}
```

#### Index

Shows the list of goals.

`` GET api.kidsboards.org/v1/family/child/:id/goal ``

Parameters:

 - token
 - completed (true or false)

Possible responses:

 - 200
 - 401
 - 403
 - 422

Response example:

```
{
     goals:
     [
         {
             id: 1,
             name: 'doll',
             photo_url: 'url',
             target: 50,
             current: 10
         },
         {
             id: 2,
             name: 'doll',
             photo_url: 'url',
             target: 50,
             current: 10
         },
         ...
     ]
}
```

## Goal

### View

Shows the goal.

`` GET api.kidsboards.org/v1/file/goal/:id ``

Parameters:

 - token

Possible responses:

 - 200
 - 401
 - 403
 - 422

Response example:

```
{
   id: 1,
   name: 'doll',
   photo_url: 'url',
   target: 50,
   current: 10,
   created_at: datetime_utc,
   actions:
        [
            {
                adult:
                    {
                        id: 1,
                        name: 'John',
                        photo_url: 'url',
                    }
                diff: 12,
                created_at: datetime_utc
            },
            {
                adult:
                    {
                        id: 1,
                        name: 'John',
                        photo_url: 'url',
                    }
                diff: -2,
                created_at: datetime_utc
            },
        ]
}
```

### Update

Updates the goal.

`` PUT api.kidsboards.org/v1/file/goal/:id ``

Parameters:

 - token
 - name
 - photo_url
 - target (an integer between 0 and 1000)

Possible responses:

 - 204
 - 401
 - 403
 - 422

### Delete

Deletes the goal.

`` DELETE api.kidsboards.org/v1/file/goal/:id ``

Parameters:

 - token

Possible responses:

 - 204
 - 401
 - 403
 - 422

### Points update

Adds or removes points of the goal.

`` PATCH api.kidsboards.org/v1/file/goal/:id/points ``

Parameters:

 - token
 - diff (integer)
 - adult_id

Possible responses:

 - 200
 - 401
 - 403
 - 422

Response example:

```
 {
   current: 10,
   target: 12
 }
```