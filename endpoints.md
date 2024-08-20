Here's a well-formatted API documentation based on the information you provided:

# Geolocation API Documentation

## Base URL
`http://localhost:3000/api/v1`

## Authentication
Most endpoints require a Bearer token for authentication. Obtain this token by logging in through the User Login endpoint.

## Endpoints

### User Login
Authenticate a user and receive a token.

- **URL:** `/users/login`
- **Method:** `POST`
- **Auth required:** No

#### Request Body
```json
{
  "user": {
    "email": "test@example.com",
    "password": "password123"
  }
}
```

#### Success Response
- **Code:** 200 OK
- **Content:**
```json
{
  "token": "eyJhbGciOiJIUzI1NiJ9...",
  "email": "test@example.com"
}
```

### User Registration
Register a new user.

- **URL:** `/users`
- **Method:** `POST`
- **Auth required:** No

#### Request Body
```json
{
  "user": {
    "email": "test@example.com",
    "password": "password123"
  }
}
```

#### Success Response
- **Code:** 201 Created
- **Content:**
```json
{
  "id": 2,
  "email": "test@example.com"
}
```

### Get Geolocation
Retrieve geolocation information for a given IP address.

- **URL:** `/geolocation`
- **Method:** `GET`
- **Auth required:** Yes (Bearer Token)

#### Request Body
```json
{
  "geolocation": {
    "ip": "134.201.250.155"
  }
}
```

#### Success Response
- **Code:** 200 OK
- **Content:**
```json
{
  "id": 2,
  "ip": "157.240.0.35",
  "ip_type": "ipv4",
  "continent_code": "EU",
  "continent_name": "Europe",
  "country_code": "DE",
  "country_name": "Germany",
  "region_code": "HE",
  "region_name": "Hesse",
  "city": "Frankfurt am Main",
  "zip": "60311",
  "latitude": "50.11090087890625",
  "longitude": "8.68210029602051",
  "created_at": "2024-08-19 23:55:54 UTC",
  "updated_at": "2024-08-19 23:55:54 UTC"
}
```

### Create Geolocation
Create a new geolocation entry.

- **URL:** `/geolocation`
- **Method:** `POST`
- **Auth required:** Yes (Bearer Token)

#### Request Body
```json
{
  "geolocation": {
    "ip": "https://facebook.com"
  }
}
```

#### Success Response
- **Code:** 200 OK
- **Content:**
```json
{
  "output": {
    "id": 2,
    "ip": "157.240.0.35",
    "ip_type": "ipv4",
    "continent_code": "EU",
    "continent_name": "Europe",
    "country_name": "Germany",
    "country_code": "DE",
    "region_code": "HE",
    "region_name": "Hesse",
    "city": "Frankfurt am Main",
    "zip": "60311",
    "latitude": "50.11090087890625",
    "longitude": "8.68210029602051",
    "created_at": "2024-08-19T23:55:54.164Z",
    "updated_at": "2024-08-19T23:55:54.164Z"
  }
}
```

### Delete Geolocation
Delete a geolocation entry.

- **URL:** `/geolocation`
- **Method:** `DELETE`
- **Auth required:** Yes (Bearer Token)

#### Request Body
```json
{
  "geolocation": {
    "ip": "123.231.89.01"
  }
}
```

#### Success Response
- **Code:** 200 OK
- **Content:**
```json
{
  "message": "Geolocation deleted successfully"
}
```

## Notes
- The `ip` parameter in geolocation-related endpoints can be either a URL or an IP address.
- All dates and times are in UTC.
