import en_core_web_sm

# TODO: Add a model for SRL.

# Load English tokenizer, tagger, parser, NER.
nlp = en_core_web_sm.load()

def annotate(text, id):
    # Start a token counter for this textfile.
    token_counter = 0

    # Process the text with Spacy.
    doc = nlp(text)

    text_json = {
        # TODO: What to do with this id?
        "id": id,
        "sentences": []
    }

    # Process each sentence separately.
    for sent in doc.sents:

        # Token
        tokens = []
        for token in sent:
            ner = token.ent_iob_ + "-" + token.ent_type_ if token.ent_iob_ == "B" else token.ent_iob_
            token = {
                "id": token_counter,
                "orth": token.text,
                "dep": token.dep_,
                "ner": ner
            }

            token_counter += 1
            tokens.append(token)

        # Noun chunks
        noun_chunks = []
        for chunk in sent.noun_chunks:
            chunk = {
                "text": chunk.text,
                "label": chunk.root.dep_
            }
            noun_chunks.append(chunk)

        # Named entities
        ents = []
        for ent in sent.ents:
            ent = {
                "text": ent.text,
                "label": ent.label_
            }
            ents.append(ent)

        # Create a json fragment for this sentence
        sentence_json = {
            "raw": str(sent).strip(),
            "tokens": tokens,
            "noun_chunks": noun_chunks,
            "ents": ents
        }

        text_json["sentences"].append(sentence_json)
    return text_json
