import 'package:cinema_app/core/config/app_config.dart';
import 'package:cinema_app/core/localization/app_tr.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FoodPage extends StatefulWidget {
  const FoodPage({super.key});

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  @override
  Widget build(BuildContext context) {
    Future<void> sendSuccessRequest() async {
      await http.get(
        Uri.parse('${AppConfig.translationsBaseUrl}/en.json'),
      );
    }

    Future<void> sendErrorRequest() async {
      try {
        await http.get(
          Uri.parse('https://jsonplaceholder.typicode.com/invalid-url-path'),
        );
      } catch (e) {
        debugPrint('Caught expected error');
      }
    }

    const name = 'Zoey';
    return Scaffold(
      appBar: AppBar(title: Text('app_title'.tr())),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppTr.tr('loginPage.login'),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Text(
            AppTr.tr('loginPage.password'),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Text(
            AppTr.tr('loginPage.loginError'),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Text(
            AppTr.tr('loginPage.welcome', args: [name]),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: sendSuccessRequest,
            icon: const Icon(Icons.check_circle),
            label: const Text('Fire Successful Request (200)'),
          ),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            onPressed: sendErrorRequest,
            icon: const Icon(Icons.error),
            label: const Text('Fire Error Request (404)'),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red[100]),
          ),
          ElevatedButton(
            onPressed: () {
              context.setLocale(const Locale('en'));
            },
            child: const Text('English'),
          ),
          ElevatedButton(
            onPressed: () {
              context.setLocale(const Locale('my'));
            },
            child: const Text('Myanmar'),
          ),
        ],
      ),
    );
  }
}
