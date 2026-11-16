import 'package:flutter/material.dart';
import '../models/hasil_deteksi.dart';

class DeteksiCard extends StatelessWidget {
  final HasilDeteksi data;
  final VoidCallback onDelete;

  const DeteksiCard({
    super.key,
    required this.data,
    required this.onDelete,
  });

  (Color, IconData) _statusStyle(BuildContext context, String status) {
    final colorScheme = Theme.of(context).colorScheme;
    switch (status) {
      case 'Sehat':
        return (Colors.green.shade700, Icons.check_circle_outline);
      case 'Tidak Pasti':
        return (Colors.amber.shade800, Icons.help_outline);
      case 'Perlu Tindakan':
      default:
        return (colorScheme.error, Icons.warning_amber_rounded);
    }
  }

  String _formatWaktu(DateTime dt) {
    final dd = dt.day.toString().padLeft(2, '0');
    final mm = dt.month.toString().padLeft(2, '0');
    final yyyy = dt.year.toString();
    final hh = dt.hour.toString().padLeft(2, '0');
    final min = dt.minute.toString().padLeft(2, '0');
    return '$dd/$mm/$yyyy $hh:$min';
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final (statusColor, statusIcon) = _statusStyle(context, data.status);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 1,
      color: colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(statusIcon, color: statusColor, size: 22),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '${data.petak} - ${data.kelas}',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                  ),
                ),
                IconButton(
                  onPressed: onDelete,
                  icon: Icon(
                    Icons.delete_outline,
                    color: colorScheme.onSurfaceVariant,
                  ),
                  tooltip: 'Hapus data',
                  visualDensity: VisualDensity.compact,
                ),
              ],
            ),
            const SizedBox(height: 2),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                data.status,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: statusColor,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Skor: ${data.skor}%',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const SizedBox(height: 6),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: data.skor / 100.0,
                minHeight: 6,
                backgroundColor: colorScheme.surfaceContainerHighest,
                valueColor: AlwaysStoppedAnimation<Color>(statusColor),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              data.rekomendasi,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurface,
                  ),
            ),
            const SizedBox(height: 6),
            Text(
              '${data.namaPetugas} • ${_formatWaktu(data.waktu)}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
