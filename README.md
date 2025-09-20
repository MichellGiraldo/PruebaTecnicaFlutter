# Shopping Cart App

Una aplicación de carrito de compras desarrollada con Flutter, BLoC y Clean Architecture.

## Características

### Funcionalidades Principales
- **Catálogo de Productos**: Lista productos desde la API de FakeStore
- **Carrito de Compras**: Agregar, modificar y eliminar productos
- **Sincronización en Tiempo Real**: Cambios reflejados inmediatamente entre pantallas
- **Persistencia Local**: El carrito se mantiene al cerrar/reabrir la app
- **Checkout Completo**: Formulario de pago con validación
- **Diseño Adaptable**: Optimizado para móvil y tablet

### Arquitectura
- **Clean Architecture**: Separación clara de capas (presentación, dominio, datos)
- **BLoC Pattern**: Gestión de estado reactiva y predecible
- **Dependency Injection**: Uso de GetIt para inyección de dependencias
- **Repository Pattern**: Abstracción de fuentes de datos

## Estructura del Proyecto

```
lib/
├── core/
│   ├── constants/          # Constantes de la aplicación
│   ├── errors/            # Definición de errores
│   ├── network/           # Configuración de red
│   ├── utils/             # Utilidades (inyección de dependencias)
│   └── widgets/           # Widgets reutilizables
├── features/
│   ├── products/          # Feature de productos
│   │   ├── data/          # Datasources, modelos, repositorios
│   │   ├── domain/        # Entidades, repositorios, casos de uso
│   │   └── presentation/  # BLoCs, páginas, widgets
│   └── cart/              # Feature del carrito
│       ├── data/          # Datasources, modelos, repositorios
│       ├── domain/        # Entidades, repositorios, casos de uso
│       └── presentation/  # BLoCs, páginas, widgets
├── app.dart               # Configuración principal de la app
└── main.dart              # Punto de entrada
```

## Requisitos

- Flutter SDK 3.0.0 o superior
- Dart 3.0.0 o superior

## Instalación

### Opción 1: GitHub Codespaces (Recomendado para emulación)
1. Ve a [https://github.com/MichellGiraldo/PruebaTecnicaFlutter](https://github.com/MichellGiraldo/PruebaTecnicaFlutter)
2. Haz clic en el botón verde "Code"
3. Selecciona "Codespaces"
4. Crea un nuevo Codespace
5. Una vez abierto, ejecuta:
```bash
flutter pub get
flutter run -d web-server
```

### Opción 2: Instalación Local
1. Clona el repositorio:
```bash
git clone https://github.com/MichellGiraldo/PruebaTecnicaFlutter.git
cd PruebaTecnicaFlutter
```

2. Instala las dependencias:
```bash
flutter pub get
```

3. Ejecuta la aplicación:
```bash
# Para Android
flutter run

# Para Web
flutter run -d web-server

# Para Chrome
flutter run -d chrome
```

## Uso

### Pantalla Principal (Home)
- Visualiza el catálogo de productos en una cuadrícula adaptable
- Los productos muestran imagen, título, precio y botón de agregar
- El botón cambia de color y texto cuando el producto está en el carrito
- Pull-to-refresh para actualizar la lista

### Header Global
- Muestra el ícono del carrito con contador de items
- Al tocar navega a la pantalla del carrito
- El contador se actualiza en tiempo real

### Pantalla del Carrito
- Lista todos los productos agregados
- Permite aumentar/disminuir cantidades
- Muestra precio unitario y subtotal por producto
- Botón para eliminar productos individuales
- Botón para limpiar todo el carrito
- Total general y botón para proceder al checkout

### Pantalla de Checkout
- Resumen completo del pedido
- Formulario de información de envío
- Formulario de información de pago
- Validación de campos
- Simulación de procesamiento de pago
- Confirmación de compra exitosa

## Características Técnicas

### Gestión de Estado
- **ProductsBloc**: Maneja el estado de la lista de productos
- **CartBloc**: Maneja el estado del carrito de compras
- Estados reactivos que se actualizan automáticamente en la UI

### Persistencia
- **SharedPreferences**: Almacenamiento local del carrito
- **JSON Serialization**: Serialización de objetos CartItem
- Persistencia automática en cada cambio del carrito

### API Integration
- **HTTP Client**: Consumo de la API de FakeStore
- **Error Handling**: Manejo robusto de errores de red
- **Loading States**: Estados de carga y error en la UI

### Diseño Responsivo
- **Grid Adaptativo**: Número de columnas según el tamaño de pantalla
- **Orientación**: Soporte para modo portrait y landscape
- **Breakpoints**: Móvil (< 800px), Tablet (800-1200px), Desktop (> 1200px)

## Dependencias Principales

- `flutter_bloc`: Gestión de estado
- `http`: Cliente HTTP para API
- `shared_preferences`: Persistencia local
- `get_it`: Inyección de dependencias
- `equatable`: Comparación de objetos

## Patrones de Diseño

- **Clean Architecture**: Separación de responsabilidades
- **Repository Pattern**: Abstracción de datos
- **BLoC Pattern**: Gestión de estado
- **Dependency Injection**: Inversión de dependencias
- **Observer Pattern**: Reactividad en la UI


