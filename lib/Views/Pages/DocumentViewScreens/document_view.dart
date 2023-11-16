import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DocumentView extends StatefulWidget {
  const DocumentView({super.key});

  @override
  State<DocumentView> createState() => _DocumentViewState();
}

class _DocumentViewState extends State<DocumentView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        initialUrl: 'https://res.cloudinary.com/dtxnczpm1/image/upload/v1/uploads/af18b94f-0cae-4552-88ac-cedaae85b1be_NOTES_yvp4qi',
        javascriptMode: JavascriptMode.unrestricted,
      )
    );
  }
}
