public with sharing class WordleHelperController {

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
}
