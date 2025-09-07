# Dockerfile para Flutter Web en Cloud Run
FROM node:18-alpine as build-stage

# Instalar dependencias necesarias
RUN apk add --no-cache bash git

# Instalar Flutter (versión específica para evitar problemas)
RUN git clone https://github.com/flutter/flutter.git -b stable --depth 1 /usr/local/flutter
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Verificar instalación
RUN flutter --version
RUN flutter doctor

# Crear directorio de trabajo
WORKDIR /app

# Copiar archivos del proyecto
COPY . .

# Obtener dependencias y compilar para web
RUN flutter pub get
RUN flutter build web --release --no-tree-shake-icons --web-renderer html

# Fase de producción
FROM nginx:alpine as production-stage

# Copiar los archivos compilados de Flutter
COPY --from=build-stage /app/build/web /usr/share/nginx/html

# Configurar Nginx para SPA (Single Page Application)
COPY nginx.conf /etc/nginx/nginx.conf

# Exponer puerto
EXPOSE 8080

# Iniciar Nginx
CMD ["nginx", "-g", "daemon off;"]