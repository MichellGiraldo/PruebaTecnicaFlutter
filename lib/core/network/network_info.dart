abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  @override
  Future<bool> get isConnected async {
    // En una implementación real, aquí verificarías la conectividad
    // Por simplicidad, asumimos que siempre hay conexión
    return true;
  }
}
