# Stage 1: Build dependencies
FROM php:8.2-cli AS build

# Install dependencies
#RUN apt-get update && apt-get install -y \
#    libpng-dev libjpeg-dev libonig-dev libxml2-dev zip unzip git curl \
#    && docker-php-ext-install pdo pdo_mysql

# Install Composer
#COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /app

# Copy source
COPY . .

# Install PHP dependencies
#RUN composer install --no-dev --optimize-autoloader --ignore-platform-reqs

# Stage 2: Run app
FROM php:8.2-cli

WORKDIR /app

# Copy built files
#COPY --from=build /app /app

# Expose API port
EXPOSE 8080

# Fix permissions
#RUN chmod +x bin/flexiapi

# Run your CLI command
#CMD ["php", "bin/flexiapi", "serve", "--port=8080"]
