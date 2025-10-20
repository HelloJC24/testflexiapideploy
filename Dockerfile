# Use official PHP 8.2 CLI image
FROM php:8.2-cli

# Set working directory
WORKDIR /app

# Install PHP extensions
RUN docker-php-ext-install pdo pdo_mysql

# Install Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Copy project files
COPY . .

# Install dependencies
RUN composer install --no-dev --no-interaction --prefer-dist --optimize-autoloader

# Expose port for Dokploy
EXPOSE 8080

# Start your API via FlexiAPI CLI
CMD ["php", "bin/flexiapi", "serve"]
