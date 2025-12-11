import json
from sentence_transformers import SentenceTransformer

print("Loading model...")
model = SentenceTransformer('sentence-transformers/all-MiniLM-L6-v2')

# Load Data
try:
    with open('assets/symptoms.json', 'r', encoding='utf-8') as f:
        symptoms = json.load(f)
    with open('assets/doctors.json', 'r', encoding='utf-8') as f:
        doctors = json.load(f)
except FileNotFoundError:
    print("Error: assets/symptoms.json or assets/doctors.json not found.")
    exit()

all_items = symptoms + doctors
print(f"Processing {len(all_items)} items...")

for item in all_items:
    # 1. Generate Vector (Embedding)
    # We use the text field which contains keywords
    text_content = item.get('text', '')
    vector = model.encode(text_content).tolist()
    item['vector'] = vector
    
    # 2. CRITICAL: DO NOT DELETE 'text'. 
    # The Flutter app uses it as the title for symptoms!
    # if 'text' in item: del item['text'] <--- This was the bug

output_file = 'assets/search_data_with_vectors.json'
with open(output_file, 'w', encoding='utf-8') as f:
    json.dump(all_items, f)

print(f"Success! Saved to {output_file}. Move this to your Flutter assets folder.")