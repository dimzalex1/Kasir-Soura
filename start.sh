#!/usr/bin/env sh
set -e

echo "Starting Laravel deployment script..."

php artisan package:discover --ansi || true

php artisan config:clear
php artisan route:clear
php artisan view:clear
php artisan cache:clear || true

php artisan storage:link || true

echo "Running database migrations..."
php artisan migrate --force

if [ "$RUN_SEED" = "true" ]; then
    echo "Running database seeders..."
    php artisan db:seed --force
fi

php artisan optimize || true

echo "Starting Laravel server..."
php artisan serve --host=0.0.0.0 --port=${PORT:-10000}
