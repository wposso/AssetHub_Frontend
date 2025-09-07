# Etapa 1: Construcción
FROM cirrusci/flutter:stable AS build

# Establecer directorio de trabajo
WORKDIR /app

# Copiar pubspec y pubspec.lock para aprovechar la cache de dependencias
COPY pubspec.* ./

# Descargar dependencias
RUN flutter pub get

# Copiar el resto del código
COPY . .

# Compilar la app web en modo release
RUN flutter build web --release --no-tree-shake-icons

# Etapa 2: Servidor web con Nginx
FROM nginx:stable-alpine

# Eliminar configuración por defecto
RUN rm -rf /usr/share/nginx/html/*

# Copiar los archivos compilados de Flutter al contenedor final
COPY --from=build /app/build/web /usr/share/nginx/html

# Exponer puerto
EXPOSE 8080

# Ejecutar Nginx en primer plano
CMD ["nginx", "-g", "daemon off;"]
