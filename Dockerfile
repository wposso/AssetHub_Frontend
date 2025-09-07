FROM cirrusci/flutter:stable as build

# Definir el directorio de trabajo
WORKDIR /app

# Copiar pubspec y resolver dependencias
COPY pubspec.* ./
RUN flutter pub get

# Copiar el resto del proyecto
COPY . .

# Construir para web (solo necesitas web en Cloud Run)
RUN flutter build web --release --web-renderer html --no-tree-shake-icons

# Imagen final con un servidor web ligero
FROM nginx:alpine

# Copiar el build generado al directorio de Nginx
COPY --from=build /app/build/web /usr/share/nginx/html

# Exponer puerto 8080 (Cloud Run usa 8080 por defecto)
EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]
