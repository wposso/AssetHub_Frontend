# Dockerfile para Flutter Web en Cloud Run
FROM ubuntu:22.04 as build-stage

# Instalar dependencias necesarias
RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    xz-utils \
    zip \
    libglu1-mesa \
    && rm -rf /var/lib/apt/lists/*

# Descargar e instalar Flutter
RUN git clone https://github.com/flutter/flutter.git -b stable --depth 1 /usr/local/flutter

# Configurar environment variables
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"
ENV FLUTTER_HOME="/usr/local/flutter"

# Verificar instalación y habilitar web
RUN flutter --version
RUN flutter config --enable-web

# Crear directorio de trabajo
WORKDIR /app

# Copiar pubspec primero para cache de dependencias
COPY pubspec.yaml pubspec.lock ./

# Obtener dependencias
RUN flutter pub get

# Copiar el resto del código
COPY . .

# Compilar para web
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