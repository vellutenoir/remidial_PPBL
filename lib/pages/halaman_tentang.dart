import 'package:flutter/material.dart';
import '../models/hasil_deteksi.dart';

class HalamanTentang extends StatelessWidget {
  const HalamanTentang({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tentang Aplikasi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 1,
              color: colorScheme.surfaceContainerLow,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tujuan Aplikasi',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onSurface,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'AgriVision CNN adalah aplikasi mobile pencatatan hasil deteksi penyakit dan hama tanaman padi berbasis arsitektur EfficientNet-B0 untuk membantu kelompok tani memantau riwayat kesehatan Petak 1 dan Petak 2 secara terstruktur.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Daftar 5 Kelas Deteksi',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.separated(
                itemCount: HasilDeteksi.daftarKelas.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final namaKelas = HasilDeteksi.daftarKelas[index];
                  final rekomendasi =
                      HasilDeteksi.rekomendasiPerKelas[namaKelas] ?? '';
                  final isNormal = namaKelas == HasilDeteksi.kelasNormal;

                  return Card(
                    elevation: 0,
                    color: colorScheme.surfaceContainerLow,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: colorScheme.outlineVariant),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: isNormal
                            ? Colors.green.withValues(alpha: 0.15)
                            : colorScheme.primaryContainer,
                        child: Icon(
                          isNormal ? Icons.eco : Icons.bug_report_outlined,
                          color: isNormal
                              ? Colors.green.shade700
                              : colorScheme.onPrimaryContainer,
                        ),
                      ),
                      title: Text(
                        namaKelas,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(rekomendasi),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
