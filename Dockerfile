# Stage 1: Build dependencies
FROM php:8.2-cli AS build

# Install required system packages and PHP extensions
RUN apt-get update && apt-get install -y \
    git unzip libpng-dev libjpeg-dev libonig-dev libxml2-dev \
    && docker-php-ext-install pdo pdo_mysql

# Install Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www/html

# Copy composer files first for dependency caching
COPY app/composer.json app/composer.lock ./

# Install PHP dependencies (production only)
RUN composer install --no-dev --optimize-autoloader --ignore-platform-reqs

# Copy full project source
COPY app/ .

# Stage 2: Runtime container
FROM php:8.2-cli

# Copy built app
WORKDIR /var/www/html
COPY --from=build /var/www/html /var/www/html

# Set permissions for runtime (if needed)
RUN chown -R www-data:www-data /var/www/html

# Expose the port your `flexiapi serve` command uses (e.g., 8080)
EXPOSE 8080

# Run your framework’s built-in server
CMD ["php", "flexiapi", "serve"]
