import 'package:flutter/foundation.dart';
import '../models/hasil_deteksi.dart';

class DeteksiModel extends ChangeNotifier {
  final List<HasilDeteksi> _daftarDeteksi = [];
  String _filterPetak = 'Semua';
  bool _isDarkMode = false;

  List<HasilDeteksi> get daftarDeteksi => List.unmodifiable(_daftarDeteksi);
  String get filterPetak => _filterPetak;
  bool get isDarkMode => _isDarkMode;

  List<HasilDeteksi> get daftarTerfilter {
    if (_filterPetak == 'Semua') {
      return _daftarDeteksi;
    }
    return _daftarDeteksi.where((item) => item.petak == _filterPetak).toList();
  }

  int get totalDeteksi => daftarTerfilter.length;

  int get jumlahSehat =>
      daftarTerfilter.where((item) => item.status == 'Sehat').length;

  int get jumlahPerluTindakan =>
      daftarTerfilter.where((item) => item.status == 'Perlu Tindakan').length;

  int get totalPerluTindakanGlobal =>
      _daftarDeteksi.where((item) => item.status == 'Perlu Tindakan').length;

  Map<String, int> get jumlahPerKelas {
    final Map<String, int> counts = {
      for (final kelas in HasilDeteksi.daftarKelas) kelas: 0,
    };
    for (final item in _daftarDeteksi) {
      counts[item.kelas] = (counts[item.kelas] ?? 0) + 1;
    }
    return counts;
  }

  void tambahData(HasilDeteksi data) {
    _daftarDeteksi.insert(0, data);
    notifyListeners();
  }

  void hapusData(String id) {
    _daftarDeteksi.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  void ubahFilterPetak(String petak) {
    _filterPetak = petak;
    notifyListeners();
  }

  void muatDataSimulasi() {
    final simulasi = HasilDeteksi.buatDataSimulasi();
    _daftarDeteksi.insertAll(0, simulasi);
    notifyListeners();
  }

  void hapusSemuaData() {
    _daftarDeteksi.clear();
    notifyListeners();
  }

  void toggleModeGelap(bool value) {
    _isDarkMode = value;
    notifyListeners();
  }
}
