# Stage 1: Build dependencies
FROM php:8.2-cli AS build

# Install system dependencies and PHP extensions
RUN apt-get update && apt-get install -y \
    git unzip libpng-dev libjpeg-dev libonig-dev libxml2-dev \
    && docker-php-ext-install pdo pdo_mysql

# Install Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www/html

# Copy composer files first (for dependency caching)
COPY composer.json composer.lock ./

# Install PHP dependencies (production)
RUN composer install --no-dev --optimize-autoloader --ignore-platform-reqs

# Copy full project source
COPY . .

# Stage 2: Runtime container
FROM php:8.2-cli

WORKDIR /var/www/html

# Copy app from build stage
COPY --from=build /var/www/html /var/www/html

# Set permissions
RUN chown -R www-data:www-data /var/www/html

# Expose your app port
EXPOSE 8080

# Run your custom CLI command
CMD ["php", "flexiapi", "serve"]
