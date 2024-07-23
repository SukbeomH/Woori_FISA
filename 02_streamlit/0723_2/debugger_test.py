def count_words(words):
    count = 0
    for word in words:
        if "kim" in word.lower():
            count += 1
    return count


words = ["Kim", "kimchi", "gim"]
print(count_words(words))