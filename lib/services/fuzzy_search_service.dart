import '../models/medical_term.dart';

class TrieNode {
  final Map<String, TrieNode> children = {};
  final Set<MedicalTerm> data = {};
}

class FuzzySearchService {
  final TrieNode root = TrieNode();

  /// Insert a term and all its suffixes into the Trie
  void insert(MedicalTerm item) {
    String word = item.term.toLowerCase();
    
    // Suffix insertion: allows matching "cardio" inside "tachycardia"
    for (int i = 0; i < word.length; i++) {
      String suffix = word.substring(i);
      _insertString(suffix, item);
    }
  }

  void _insertString(String s, MedicalTerm item) {
    TrieNode current = root;
    for (int i = 0; i < s.length; i++) {
      String char = s[i];
      current.children.putIfAbsent(char, () => TrieNode());
      current = current.children[char]!;
      current.data.add(item);
    }
  }

  /// Public search method
  List<MedicalTerm> search(String query, {int maxResults = 10, int tolerance = 1}) {
    if (query.isEmpty) return [];

    String cleanQuery = query.toLowerCase();
    Set<MedicalTerm> results = {};

    _searchRecursive(root, cleanQuery, 0, tolerance, results);

    List<MedicalTerm> sortedList = results.toList();
    
    // Sort by Popularity (Most probable first)
    sortedList.sort((a, b) => b.popularity.compareTo(a.popularity));

    return sortedList.take(maxResults).toList();
  }

  /// Recursive fuzzy traversal
  void _searchRecursive(
    TrieNode node,
    String query,
    int index,
    int mistakesAllowed,
    Set<MedicalTerm> results,
  ) {
    if (index == query.length) {
      results.addAll(node.data);
      return;
    }

    String charToMatch = query[index];

    node.children.forEach((char, childNode) {
      // 1. Exact Match
      if (char == charToMatch) {
        _searchRecursive(childNode, query, index + 1, mistakesAllowed, results);
      } 
      // 2. Mistake: Substitution (e.g. 'ь' -> 'б')
      else if (mistakesAllowed > 0) {
        _searchRecursive(childNode, query, index + 1, mistakesAllowed - 1, results);
      }
    });
  }
}