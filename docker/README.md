**Issues with Original Dockerfile and Fixes**

**Ubuntu Version:** Changed Ubuntu version to 22.04 from Ubuntu:latest due to unpredictability.

**Noninteractive Installation:** Added **DEBIAN_FRONTEND=noninteractive** argument to prevent interactive prompts during installation. Set timezone to Europe/London for PostgreSQL's geographical location.

**PostgreSQL Version:** Installed PostgreSQL version 14 as there was an error message indicating "**Unable to locate package PostgreSQL 13**" during Docker build.

**OpenSSL Installation:** Installed **openssl** package to generate a 32-bit random password for PostgreSQL user creation.

**Password Storage:** Generated a random password and stored it in **/var/run/secrets/pg/pg_pass**.

**User Creation:** Created the PostgreSQL user using the generated password.

**Environment Variable:** Set the environment variable path as "**/usr/lib/postgresql/14/bin**" for easier access to PostgreSQL binaries.

**Database Initialization:** Used **initdb** command to create the data directory before starting the container.

**PostgreSQL Server Start:** Started the PostgreSQL server with the created data directory.

**Verification Commands:** Added a few Docker commands for verifying the PostgreSQL container during troubleshooting and fixing.

By addressing these issues and implementing the corresponding fixes, the Dockerfile now ensures smoother and more reliable PostgreSQL installation and setup within the container.

--------------------------------------------------------------------------------

**Instructions for Building Docker Image and Running Docker Container**

**Building Docker Image:**
To build a Docker image from the Dockerfile, use the docker build command. Here's an example:

```
❯ docker build -t postgres-test .
[+] Building 0.8s (13/13) FINISHED                                                                                          docker:desktop-linux
 => [internal] load build definition from Dockerfile                                                                                        0.0s
 => => transferring dockerfile: 2.40kB                                                                                                      0.0s
 => [internal] load metadata for docker.io/library/ubuntu:22.04                                                                             0.8s
 => [auth] library/ubuntu:pull token for registry-1.docker.io                                                                               0.0s
 => [internal] load .dockerignore                                                                                                           0.0s
 => => transferring context: 2B                                                                                                             0.0s
 => [1/8] FROM docker.io/library/ubuntu:22.04@sha256:77906da86b60585ce12215807090eb327e7386c8fafb5402369e421f44eff17e                       0.0s
 => CACHED [2/8] RUN ln -snf /usr/share/zoneinfo/Europe/London /etc/localtime && echo Europe/London > /etc/timezone                         0.0s
 => CACHED [3/8] RUN apt-get update && apt-get install -y postgresql-14 openssl                                                             0.0s
 => CACHED [4/8] RUN mkdir -p /var/run/secrets/pg                                                                                           0.0s
 => CACHED [5/8] RUN echo "postgres:$(openssl rand -base64 32)" > /var/run/secrets/pg/pg_pass  &&     chmod 600 /var/run/secrets/pg/pg_pas  0.0s
 => CACHED [6/8] RUN service postgresql start &&     su - postgres -c "psql -c "CREATE USER myuser WITH PASSWORD '$(cat /var/run/secrets/p  0.0s
 => CACHED [7/8] RUN sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" /etc/postgresql/14/main/postgresql.conf &&     ec  0.0s
 => CACHED [8/8] RUN initdb -D /var/lib/postgresql/data                                                                                     0.0s
 => exporting to image                                                                                                                      0.0s
 => => exporting layers                                                                                                                     0.0s
 => => writing image sha256:5a6434ee4bfb4bbe782499f712b92523a7070269d04ce3c02adeb6397ef48f3f                                                0.0s
 => => naming to docker.io/library/postgres-test 
```

**Running Docker Container:**
After building the Docker image, you can run a Docker container using the following example command:

```
❯ docker rm postgres-test; docker run -d -p 5432:5432 -v postgres_data:/var/lib/postgresql/data --name postgres-test postgres-test
postgres-test
a1a3f50a9a3b12e3f2224f96aae37bd45d552a289880c6000b054020f2ab0fe4
```


**Viewing Docker Logs:**
To view the logs of the Docker container, use the docker logs command. Here's an example:

```
❯ docker logs postgres-test
2024-03-15 15:07:18.456 GMT [1] LOG:  starting PostgreSQL 14.11 (Ubuntu 14.11-0ubuntu0.22.04.1) on x86_64-pc-linux-gnu, compiled by gcc (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0, 64-bit
2024-03-15 15:07:18.456 GMT [1] LOG:  listening on IPv4 address "127.0.0.1", port 5432
2024-03-15 15:07:18.456 GMT [1] LOG:  could not bind IPv6 address "::1": Cannot assign requested address
2024-03-15 15:07:18.459 GMT [1] LOG:  listening on Unix socket "/var/run/postgresql/.s.PGSQL.5432"
2024-03-15 15:07:18.462 GMT [7] LOG:  database system was shut down at 2024-03-15 15:07:16 GMT
2024-03-15 15:07:18.466 GMT [1] LOG:  database system is ready to accept connections
```

**Viewing PostgreSQL User Password:**
To view the PostgreSQL user password stored in /var/run/secrets/pg/pg_pass within the Docker container, use the following command:

```
❯ docker exec -u root -it postgres-test cat /var/run/secrets/pg/pg_pass
postgres:DYUlUoIfQdy3jR0blXdeP/uRaLQ1hasgB7P7wR8KeiY=
```

These refined instructions provide clear and concise steps for building the Docker image, running the Docker container, viewing Docker logs, and retrieving the PostgreSQL user password. Adjustments have been made for clarity and readability.

