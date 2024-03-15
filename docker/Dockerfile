# FROM ubuntu:latest
# I am using ubuntu version 22.04,  because  ubuntu latest sometime unpredictable and cause issues in the future 
FROM ubuntu:22.04  
ARG DEBIAN_FRONTEND=noninteractive

# Set the timezone for postgres geo location
ENV TZ=Europe/London
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Update the package repository and install PostgreSQL
# RUN apt-get update && apt-get install -y postgresql

# Update the package repository and install PostgreSQL 14 and openssl
RUN apt-get update && apt-get install -y postgresql-14 openssl

# Genrate random password for postgres user and save it in a file
RUN mkdir -p /var/run/secrets/pg
RUN echo "postgres:$(openssl rand -base64 32)" > /var/run/secrets/pg/pg_pass  && \
    chmod 600 /var/run/secrets/pg/pg_pass


# Create a new PostgreSQL user and database
# RUN service postgresql start && \
# su - postgres -c "psql -c 'CREATE USER myuser WITH PASSWORD mypassword;'" && \
# su - postgres -c "createdb -O myuser mydatabase"

# Create a new PostgreSQL user and database
RUN service postgresql start && \
    su - postgres -c "psql -c \"CREATE USER myuser WITH PASSWORD '$(cat /var/run/secrets/pg/pg_pass)';\"" && \
    su - postgres -c "createdb -O myuser mydatabase;" && \
    service postgresql stop


# Configure PostgreSQL to allow connections from all IP addresses
# RUN sed -i 's/#listen_addresses = 'localhost'/listen_addresses = '*'/'
# /etc/postgresql/13/main/postgresql.conf && \
# echo "host all all 0.0.0.0/0 trust" >> /etc/postgresql/13/main/pg_hba.conf

RUN sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" /etc/postgresql/14/main/postgresql.conf && \
    echo "host all all 0.0.0.0/0 trust" >> /etc/postgresql/14/main/pg_hba.conf 

ENV PATH="/usr/lib/postgresql/14/bin:${PATH}"

# Expose the PostgreSQL default port
EXPOSE 5432

# Ser user to postgres
USER postgres

# add the initdb command to create the data directory
RUN initdb -D /var/lib/postgresql/data


# Start the PostgreSQL service in foreground
CMD ["postgres", "-D", "/var/lib/postgresql/data"]

# To build the image
# docker build -t my-postgres .

# To run the container
# docker run -d -p 5432:5432 -v postgres_data:/var/lib/postgresql/data --name my-postgre my-postgre

# To view the logs
# docker logs my-postgres

# To stop the container
# docker stop my-postgres
