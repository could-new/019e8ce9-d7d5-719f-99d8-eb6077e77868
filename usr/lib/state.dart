import 'package:flutter/material.dart';

class Memory {
  final String id;
  final String title;
  final DateTime date;
  final String description;
  final String? feeling;
  final String? photoUrl;

  Memory({
    required this.id,
    required this.title,
    required this.date,
    required this.description,
    this.feeling,
    this.photoUrl,
  });
}

class JournalEntry {
  final String id;
  final DateTime date;
  final String text;
  final String? photoUrl;

  JournalEntry({
    required this.id,
    required this.date,
    required this.text,
    this.photoUrl,
  });
}

class Song {
  final String id;
  final String title;
  final String? artist;
  final String? note;
  final bool isOurSong;

  Song({
    required this.id,
    required this.title,
    this.artist,
    this.note,
    this.isOurSong = false,
  });
}

class OpenWhenTemplate {
  final String id;
  final String title;
  String content;

  OpenWhenTemplate({
    required this.id,
    required this.title,
    this.content = '',
  });
}

class UniverseProvider extends ChangeNotifier {
  DateTime relationshipStartDate = DateTime.now().subtract(const Duration(days: 365));

  final List<String> dailyMessages = [
    "I'm glad you're still here with me.",
    "Every day is better because you are in it.",
    "You are my favorite notification.",
    "I love the way you see the world.",
    "Thank you for being my safe place.",
  ];

  String get todayMessage => dailyMessages[DateTime.now().day % dailyMessages.length];

  List<Memory> memories = [
    Memory(
      id: '1',
      title: 'First Date',
      date: DateTime.now().subtract(const Duration(days: 365)),
      description: 'We met at the little cafe. I was so nervous but you made me laugh instantly.',
      feeling: 'Nervous & Happy',
    ),
    Memory(
      id: '2',
      title: 'First Trip',
      date: DateTime.now().subtract(const Duration(days: 200)),
      description: 'The beach was freezing but walking with you was perfect.',
      feeling: 'Peaceful',
    ),
  ];

  List<JournalEntry> journalEntries = [
    JournalEntry(
      id: '1',
      date: DateTime.now().subtract(const Duration(days: 2)),
      text: 'Thinking about how lucky I am today. Just a normal Tuesday, but I caught myself smiling.',
    )
  ];

  List<Song> playlist = [
    Song(id: '1', title: 'Perfect', artist: 'Ed Sheeran', isOurSong: true, note: 'Reminds me of our first dance.'),
    Song(id: '2', title: 'Yellow', artist: 'Coldplay', note: 'You sang this in the car.'),
  ];

  List<OpenWhenTemplate> openWhenMessages = [
    OpenWhenTemplate(id: '1', title: 'Open when you miss me'),
    OpenWhenTemplate(id: '2', title: 'Open when you feel sad'),
    OpenWhenTemplate(id: '3', title: 'Open when you can\\'t sleep'),
    OpenWhenTemplate(id: '4', title: 'Open when you need motivation'),
    OpenWhenTemplate(id: '5', title: 'Open when you want to smile'),
  ];

  int _moonTaps = 0;
  bool unlockedSecretMessage = false;

  void tapMoon() {
    _moonTaps++;
    if (_moonTaps >= 7 && !unlockedSecretMessage) {
      unlockedSecretMessage = true;
      notifyListeners();
    }
  }

  void addMemory(Memory memory) {
    memories.add(memory);
    memories.sort((a, b) => b.date.compareTo(a.date));
    notifyListeners();
  }

  void addJournalEntry(JournalEntry entry) {
    journalEntries.add(entry);
    journalEntries.sort((a, b) => b.date.compareTo(a.date));
    notifyListeners();
  }
}
