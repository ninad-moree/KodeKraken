import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/theme_map.dart';
import 'package:flutter_highlight/themes/github.dart';
import 'package:intl/intl.dart';

class VersionDisplay extends StatelessWidget {
  final Map version;
  final String language;
  const VersionDisplay(this.version, this.language, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        String code = version['code'];
        Clipboard.setData(ClipboardData(text: code)).then(
          (value) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  "Copied to clipboard",
                ),
              ),
            );
          },
        );
      },
      child: Container(
        height: 600,
        width: double.maxFinite,
        margin: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color.fromARGB(255, 30, 30, 30),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Version: ${DateFormat('EEE dd-MM-yyyy - HH:mm').format(version['date'].toDate())}",
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.blue,
                      ),
                    ),
                    const Icon(
                      Icons.copy,
                      color: Colors.blue,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: HighlightView(
                  version['code'],
                  language: language == "cpp17" ? 'cpp' : 'python',
                  theme: themeMap['vs2015'] ?? githubTheme,
                  padding: const EdgeInsets.all(12),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
