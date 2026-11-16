import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:agrivision_cnn_707012400012/main.dart';
import 'package:agrivision_cnn_707012400012/state/deteksi_model.dart';

void main() {
  testWidgets('App renders Beranda screen', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => DeteksiModel(),
        child: const AgriVisionApp(),
      ),
    );

    expect(find.text('Selamat Datang di AgriVision CNN'), findsOneWidget);
  });
}
