import { LightningElement, track } from 'lwc';
import getWordleContext from '@salesforce/apex/WordleHelperController.getWordleContext';
import getAll5LetterWords from '@salesforce/apex/WordleHelperController.getAll5LetterWords';

export default class WordleHelper extends LightningElement {
    excludedCharacters = '';
    @track includedCharacters = [];
    @track candidateWords = [];
    showCandidateWords = false;
    all5LetterWords = [];
    fiveLetterFrequencies;

    get englishCharacterOptions() {
        const aToZChars = [];

        for (const lowerCaseEnglishLetter of this.getAllLowercaseEnglishLetters()) {
            aToZChars.push( {
                label: lowerCaseEnglishLetter,
                value: lowerCaseEnglishLetter
            });
        }

        return aToZChars;
    }

    get letterInOrNotInOptions() {
        return [
            { label: "is", value: "is" },
            { label: "is not", value: "is not" }
        ];
    }

    get letterPositionOptions() {
        return [
            { label: "first letter", value: "1" },
            { label: "second letter", value: "2" },
            { label: "third letter", value: "3" },
            { label: "fourth letter", value: "4" },
            { label: "fifth letter", value: "5" }
        ]
    }

    get hasCandidateWords() {
        return this.candidateWords && this.candidateWords.length > 0;
    }

    get hasSuggestedWords() {
        return this.suggestedNextWords && this.suggestedNextWords.length > 0;
    }

    connectedCallback() {
        this.addIncludedCharacterRow();
        this.loadWordleContext();
    }

    onExcludedCharactersChange(event) {
        this.excludedCharacters = event.detail.value;
    }

    onIncludedCharacterChange(event) {
        const index = event.currentTarget.dataset.index;

        const includedCharacterRow = this.includedCharacters[index];
        includedCharacterRow.character = event.detail.value;
    }

    onLetterInOrNotInChange(event) {
        const index = event.currentTarget.dataset.index;

        const includedCharacterRow = this.includedCharacters[index];
        includedCharacterRow.isOrIsNot = event.detail.value;
    }

    onLetterPositionChange(event) {
        const index = event.currentTarget.dataset.index;

        const includedCharacterRow = this.includedCharacters[index];
        includedCharacterRow.letterPosition = event.detail.value;
    }

    onAddIncludedCharacterRowClick(event) {
        this.addIncludedCharacterRow();
    }

    addIncludedCharacterRow() {
        this.includedCharacters.push({
            index: this.includedCharacters.length,
            character: '',
            isOrIsNot: 'is not',
            letterPosition: null
        });
    }

    onDeleteIncludedCharacterRow(event) {
        // Remove the designated row
        this.includedCharacters.splice(event.currentTarget.value, 1);

        // Reset the remaining row indices.
        for (let i = 0; i < this.includedCharacters.length; ++i) {
            let includedCharacter = this.includedCharacters[i];

            includedCharacter.index = i;
        }
    }

    onResetClick(event) {
        this.excludedCharacters = '';
        this.includedCharacters = [];
        this.addIncludedCharacterRow();
        this.showCandidateWords = false;
        this.candidateWords = [];
    }

    onGetEligibleWordsClick(event) {
        this.candidateWords = this.filter5LetterWordleWords();
        this.showCandidateWords = true;

        this.suggestedNextWords = this.calculateNextSuggestedWords(this.candidateWords);
    }

    filter5LetterWordleWords() {
        const excludedCharactersArray = Array.from(this.excludedCharacters);
        const lowerCaseExcludedCharacters = excludedCharactersArray.map(ec => ec.toLowerCase());

        let filtered5LetterWords = this.filterWordsByExclusionLetters(this.all5LetterWords, lowerCaseExcludedCharacters);
        filtered5LetterWords = this.filterWordsByInclusionLetterRules(filtered5LetterWords, this.getIncludedCharacterRules());

        return this.sortWordsByMostUsedToLeastUsed(filtered5LetterWords);
    }

    filterWordsByExclusionLetters(wordsToFilter, exclusionLetters) {
        if (!exclusionLetters ||
            exclusionLetters.length == 0) {
            return wordsToFilter;
        }

        const lowerCaseExcludedCharacters = exclusionLetters.map(ec => ec.toLowerCase());
        const excludedFilteredWords = [];

        for (let eligibleWord of wordsToFilter) {

            let containsExcludedCharacters = false;

            for (const excludedCharacter of lowerCaseExcludedCharacters) {
                if (eligibleWord.includes(excludedCharacter)) {
                    containsExcludedCharacters = true;
                    break;
                }
            }

            if (containsExcludedCharacters == false) {
                excludedFilteredWords.push(eligibleWord);
            }
        }

        return excludedFilteredWords;
    }

    filterWordsByInclusionLetterRules(wordsToFilter, inclusionLetterRules) {
        if (!inclusionLetterRules ||
            inclusionLetterRules.length == 0) {
            return wordsToFilter;
        }

        const filteredWords = [];

        for (const remainingEligibleWord of wordsToFilter) {
            let passesAllIncludedFilters = true;

            for (const inclusionLetterRule of inclusionLetterRules) {
                if (remainingEligibleWord.includes(inclusionLetterRule.Character) == false) {
                    passesAllIncludedFilters = false;
                    break;
                }

                const remainingEligibleWordCharacterAtPosition = remainingEligibleWord[inclusionLetterRule.Position];

                if (inclusionLetterRule.ExactLocation &&
                    remainingEligibleWordCharacterAtPosition != inclusionLetterRule.Character) {
                    passesAllIncludedFilters = false;
                    break;
                }

                if (inclusionLetterRule.ExactLocation == false &&
                    remainingEligibleWordCharacterAtPosition == inclusionLetterRule.Character) {
                    passesAllIncludedFilters = false;
                    break;
                }
            }

            if (passesAllIncludedFilters) {
                filteredWords.push(remainingEligibleWord);
            }
        }

        return filteredWords;
    }

