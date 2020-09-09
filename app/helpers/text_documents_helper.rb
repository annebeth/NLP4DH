module TextDocumentsHelper

  def extract_top_10_ner(annotation)
    all_ents = Array.new

    annotation['sentences'].each { |sentence|
      sentence['ents'].each { |ent|
        all_ents.push(ent)
      }
    }

    ent_counts = all_ents.each_with_object(Hash.new(0)) do |ent, new_hash|
      new_hash[ent] += 1
    end

    long_array = Array.new
    simple_ent_counts = ent_counts.each do |ent, value|
      long_array.push({"text" => ent["text"],
                      "label" => ent["label"],
                      "count" => value
                      })
    end

    sorted = long_array.sort_by { |k| -k["count"] }
    sorted[0..9].to_json

  end
end
