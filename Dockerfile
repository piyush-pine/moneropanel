FROM php:8.2-apache

# Install SQLite3 system package first
RUN apt-get update && apt-get install -y \
    sqlite3 \
    libsqlite3-dev \
    && rm -rf /var/lib/apt/lists/*

# Install PHP SQLite extensions
RUN docker-php-ext-install pdo pdo_sqlite

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Copy all panel files to Apache web directory
COPY . /var/www/html/

# Set proper permissions
RUN chown -R www-data:www-data /var/www/html/
RUN chmod -R 755 /var/www/html/

# Use port 10000 for Render compatibility
EXPOSE 10000

# Start Apache
CMD ["apache2-foreground"]
