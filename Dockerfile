# Imagen base de Flutter estable
FROM cirrusci/flutter:stable AS build

# Establecer directorio de trabajo
WORKDIR /app

# Copiar solo pubspec primero para aprovechar la cache de dependencias
COPY pubspec.yaml pubspec.lock ./

# Descargar dependencias
RUN flutter pub get

# Copiar el resto del proyecto
COPY . .

# Construir la aplicación web en modo release
RUN flutter build web --release --no-tree-shake-icons

# ---- Etapa de servidor web ----
FROM nginx:alpine

# Eliminar configuración por defecto de Nginx
RUN rm -rf /usr/share/nginx/html/*

# Copiar la build de Flutter al contenedor de Nginx
COPY --from=build /app/build/web /usr/share/nginx/html

# Exponer puerto 8080 (Cloud Run usa 8080 por defecto)
EXPOSE 8080

# Reemplazar configuración de Nginx para usar el puerto 8080
RUN sed -i 's/listen       80;/listen       8080;/g' /etc/nginx/conf.d/default.conf

# Comando de arranque
CMD ["nginx", "-g", "daemon off;"]
