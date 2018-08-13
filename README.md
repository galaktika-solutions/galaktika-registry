> This repo is under development. Feel free to submit issues and
> pull requests, clone or fork it for your own use, but be prepared
> for some bugs and more importantly fundamental changes in the future.

# Galaktika Registry

A Docker based two factory authenticated Docker Registry with registry
command line tools and Docker images curator

It is built for those who

* wants production setup to be easy but secure
* has a reasonable knowledge of Docker

# Quick Start for Developers

You will need `Docker`, `Docker Compose` and `make` installed.

1.  Clone the repository

    ```sh
    git clone https://github.com/galaktika-solutions/galaktika-registry.git myproject
    cd myproject
    rm -rf .git
    git init
    ```

1.  Configure you project by creating a `.env` file in the project's root directory
    _(The values here are just examples. Go on with it now, but you have to
    change them soon.)_

    ```env
    DOCKER_REGISTRY_URL=https://HOST:5000
    ROTATE_DAYS=45

    REGISTRY_HTTP_TLS_CERTIFICATE=/certs/certificate.crt
    REGISTRY_HTTP_TLS_KEY=/certs/certificate.key
    REGISTRY_HTTP_TLS_CA=/certs/ca.crt

    EMAIL_HOST=smtp.gmail.com
    EMAIL_PORT=465
    EMAIL_FROM=fron@gmail.com
    EMAIL_RECIPIENT=recipient@gmail.com
    ```

1.  Configure you project by creating a `.secret` file in the project's root directory
    ```env
    DOCKER_REGISTRY_USER=user
    DOCKER_REGISTRY_PASSWORD=password

    EMAIL_USER=username
    EMAIL_PASSWORD=password
    ```

1.  Generate ssh certificate (for example: localhost) and create the first user.
    If you finish it you can start the project
    ```sh
    make create_certificate
    make create_user
    docker-compose up -d
    ```

1.  Config your The client computer:
