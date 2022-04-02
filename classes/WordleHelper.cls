public with sharing class WordleHelper {

    public List<String> filterCandidateWords(List<String> candidateWords, List<IncludedCharacterMetadata> includedCharacters, List<String> excludedCharacters) {
        List<String> filteredWords = new List<String>();

        Integer candidateWordsCount = candidateWords.size();

        List<String> excludedStringFilteredWords = new List<String>();

        for (Integer i = 0; i < candidateWordsCount; i++) {
            String candidateWord = candidateWords[i];

            Boolean containsExcludedCharacters = false;

            for (String excludedCharacter : excludedCharacters) {
                if (candidateWord.containsIgnoreCase(excludedCharacter)) {
                    containsExcludedCharacters = true;
                    break;
                }
            }

            if (containsExcludedCharacters == false) {
                excludedStringFilteredWords.add(candidateWord);
            }
        }

        if (includedCharacters == null ||
            includedCharacters.isEmpty()) {
            
            return excludedStringFilteredWords;
        }

        if (excludedCharacters == null ||
            excludedCharacters.isEmpty()) {
            excludedStringFilteredWords = candidateWords;
        }

        Integer remainingCandidateWordsCount = excludedStringFilteredWords.size();

        for (Integer i = 0; i < remainingCandidateWordsCount; ++i) {
            String candidateWord = excludedStringFilteredWords[i];

            Boolean passesAllIncludedFilters = true;

            for (IncludedCharacterMetadata icm : includedCharacters) {                   
                if (icm.wordPassesFilter(candidateWord) == false) {
                    passesAllIncludedFilters = false;
                    break;
                }
            }

            if (passesAllIncludedFilters) {
                filteredWords.add(candidateWord);
            }
        }

        return filteredWords;
    }
    
    public class IncludedCharacterMetadata {
        @AuraEnabled
        public String Character { get; set; }

        @AuraEnabled
        public Integer Position { get; set; }

        @AuraEnabled
        public Boolean ExactLocation { get; set; }

        public IncludedCharacterMetadata() {
        }

        public Boolean wordPassesFilter(String candidateWord) {
            Boolean passes = candidateWord.containsIgnoreCase(Character);

            if (!passes) {
                return passes;
            }

            Integer characterCode = candidateWord.charAt(Position);
            String positionCharacter = String.fromCharArray(new Integer[]{ characterCode });

            if (ExactLocation) {
                return positionCharacter == Character;
            }

            return positionCharacter != Character;
        }
    }
}
