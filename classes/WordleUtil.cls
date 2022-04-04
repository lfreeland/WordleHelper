public with sharing class WordleUtil {
    public static final Id WORD_FREQUENCY_FILE_ID = '0694W00000M0vCaQAJ';

    public static List<String> fiveLetterWords = new List<String>();
    public static Map<String, Long> fiveLetterWordFrequencies = new Map<String, Long>();

    static {
        fiveLetterWords = new List<String>();

        fiveLetterWords.addAll(WordleFiveLetterWords1.fiveLetterWords);
        fiveLetterWords.addAll(WordleFiveLetterWords2.fiveLetterWords);

        fiveLetterWordFrequencies = new Map<String, Long>();

        fiveLetterWordFrequencies.putAll(Wordle5LetterWordsWithFrequencies.wordsWithFrequencies);
        fiveLetterWordFrequencies.putAll(Wordle5LetterWordsWithFrequencies2.wordsWithFrequencies);
        fiveLetterWordFrequencies.putAll(Wordle5LetterWordsWithFrequencies3.wordsWithFrequencies);
        fiveLetterWordFrequencies.putAll(Wordle5LetterWordsWithFrequencies4.wordsWithFrequencies);
        fiveLetterWordFrequencies.putAll(Wordle5LetterWordsWithFrequencies5.wordsWithFrequencies);
        fiveLetterWordFrequencies.putAll(Wordle5LetterWordsWithFrequencies6.wordsWithFrequencies);
        fiveLetterWordFrequencies.putAll(Wordle5LetterWordsWithFrequencies7.wordsWithFrequencies);
        fiveLetterWordFrequencies.putAll(Wordle5LetterWordsWithFrequencies8.wordsWithFrequencies);
        fiveLetterWordFrequencies.putAll(Wordle5LetterWordsWithFrequencies9.wordsWithFrequencies);
        fiveLetterWordFrequencies.putAll(Wordle5LetterWordsWithFrequencies10.wordsWithFrequencies);
        fiveLetterWordFrequencies.putAll(Wordle5LetterWordsWithFrequencies11.wordsWithFrequencies);
        fiveLetterWordFrequencies.putAll(Wordle5LetterWordsWithFrequencies12.wordsWithFrequencies);
        fiveLetterWordFrequencies.putAll(Wordle5LetterWordsWithFrequencies13.wordsWithFrequencies);
        fiveLetterWordFrequencies.putAll(Wordle5LetterWordsWithFrequencies14.wordsWithFrequencies);
        fiveLetterWordFrequencies.putAll(Wordle5LetterWordsWithFrequencies15.wordsWithFrequencies);
        fiveLetterWordFrequencies.putAll(Wordle5LetterWordsWithFrequencies16.wordsWithFrequencies);
        fiveLetterWordFrequencies.putAll(Wordle5LetterWordsWithFrequencies17.wordsWithFrequencies);
    }

    public static Map<String, long> getWordLengthsByWordMap() {
        ContentDocument wordFrequencyFile = [
            SELECT Id,
                   Title,
                   LatestPublishedVersionId,
                   LatestPublishedVersion.VersionData
              FROM ContentDocument
             WHERE Id = :WORD_FREQUENCY_FILE_ID
        ];

        String wordsFrequencyFileContents = wordFrequencyFile.LatestPublishedVersion.VersionData.tostring();

        List<String> splitWordFrequencyParts = wordsFrequencyFileContents.splitByCharacterType();

        system.debug(' splitWordFrequencyParts.size: ' + splitWordFrequencyParts.size());
        Integer collectionSize = splitWordFrequencyParts.size();

        String currentWord = '';
        Long currentWordFrequency = 0;
        Set<String> ignoreStrings = new Set<String>{
            ',',
            '\n',
            'word',
            'count'
        };

        Map<String, long> wordLengthsByWord = new Map<String, Long>();

        for (Integer i = 0; i < collectionSize; ++i) {
            String splitWordFrequencyPart = splitWordFrequencyParts[i];

            if (ignoreStrings.contains(splitWordFrequencyPart)) {
                continue;
            }

            if (splitWordFrequencyPart.isAlpha()) {
                currentWord = splitWordFrequencyPart;
                continue;
            }

            if (splitWordFrequencyPart.isNumeric()) {
                currentWordFrequency = Long.valueOf(splitWordFrequencyPart);
                wordLengthsByWord.put(currentWord, currentWordFrequency);
            }
        }

        return wordLengthsByWord;
    }

    public static void writeFileWithMapFrequencyContents(Integer wordLength, Id contentDocumentId, String fileName) {
        ContentDocument wordFrequencyFile = [
            SELECT Id,
                   Title,
                   LatestPublishedVersionId,
                   LatestPublishedVersion.VersionData
              FROM ContentDocument
             WHERE Id = :contentDocumentId
        ];

        String wordsFrequencyFileContents = wordFrequencyFile.LatestPublishedVersion.VersionData.tostring();

        List<String> splitWordFrequencyParts = wordsFrequencyFileContents.splitByCharacterType();

        system.debug(' splitWordFrequencyParts.size: ' + splitWordFrequencyParts.size());
        Integer collectionSize = splitWordFrequencyParts.size();

        for (Integer i = 0; i< 50; ++i) {
            system.debug(' splitWordFrequencyParts[' + i + '] is ' + splitWordFrequencyParts[i]);
        }

        String currentWord = '';
        Long currentWordFrequency = 0;
        Set<String> ignoreStrings = new Set<String>{
            ',',
            '\n',
            'word',
            'count'
        };

        List<String> fileRows = new List<String>();

        for (Integer i = 0; i < collectionSize; ++i) {
            String splitWordFrequencyPart = splitWordFrequencyParts[i];

            if (ignoreStrings.contains(splitWordFrequencyPart)) {
                continue;
            }

            if (splitWordFrequencyPart.isAlpha()) {
                currentWord = splitWordFrequencyPart;
                continue;
            }

            if (splitWordFrequencyPart.isNumeric() &&
                currentWord.length() == wordLength) {
                //system.debug('  found length word ' + currentWord);

                fileRows.add('\'' + currentWord + '\'' + '=>' + splitWordFrequencyPart + ',');
            }
        }

        system.debug('  fileRows size: ' + fileRows.size());

        String fileContents = String.join(fileRows, '\n');

        system.debug('  fileContents Length: ' + fileContents.length());

        ContentVersion conVer = new ContentVersion();
        conVer.ContentLocation = 'S'; // to use S specify this document is in Salesforce, to use E for external files
        conVer.PathOnClient = fileName + '.txt'; // The files name, extension is very important here which will help the file in preview.
        conVer.Title =  fileName;// Display name of the files
        conVer.VersionData = Blob.valueOf(fileContents); // converting your binary string to Blog
        insert conVer;
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

    public static Map<String, Integer> buildLetterCountMap(List<String> words) {
        Map<String, Integer> letterCounts = new Map<String, Integer>();

        for (String lowerCaseLetter : getEnglishLowerCaseLetters()) {
            system.debug('  lowerCaseLetter: ' + lowerCaseLetter);

            letterCounts.put(lowerCaseLetter, 0);
        }

        for (String word : words) {
            Integer wordLength = word.length();

            for (Integer letterIndex = 0; letterIndex < wordLength; ++letterIndex) {
                Integer characterCode = word.charAt(letterIndex);
                String letter = String.fromCharArray(new Integer[]{ characterCode });
                String lowerCaseLetter = letter.toLowerCase();

                Integer letterCount = letterCounts.get(lowerCaseLetter);
                ++letterCount;

                letterCounts.put(lowerCaseLetter, letterCount);
            }
        }


        return letterCounts;
    }

    public static List<String> getEnglishLowerCaseLetters() {
        Integer lowerCaseACharCode = 97;
        Integer lowerCaseZCharCode = 122;
        List<String> lowerCaseEnglishLetters = new List<String>();

        for (Integer characterCode = lowerCaseACharCode; characterCode <= lowerCaseZCharCode; ++characterCode) {
            lowerCaseEnglishLetters.add( String.fromCharArray(new Integer[]{ characterCode }) );
        }

        return lowerCaseEnglishLetters;
    }
}
