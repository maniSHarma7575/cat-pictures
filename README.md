# 🐱 Cat Pictures API

A simple JSON API to manage cat pictures with titles and image attachments using Ruby on Rails and Active Storage.

---

## 📦 Base URL

`/api/cat_pictures`

---

## 🔍 Endpoints

### GET `/api/cat_pictures`

Fetch all cat pictures with their titles and image URLs.

#### Response

```json
[
  {
    "id": 1,
    "title": "Sleepy Cat",
    "created_at": "2025-05-06T12:00:00Z",
    "updated_at": "2025-05-06T12:00:00Z",
    "attachment_url": "http://localhost:3000/rails/active_storage/blobs/..."
  }
]
```


⸻

GET `/api/cat_pictures/:id`

Fetch a specific cat picture by ID.

Response
```json
{
  "id": 1,
  "title": "Sleepy Cat",
  "created_at": "2025-05-06T12:00:00Z",
  "updated_at": "2025-05-06T12:00:00Z"
}
```

Note: attachment_url is only included in the index endpoint.

⸻

POST `/api/cat_pictures`

Create a new cat picture.

Request (multipart/form-data)

Field	Type	Required	Description
title	string	Yes	Title of the cat picture
attachment	file	Yes	Image file (JPEG, PNG, etc.)

Example (cURL)

```sh
curl -X POST http://localhost:3000/api/cat_pictures \
  -F "title=Cute Cat" \
  -F "attachment=@cat_image.jpeg"
```

Success Response
  - Status: 201 Created
  - JSON body with created picture data

⸻

PATCH `/api/cat_pictures/:id`

Update an existing cat picture.

Request (multipart/form-data)

Field	Type	Required	Description
title	string	No	New title for the cat picture
attachment	file	No	New image file to replace existing

Example (cURL)

```sh
curl -X PATCH http://localhost:3000/api/cat_pictures/1 \
  -F "title=Even Cuter Cat" \
  -F "attachment=@new_cat_image.jpeg"
```

Success Response
  - Status: 200 OK
  - JSON body with updated picture data

⸻

DELETE `/api/cat_pictures/:id`

Delete a cat picture by ID.

Success Response
  - Status: 204 No Content

⸻

⚠️ Error Responses

Code	Message
404	Cat picture not found
422	Validation failed

⸻
🛠 Tech Stack
  - Ruby on Rails
  - Active Storage
	- JSON API
	- Multipart form uploads
⸻

📁 File Upload Notes
  - File uploads must be sent as multipart/form-data.
  - application/json is not supported for image uploads.
⸻