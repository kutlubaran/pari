import 'package:flutter/material.dart';

class announcementCard extends StatefulWidget {
  const announcementCard({super.key});

  @override
  State<announcementCard> createState() => _announcementCardState();
}

class _announcementCardState extends State<announcementCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: Icon(
              Icons.wordpress,
              size: 32,
              color: Colors.grey,
            ),
          ),
          Text(
            '19.10.2022 - 14:42:00',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: Text(
              'Aptos (APT) Paribuda',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: Text(
              'APT alış satış işlemleri 1* ekim 2022 14:30 itibarıyla başladı. APT hakkında detaylı bilgi icin tıklayın.',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          Icon(
            Icons.arrow_right_alt,
            color: Colors.green,
          )
        ],
      ),
    );
  }
}
