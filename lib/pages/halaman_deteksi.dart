import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_routes.dart';
import '../state/deteksi_model.dart';
import '../widgets/deteksi_card.dart';
import '../widgets/stat_card.dart';

class HalamanDeteksi extends StatelessWidget {
  const HalamanDeteksi({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final model = context.watch<DeteksiModel>();
    final listData = model.daftarTerfilter;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Riwayat Deteksi',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
            ),
            const SizedBox(height: 12),
            SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: 'Semua', label: Text('Semua')),
                ButtonSegment(value: 'Petak 1', label: Text('Petak 1')),
                ButtonSegment(value: 'Petak 2', label: Text('Petak 2')),
              ],
              selected: {model.filterPetak},
              onSelectionChanged: (selection) {
                context.read<DeteksiModel>().ubahFilterPetak(selection.first);
              },
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                StatCard(label: 'Total', value: model.totalDeteksi),
                const SizedBox(width: 8),
                StatCard(
                  label: 'Sehat',
                  value: model.jumlahSehat,
                  valueColor: Colors.green.shade700,
                ),
                const SizedBox(width: 8),
                StatCard(
                  label: 'Perlu Tindakan',
                  value: model.jumlahPerluTindakan,
                  valueColor: colorScheme.error,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: listData.isEmpty
                  ? Center(
                      child: Text(
                        'Belum ada data',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.only(bottom: 84),
                      itemCount: listData.length,
                      itemBuilder: (context, index) {
                        final item = listData[index];
                        return DeteksiCard(
                          data: item,
                          onDelete: () {
                            context.read<DeteksiModel>().hapusData(item.id);
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.inputDeteksi);
        },
        icon: const Icon(Icons.add),
        label: const Text('Deteksi Baru'),
      ),
    );
  }
}
