public without sharing class WordleHelperController {

    @AuraEnabled
    public static String getAllWordsWithFrequenciesFileContents() {
        // The Kabble Source Dicitionary is stored in the ContentDocument file.
        // Update the Id with your content document id.
        ContentDocument wordFrequencyFile = [
            SELECT Id,
                   Title,
                   LatestPublishedVersionId,
                   LatestPublishedVersion.VersionData
              FROM ContentDocument
             WHERE Id = :'0694W00000M0vCaQAJ'
        ];

        return wordFrequencyFile.LatestPublishedVersion.VersionData.tostring();
    }

    @AuraEnabled
    public static WordleContext getWordleContext(){
        WordleContext context = new WordleContext();

        context.fiveLetterWords = WordleUtil.fiveLetterWords;
        context.fiveLetterWordFrequencies = WordleUtil.fiveLetterWordFrequencies;

        return context;
    }

    @AuraEnabled
    public static List<String> getAll5LetterWords() {
        return WordleUtil.fiveLetterWords;
    }

    @AuraEnabled
    public static List<String> filter5LetterWordleWords(List<String> excludedCharacters, List<WordleHelper.IncludedCharacterMetadata> includedCharacters){
        system.debug('  filter5LetterWordleWords::excludedCharacters: ' + excludedCharacters);
        system.debug('  filter5LetterWordleWords::includedCharacters: ' + includedCharacters);

        return new WordleHelper().filterCandidateWords(WordleUtil.fiveLetterWords, includedCharacters, excludedCharacters);
    }

    public class WordleContext {
        @AuraEnabled
        public List<String> fiveLetterWords { get; set; }

        @AuraEnabled
        public Map<String, Long> fiveLetterWordFrequencies { get; set; }
    }

    public class WordleMetadata {
        @AuraEnabled
        public String AllWordsString { get; set; }

        @AuraEnabled
        public String allWordsWithFrequencies { get; set; }
    }
}
