#!/bin/bash

echo "🚀 Configurando Flutter Shopping Cart App..."

# Verificar Flutter
echo "📱 Verificando Flutter..."
flutter --version

# Instalar dependencias
echo "📦 Instalando dependencias..."
flutter pub get

# Verificar configuración
echo "🔍 Verificando configuración..."
flutter doctor

# Crear APK para Android
echo "🤖 Compilando APK..."
flutter build apk --debug

# Compilar para web
echo "🌐 Compilando para web..."
flutter build web

echo "✅ ¡Configuración completada!"
echo "📱 Para ejecutar en Android: flutter run"
echo "🌐 Para ejecutar en web: flutter run -d web-server"
echo "📱 Para ejecutar en Chrome: flutter run -d chrome"
