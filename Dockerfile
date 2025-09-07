# Dockerfile usando imagen oficial de Flutter
FROM flutter:stable as build-stage

# Habilitar web
RUN flutter config --enable-web

WORKDIR /app

# Copiar pubspec primero para cachear dependencias
COPY pubspec.yaml ./
RUN flutter pub get

# Copiar el resto del código
COPY . .

# Compilar para web
RUN flutter build web --release --no-tree-shake-icons --web-renderer html

# Fase de producción
FROM nginx:alpine

# Copiar build de Flutter
COPY --from=build-stage /app/build/web /usr/share/nginx/html

# Configuración de Nginx
COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]