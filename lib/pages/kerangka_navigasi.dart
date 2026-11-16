import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/deteksi_model.dart';
import 'halaman_beranda.dart';
import 'halaman_deteksi.dart';
import 'halaman_pengaturan.dart';
import 'halaman_statistik.dart';

class KerangkaNavigasi extends StatefulWidget {
  const KerangkaNavigasi({super.key});

  @override
  State<KerangkaNavigasi> createState() => _KerangkaNavigasiState();
}

class _KerangkaNavigasiState extends State<KerangkaNavigasi> {
  int _selectedIndex = 0;

  static const List<String> _namaTab = [
    'Beranda',
    'Deteksi',
    'Statistik',
    'Pengaturan',
  ];

  final List<Widget> _halaman = const [
    HalamanBeranda(),
    HalamanDeteksi(),
    HalamanStatistik(),
    HalamanPengaturan(),
  ];

  @override
  Widget build(BuildContext context) {
    final jumlahTindakan =
        context.watch<DeteksiModel>().totalPerluTindakanGlobal;

    return Scaffold(
      appBar: AppBar(
        title: Text('AgriVision - ${_namaTab[_selectedIndex]}'),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _halaman,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Beranda',
          ),
          NavigationDestination(
            icon: Badge(
              isLabelVisible: jumlahTindakan > 0,
              label: Text('$jumlahTindakan'),
              child: const Icon(Icons.search),
            ),
            selectedIcon: Badge(
              isLabelVisible: jumlahTindakan > 0,
              label: Text('$jumlahTindakan'),
              child: const Icon(Icons.manage_search),
            ),
            label: 'Deteksi',
          ),
          const NavigationDestination(
            icon: Icon(Icons.bar_chart_outlined),
            selectedIcon: Icon(Icons.bar_chart),
            label: 'Statistik',
          ),
          const NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Pengaturan',
          ),
        ],
      ),
    );
  }
}
