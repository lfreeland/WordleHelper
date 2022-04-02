public with sharing class WordleUtil {
    public static List<String> fiveLetterWords = new List<String>();

    static {
        fiveLetterWords = new List<String>();

        fiveLetterWords.addAll(WordleFiveLetterWords1.fiveLetterWords);
        fiveLetterWords.addAll(WordleFiveLetterWords2.fiveLetterWords);
    }


    public static void writeFileWithLengthWords(List<String> words, Integer fixedLength, String fileName) {
        List<String> lengthWords = getFixedLengthWords(words, fixedLength);

        String lengthWordsFileContents = String.join(lengthWords, '\n');


        ContentVersion conVer = new ContentVersion();
        conVer.ContentLocation = 'S'; // to use S specify this document is in Salesforce, to use E for external files
        conVer.PathOnClient = fileName; // The files name, extension is very important here which will help the file in preview.
        conVer.Title = fixedLength + ' Letter English Words'; // Display name of the files
        conVer.VersionData = Blob.valueOf(lengthWordsFileContents); // converting your binary string to Blog
        insert conVer;
    }

    public static List<String> getFixedLengthWords(List<String> words, Integer fixedLength) {
        List<String> lengthWords = new List<String>();
        Integer wordsCount = words.size();

        for (Integer wordIndex = 0; wordIndex < wordsCount; ++wordIndex) {
            String word = words[wordIndex];

            if (word.length() == fixedLength) {
                lengthWords.add(word);
            }
        }

        return lengthWords;
    }


}
