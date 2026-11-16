import 'dart:math';

class HasilDeteksi {
  final String id;
  final String petak;
  final String kelas;
  final int skor;
  final String namaPetugas;
  final DateTime waktu;

  HasilDeteksi({
    required this.id,
    required this.petak,
    required this.kelas,
    required this.skor,
    required this.namaPetugas,
    required this.waktu,
  });

  static const String kelasNormal = 'Normal / Sehat';

  static const List<String> daftarKelas = [
    'Hawar daun bakteri',
    'Penyakit blas (jamur)',
    'Bercak coklat',
    'Normal / Sehat',
    'Penyakit tungro (virus)',
  ];

  static const List<String> daftarPetak = [
    'Petak 1',
    'Petak 2',
  ];

  // Tabel B. Rekomendasi Penanganan per Kelas
  static const Map<String, String> rekomendasiPerKelas = {
    'Hawar daun bakteri':
        'Kurangi pupuk urea, buang air berlebih, bersihkan jerami yang sakit.',
    'Penyakit blas (jamur)':
        'Jaga sawah tetap tergenang, semprot obat jamur saat padi keluar malai.',
    'Bercak coklat':
        'Tambah pupuk kalium, jaga sawah tetap tergenang.',
    'Normal / Sehat':
        'Tanaman sehat. Lanjutkan pemantauan rutin.',
    'Penyakit tungro (virus)':
        'Cabut rumpun yang sakit, musim depan pakai varietas tahan.',
  };

  // Tabel A. Ketentuan Status Deteksi
  String get status {
    if (kelas == kelasNormal) {
      return 'Sehat';
    } else if (skor < 50) {
      return 'Tidak Pasti';
    } else {
      return 'Perlu Tindakan';
    }
  }

  String get rekomendasi {
    if (kelas == kelasNormal) {
      return 'Lanjutkan pemantauan rutin';
    } else if (skor < 50) {
      return 'Cek ulang oleh petugas';
    } else {
      final penanganan =
          rekomendasiPerKelas[kelas] ?? 'Lakukan pemeriksaan lanjut.';
      return 'Segera tangani: $penanganan';
    }
  }

  static List<HasilDeteksi> buatDataSimulasi() {
    final random = Random();
    const daftarPetugas = ['Budi', 'Siti', 'Agus', 'Vayola', 'Rendra'];
    final now = DateTime.now();

    return List.generate(10, (index) {
      return HasilDeteksi(
        id: '${now.microsecondsSinceEpoch}_$index',
        petak: daftarPetak[random.nextInt(daftarPetak.length)],
        kelas: daftarKelas[random.nextInt(daftarKelas.length)],
        skor: 30 + random.nextInt(70), // 30 - 99
        namaPetugas: daftarPetugas[random.nextInt(daftarPetugas.length)],
        waktu: now.subtract(
          Duration(
            hours: index * 3 + random.nextInt(3),
            minutes: random.nextInt(60),
          ),
        ),
      );
    });
  }
}
