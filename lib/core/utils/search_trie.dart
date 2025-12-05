import '../../models/search_models.dart';

class TrieNode {
  final Map<String, TrieNode> children = {};
  // We use a Set here to prevent duplicate entries of the same item 
  // (e.g., finding "banana" via "ana" and "nana" shouldn't list it twice)
  final Set<String> itemIds = {}; 
  List<SearchableItem> items = [];
  bool isEndOfWord = false;
}

class SearchTrie {
  final TrieNode root = TrieNode();

  void insert(SearchableItem item) {
    // OLD WAY: Just inserted the full word
    // _insertString(item.title.toLowerCase(), item);

    // NEW WAY: Insert every possible starting point (Suffixes)
    _insertSuffixes(item.title.toLowerCase(), item);
    _insertSuffixes(item.subtitle.toLowerCase(), item);
  }

  /// Helper to insert "House", "ouse", "use", "se", "e"
  void _insertSuffixes(String text, SearchableItem item) {
    for (int i = 0; i < text.length; i++) {
      // Substring(i) creates a new string starting from index i
      _insertString(text.substring(i), item);
    }
  }

  void _insertString(String key, SearchableItem item) {
    TrieNode current = root;
    for (int i = 0; i < key.length; i++) {
      final char = key[i];
      // Skip special characters to avoid clutter
      if (!RegExp(r'[a-zA-Zа-яА-ЯіІїЇєЄ0-9]').hasMatch(char)) continue; 
      
      current.children.putIfAbsent(char, () => TrieNode());
      current = current.children[char]!;
    }
    current.isEndOfWord = true;
    
    // Prevent adding the exact same item object multiple times to the same node
    if (!current.itemIds.contains(item.id)) {
      current.itemIds.add(item.id);
      current.items.add(item);
    }
  }

  List<SearchableItem> search(String query) {
    if (query.isEmpty) return [];
    
    TrieNode current = root;
    // Walk down the tree matches
    for (int i = 0; i < query.length; i++) {
      final char = query[i].toLowerCase();
      if (!current.children.containsKey(char)) return [];
      current = current.children[char]!;
    }
    
    return _collectAllItems(current);
  }

  List<SearchableItem> _collectAllItems(TrieNode node) {
    List<SearchableItem> results = [];
    if (node.isEndOfWord) {
      results.addAll(node.items);
    }
    
    for (var child in node.children.values) {
      results.addAll(_collectAllItems(child));
    }
    
    // Final deduplication before showing to user
    final seen = <String>{};
    return results.where((item) => seen.add(item.id)).toList();
  }
}