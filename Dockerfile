# Use the official PHP 8.2 image with Apache
FROM php:8.2-cli

# Set working directory
WORKDIR /app

# Install PHP extensions (pdo_mysql and others)
RUN docker-php-ext-install pdo pdo_mysql

# Install Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Copy app files
COPY . .

# Install dependencies
RUN composer install --no-dev --no-interaction --prefer-dist --optimize-autoloader

# Expose port 8080 for Dokploy or local use
EXPOSE 8000

# Start PHP built-in web server using the "public" folder as document root
CMD ["php", "-S", "0.0.0.0:8000", "-t", "public"]
