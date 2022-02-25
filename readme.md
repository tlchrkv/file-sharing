# File Sharing Service

Upload files ang get share links for free.  
- File encryption by password for private access. We don`t save password and password hash.
- Image cropping
- Auto deletion. The file will be stored for a maximum of 14 days.
- Image meta-data deletion on upload for keep your security
- Special link to admin area for manage existent file

---
### Available environments
1. `local` - default .env from .env.dist (`http://127.0.0.1:3002`), this env showing all errors with trace.
2. `dev` - need to manually change .env file: `APP_ENV`, `APP_URL`. Showing short errors.

### Technologies
###### Backend
- PHP 7.2
- Phalcon 3.4.2
- Docker & Docker-Compose
- Nginx
- PostgreSQL
- OpenSSL

###### Frontend
- Bootstrap 5
- jQuery
- Cropper JS
- Material Icons
- SCSS
- Webpack

##### System requirements
- Unix OC
- Installed Docker
- Installed Docker-Compose

---
### How to deploy in the first time
1. Create docker-compose.yml file by .dist template:
```bash
cp docker-compose.yml.dist docker-compose.yml
```
If you need, change the public port of nginx container.

2. Similar for .env file:
```bash
cp .env.dist .env
```
Set up suitable `APP_ENV`, `APP_URL`, `APP_NAME`, `MAX_FILE_MEGABYTES`  

3. Build and up containers using docker-compose:
```bash
docker-compose up -d --build
```

4. Run migrations:
```bash
docker exec -ti fss_backend bash
```
```bash
php phalcon run-migration
```

5. Done. Check the functionality: `http://your-server-url:port/`  

---
