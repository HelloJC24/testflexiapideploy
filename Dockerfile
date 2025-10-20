# Stage 1: Build dependencies
FROM php:8.2-fpm AS build

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libpng-dev libjpeg-dev libonig-dev libxml2-dev zip unzip git curl \
    && docker-php-ext-install pdo pdo_mysql

# Install Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Copy app source
WORKDIR /var/www/html
COPY . .

# Install PHP dependencies
RUN composer install --no-dev --optimize-autoloader --ignore-platform-reqs

# Stage 2: Serve app with Apache
FROM php:8.2-apache

# Enable Apache mods
RUN a2enmod rewrite

# Copy built app from previous stage
COPY --from=build /var/www/html /var/www/html

# Set working directory
WORKDIR /var/www/html

# Fix permissions
RUN chown -R www-data:www-data /var/www/html

# Update Apache document root to /public (your API entry point)
RUN sed -i 's|/var/www/html|/var/www/html/public|g' /etc/apache2/sites-available/000-default.conf

# Expose port 8080
EXPOSE 8080

# Start your API (if flexiapi serve is a CLI command)
CMD ["php", "bin/flexiapi", "serve", "--port=8080"]
