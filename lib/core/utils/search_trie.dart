import '../../models/search_models.dart';

class TrieNode {
  final Map<String, TrieNode> children = {};
  // Using a Set ensures we don't list the same item twice for the same query
  final Set<SearchableItem> items = {}; 
}

class SearchTrie {
  final TrieNode root = TrieNode();

  /// Inserts an item and ALL its suffixes into the Trie
  /// Example: "Cardio" -> inserts "cardio", "ardio", "rdio"...
  void insert(SearchableItem item) {
    // 1. Insert Title Suffixes (e.g. "Petrenko")
    _insertSuffixes(item.title.toLowerCase(), item);
    // 2. Insert Subtitle Suffixes (e.g. "Cardiologist")
    _insertSuffixes(item.subtitle.toLowerCase(), item);
  }

  void _insertSuffixes(String text, SearchableItem item) {
    for (int i = 0; i < text.length; i++) {
      // Insert substring starting from i
      _insertString(text.substring(i), item);
    }
  }

  void _insertString(String key, SearchableItem item) {
    TrieNode current = root;
    for (int i = 0; i < key.length; i++) {
      final char = key[i];
      
      // Skip special characters to keep the index clean
      if (!RegExp(r'[a-zA-Zа-яА-ЯіІїЇєЄ0-9]').hasMatch(char)) continue;

      current.children.putIfAbsent(char, () => TrieNode());
      current = current.children[char]!;
      // Store the item at every node of the path
      current.items.add(item);
    }
  }

  /// The Fuzzy Search Function
  /// [maxResults] - Limits return to top 10 most probable
  /// [tolerance] - How many typos are allowed (default 1)
  List<SearchableItem> search(String query, {int maxResults = 10, int tolerance = 1}) {
    if (query.isEmpty) return [];

    String cleanQuery = query.toLowerCase();
    Set<SearchableItem> results = {};

    // Logic: Don't allow typos for very short words (<= 3 chars) to avoid noise
    int currentTolerance = cleanQuery.length > 3 ? tolerance : 0;

    // Start recursive search from root
    _searchRecursive(
      node: root, 
      query: cleanQuery, 
      index: 0, 
      mistakesAllowed: currentTolerance, 
      results: results
    );

    // Convert to list and Sort by Score (Probability)
    List<SearchableItem> sortedList = results.toList();
    
    sortedList.sort((a, b) {
      // Sort descending by score (highest likes first)
      return b.score.compareTo(a.score);
    });

    return sortedList.take(maxResults).toList();
  }

  void _searchRecursive({
    required TrieNode node,
    required String query,
    required int index,
    required int mistakesAllowed,
    required Set<SearchableItem> results,
  }) {
    // Base Case: We have matched the entire query (approx)
    if (index == query.length) {
      results.addAll(node.items);
      return;
    }

    String charToMatch = query[index];

    node.children.forEach((char, childNode) {
      // 1. Exact Match (No cost)
      if (char == charToMatch) {
        _searchRecursive(
          node: childNode,
          query: query,
          index: index + 1,
          mistakesAllowed: mistakesAllowed,
          results: results,
        );
      } 
      // 2. Mistake: Substitution (e.g. user typed 'ь' instead of 'б')
      // Only proceed if we have "budget" for mistakes
      else if (mistakesAllowed > 0) {
        _searchRecursive(
          node: childNode,
          query: query,
          index: index + 1,
          mistakesAllowed: mistakesAllowed - 1, // Reduce budget
          results: results,
        );
      }
    });
  }
}