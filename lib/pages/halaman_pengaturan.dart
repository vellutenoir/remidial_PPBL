import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/deteksi_model.dart';

class HalamanPengaturan extends StatelessWidget {
  const HalamanPengaturan({super.key});

  Future<void> _konfirmasiHapusSemua(BuildContext context) async {
    final konfirmasi = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Hapus Semua Data?'),
        content: const Text('Semua riwayat deteksi akan dihapus.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(
              'Hapus',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
        ],
      ),
    );

    if (konfirmasi == true && context.mounted) {
      context.read<DeteksiModel>().hapusSemuaData();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Semua data berhasil dihapus')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<DeteksiModel>();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SwitchListTile(
            title: const Text('Mode Gelap'),
            value: model.isDarkMode,
            contentPadding: EdgeInsets.zero,
            onChanged: (value) {
              context.read<DeteksiModel>().toggleModeGelap(value);
            },
          ),
          const SizedBox(height: 16),
          OutlinedButton(
            onPressed: () {
              context.read<DeteksiModel>().muatDataSimulasi();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('10 data simulasi berhasil dimuat'),
                ),
              );
            },
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            child: const Text('Muat Data Simulasi'),
          ),
          const SizedBox(height: 12),
          OutlinedButton(
            onPressed: model.daftarDeteksi.isEmpty
                ? null
                : () => _konfirmasiHapusSemua(context),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            child: const Text('Hapus Semua Data'),
          ),
        ],
      ),
    );
  }
}