    filterWordsByContainingAllInclusionLetters(wordsToFilter, inclusionLetters) {
        if (!inclusionLetters ||
            inclusionLetters.length == 0) {
            return wordsToFilter;
        }

        const filteredWords = [];

        for (const word of wordsToFilter) {
            let hasAllLetters = true;

            for (const inclusionLetter of inclusionLetters) {
                if (word.includes(inclusionLetter) == false) {
                    hasAllLetters = false;
                    break;
                }
            }

            if (hasAllLetters) {
                filteredWords.push(word);
            }
        }

        return filteredWords;
    }

    getIncludedCharacterRules() {
        const includedCharacterRows = [];

        for (const includedCharacter of this.includedCharacters) {
            if (!includedCharacter.character ||
                !includedCharacter.isOrIsNot ||
                !includedCharacter.letterPosition) {

                continue;
            }

            includedCharacterRows.push({
                Character: includedCharacter.character,
                Position:  parseInt(includedCharacter.letterPosition) - 1,
                ExactLocation: includedCharacter.isOrIsNot === 'is'
            });
        }

        return includedCharacterRows;
    }

    loadWordleContext() {
        getWordleContext()
        .then(result => {
            this.all5LetterWords = result.fiveLetterWords;
            this.fiveLetterFrequencies = result.fiveLetterWordFrequencies;
        });
    }

    getAllLowercaseEnglishLetters() {
        const lowerCaseEnglishLetters = [];
        const lowerCaseACharCode = 97;
        const lowerCaseZCharCode = 122;

        for (let charCode = lowerCaseACharCode; charCode <= lowerCaseZCharCode; ++charCode) {
            lowerCaseEnglishLetters.push( String.fromCharCode(charCode) );
        }

        return lowerCaseEnglishLetters;
    }

    calculateNextSuggestedWords(candidateWords) {
        if (candidateWords.length == 1) {
            return candidateWords;
        }

        const wordCountByletterMap = this.buildWordCountByLetterMap(candidateWords);
        const top5LettersWithWordCountMap = this.getTop5MosedUsedLetters(wordCountByletterMap);

        let nextSuggestedWord = '';
        let suggestedWords = [];

        for (let currentTopLetters = 5; currentTopLetters >= 3; currentTopLetters--) {
            let topMostCharacters = this.getTopNCharacters(top5LettersWithWordCountMap, currentTopLetters);

            suggestedWords = this.filterWordsByContainingAllInclusionLetters(candidateWords, topMostCharacters);

            if (suggestedWords.length > 0) {
                break;
            }
        }

        return this.sortWordsByMostUsedToLeastUsed(suggestedWords);
    }

    buildWordCountByLetterMap(words) {
        const wordCountByLetterMap = new Map();

        for (const lowerCaseEnglishLetter of this.getAllLowercaseEnglishLetters()) {
            wordCountByLetterMap.set(lowerCaseEnglishLetter, 0);
        }

        for (const word of words) {
            for (let charIndex = 0; charIndex < word.length; ++charIndex) {
                let letter = word[charIndex];

                let letterWordCount = wordCountByLetterMap.get(letter);
                ++letterWordCount;

                wordCountByLetterMap.set(letter, letterWordCount);
            }
        }

        return wordCountByLetterMap;
    }

    getTop5MosedUsedLetters(wordCountByletterMap) {
        let lettersByWordCountMap = new Map();

        for (const letter of wordCountByletterMap.keys()) {
            lettersByWordCountMap.set(wordCountByletterMap.get(letter), letter);
        }

        let wordCountsArray = [];

        for (const wordCount of lettersByWordCountMap.keys()) {
            wordCountsArray.push(wordCount);
        }

        // Pass the sort function so the numbers are sorted properly.
        wordCountsArray = wordCountsArray.sort(function(a, b){return a-b});
        wordCountsArray = wordCountsArray.reverse();

        const top5LettersWithWordCountMap = new Map();

        for (let i = 0; i < 5; ++i) {
            let wordCount = wordCountsArray[i];
            let letter = lettersByWordCountMap.get(wordCount);

            top5LettersWithWordCountMap.set(letter, wordCount);
        }

        return top5LettersWithWordCountMap;
    }

    getTopNCharacters(wordCountByletterMap, topNWords) {
        let topNCharacters = [];
        let counter = 0;
        let characters = [...wordCountByletterMap.keys()];

        for (let index = 0; index < topNWords; ++index) {
            topNCharacters.push(characters[index]);
        }

        return topNCharacters;
    }

    sortWordsByMostUsedToLeastUsed(wordsToSort) {
        var fiveLetterFreqs = this.fiveLetterFrequencies;

        return wordsToSort.sort(function compareFn(wordA, wordB) {
            const wordAFrequency = fiveLetterFreqs[wordA];
            const wordBFrequency = fiveLetterFreqs[wordB];

            if (wordAFrequency && wordBFrequency) {
                return wordBFrequency - wordAFrequency;
            }

            // word B not found but word A found so word A comes first
            if (wordAFrequency && !wordBFrequency) {
                return -1;
            }

            // word A not found but word B found so word B comes first
            if (wordBFrequency && !wordAFrequency) {
                return 1;
            }

            return 0;
        });
    }
}