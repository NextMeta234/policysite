import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const NextMetaPolicyApp());
}

class NextMetaPolicyApp extends StatelessWidget {
  const NextMetaPolicyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NextMeta ポリシー',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const PolicyHomePage(),
    );
  }
}

class PolicyHomePage extends StatefulWidget {
  const PolicyHomePage({Key? key}) : super(key: key);

  @override
  State<PolicyHomePage> createState() => _PolicyHomePageState();
}

class _PolicyHomePageState extends State<PolicyHomePage> {
  int _selectedIndex = 0;

  final List<PolicyPage> pages = [
    PolicyPage(
      title: 'ポリシー概要',
      icon: Icons.article,
      url: 'https://your-domain.com/pages/overview.html',
    ),
    PolicyPage(
      title: 'プライバシーポリシー',
      icon: Icons.security,
      url: 'https://your-domain.com/pages/privacy.html',
    ),
    PolicyPage(
      title: '利用規約',
      icon: Icons.description,
      url: 'https://your-domain.com/pages/terms.html',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NextMeta ポリシー'),
        centerTitle: true,
        elevation: 0,
      ),
      body: _selectedIndex == 3
          ? const SettingsPage()
          : PolicyWebView(url: pages[_selectedIndex].url),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.article),
            label: '概要',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.security),
            label: 'プライバシー',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.description),
            label: '利用規約',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: '設定',
          ),
        ],
      ),
    );
  }
}

class PolicyPage {
  final String title;
  final IconData icon;
  final String url;

  PolicyPage({
    required this.title,
    required this.icon,
    required this.url,
  });
}

class PolicyWebView extends StatefulWidget {
  final String url;

  const PolicyWebView({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  State<PolicyWebView> createState() => _PolicyWebViewState();
}

class _PolicyWebViewState extends State<PolicyWebView> {
  late WebViewController _controller;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeWebView();
  }

  void _initializeWebView() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() {
              isLoading = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              isLoading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('エラー: ${error.description}')),
            );
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  void didUpdateWidget(PolicyWebView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.url != widget.url) {
      _controller.loadRequest(Uri.parse(widget.url));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebViewWidget(controller: _controller),
        if (isLoading)
          const Center(
            child: CircularProgressIndicator(),
          ),
      ],
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '設定',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            const SettingsSectionTitle('表示'),
            SwitchListTile(
              title: const Text('ダークモード'),
              subtitle: const Text('アプリをダークモードで表示します'),
              value: false,
              onChanged: (value) {
                // ダークモード切り替え機能
              },
            ),
            const Divider(),
            const SettingsSectionTitle('情報'),
            ListTile(
              title: const Text('バージョン'),
              subtitle: const Text('1.0.0'),
              trailing: const Icon(Icons.info_outline),
            ),
            ListTile(
              title: const Text('サポート'),
              subtitle: const Text('support@example.com'),
              trailing: const Icon(Icons.mail_outline),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('サポートメールアドレスをコピーしました')),
                );
              },
            ),
            const Divider(),
            const SettingsSectionTitle('その他'),
            ListTile(
              title: const Text('利用規約'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // 利用規約に遷移
              },
            ),
            ListTile(
              title: const Text('プライバシーポリシー'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // プライバシーポリシーに遷移
              },
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('キャッシュをクリアしました')),
                  );
                },
                icon: const Icon(Icons.delete_outline),
                label: const Text('キャッシュをクリア'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  showAboutDialog(
                    context: context,
                    applicationName: 'NextMeta ポリシー',
                    applicationVersion: '1.0.0',
                    applicationLegalese: '© 2024 NextMeta. All rights reserved.',
                  );
                },
                icon: const Icon(Icons.info_outline),
                label: const Text('アプリについて'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsSectionTitle extends StatelessWidget {
  final String title;

  const SettingsSectionTitle(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.grey[600],
        ),
      ),
    );
  }
}