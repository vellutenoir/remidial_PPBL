import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../models/hasil_deteksi.dart';
import '../state/deteksi_model.dart';

class HalamanInputDeteksi extends StatefulWidget {
  const HalamanInputDeteksi({super.key});

  @override
  State<HalamanInputDeteksi> createState() => _HalamanInputDeteksiState();
}

class _HalamanInputDeteksiState extends State<HalamanInputDeteksi> {
  final TextEditingController _skorController = TextEditingController();
  final TextEditingController _petugasController = TextEditingController();

  String _selectedPetak = HasilDeteksi.daftarPetak.first;
  String _selectedKelas = HasilDeteksi.daftarKelas.first;
  bool _dataSudahBenar = false;

  String? _errorSkor;
  String? _errorPetugas;

  @override
  void dispose() {
    _skorController.dispose();
    _petugasController.dispose();
    super.dispose();
  }

  bool _validasiForm() {
    final skorText = _skorController.text.trim();
    final petugasText = _petugasController.text.trim();

    String? errSkor;
    String? errPetugas;

    final skorAngka = int.tryParse(skorText);
    if (skorAngka == null || skorAngka < 0 || skorAngka > 100) {
      errSkor = 'Skor harus berupa angka 0-100';
    }

    if (petugasText.isEmpty) {
      errPetugas = 'Nama petugas tidak boleh kosong';
    }

    setState(() {
      _errorSkor = errSkor;
      _errorPetugas = errPetugas;
    });

    return errSkor == null && errPetugas == null;
  }

  Future<void> _konfirmasiDanSimpan() async {
    if (!_validasiForm()) return;

    final skor = int.parse(_skorController.text.trim());
    final namaPetugas = _petugasController.text.trim();

    final konfirmasi = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Simpan Hasil Deteksi?'),
        content: Text(
          'Petak: $_selectedPetak\n'
          'Kelas: $_selectedKelas\n'
          'Skor: $skor%\n'
          'Petugas: $namaPetugas',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Simpan'),
          ),
        ],
      ),
    );

    if (konfirmasi == true && mounted) {
      final hasilBaru = HasilDeteksi(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        petak: _selectedPetak,
        kelas: _selectedKelas,
        skor: skor,
        namaPetugas: namaPetugas,
        waktu: DateTime.now(),
      );

      context.read<DeteksiModel>().tambahData(hasilBaru);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data tersimpan')),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Deteksi'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Petak',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
            ),
            RadioGroup<String>(
              groupValue: _selectedPetak,
              onChanged: (value) {
                if (value != null) {
                  setState(() => _selectedPetak = value);
                }
              },
              child: Column(
                children: HasilDeteksi.daftarPetak
                    .map(
                      (petak) => RadioListTile<String>(
                        title: Text(petak),
                        value: petak,
                        contentPadding: EdgeInsets.zero,
                      ),
                    )
                    .toList(),
              ),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              initialValue: _selectedKelas,
              decoration: const InputDecoration(
                labelText: 'Kelas',
                border: OutlineInputBorder(),
              ),
              items: HasilDeteksi.daftarKelas
                  .map(
                    (kelas) => DropdownMenuItem(
                      value: kelas,
                      child: Text(kelas),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => _selectedKelas = value);
                }
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _skorController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                labelText: 'Skor Deteksi (%)',
                hintText: 'Masukkan angka 0 - 100',
                errorText: _errorSkor,
                border: const OutlineInputBorder(),
              ),
              onChanged: (_) {
                if (_errorSkor != null) _validasiForm();
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _petugasController,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                labelText: 'Nama Petugas',
                hintText: 'Contoh: Budi',
                errorText: _errorPetugas,
                border: const OutlineInputBorder(),
              ),
              onChanged: (_) {
                if (_errorPetugas != null) _validasiForm();
              },
            ),
            const SizedBox(height: 12),
            CheckboxListTile(
              title: const Text('Data sudah benar'),
              value: _dataSudahBenar,
              contentPadding: EdgeInsets.zero,
              onChanged: (checked) {
                setState(() => _dataSudahBenar = checked ?? false);
              },
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: _dataSudahBenar ? _konfirmasiDanSimpan : null,
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
