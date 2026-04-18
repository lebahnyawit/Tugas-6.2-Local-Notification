import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Tanpa final, langsung sebutkan tipe datanya (FlutterLocalNotificationsPlugin)
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Ini BISA pakai const karena teks '@mipmap/ic_launcher' sudah pasti dari awal
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  flutterLocalNotificationsPlugin
      .initialize(settings: initializationSettings)
      .then((_) {
        runApp(const MyApp());
      });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tugas 6.2 Notifikasi',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const NotificationPage(),
    );
  }
}

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  void showNotification() {
    // KITA TIDAK BISA PAKAI CONST DI SINI.
    // Sebagai gantinya, kata 'final' dibuang dan diganti tipe data 'DateTime'
    DateTime now = DateTime.now();

    // Kata 'final' dibuang, cukup 'String' saja
    String jam = now.hour.toString().padLeft(2, '0');
    String menit = now.minute.toString().padLeft(2, '0');
    String detik = now.second.toString().padLeft(2, '0');

    String pesanWaktu = "Anda menekan tombol pada waktu $jam:$menit:$detik";

    // Ini BISA pakai const karena pengaturan channel ini mutlak/tidak berubah
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
          'channel_tugas_6_2',
          'Local Notification Channel',
          channelDescription: 'Channel untuk tugas 6.2 notifikasi',
          importance: Importance.max,
          priority: Priority.high,
        );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );

    flutterLocalNotificationsPlugin
        .show(
          id: 0,
          title: 'Pemberitahuan',
          body: pesanWaktu, // Memasukkan variabel String tadi
          notificationDetails: notificationDetails,
        )
        .then((_) {
          print("Notifikasi sukses ditampilkan!");
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tugas 6.2 Local Notification'),
        backgroundColor: Colors.blueGrey,
      ),
      body: const Center(
        child: Text(
          'Tekan tombol di bawah untuk melihat notifikasi.',
          style: TextStyle(fontSize: 16),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showNotification,
        backgroundColor: Colors.blueGrey,
        child: const Icon(Icons.notifications_active),
      ),
    );
  }
}
