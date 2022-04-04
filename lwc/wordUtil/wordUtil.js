function buildWordCountByLetterMap(words) {
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

function getAllLowercaseEnglishLetters() {
    const lowerCaseEnglishLetters = [];
    const lowerCaseACharCode = 97;
    const lowerCaseZCharCode = 122;

    for (let charCode = lowerCaseACharCode; charCode <= lowerCaseZCharCode; ++charCode) {
        lowerCaseEnglishLetters.push( String.fromCharCode(charCode) );
    }

    return lowerCaseEnglishLetters;
}

function filterWordsByExclusionLetters(wordsToFilter, exclusionLetters) {
    if (!exclusionLetters ||
        exclusionLetters.length == 0) {
        return wordsToFilter;
    }

    const lowerCaseExcludedCharacters = exclusionLetters.map(ec => ec.toLowerCase());
    const excludedFilteredWords = [];

    for (const eligibleWord of wordsToFilter) {

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

function filterWordsByContainingAllInclusionLetters(wordsToFilter, inclusionLetters) {
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

function sortWordsByMostUsedToLeastUsed(wordsToSort, wordFrequenciesByWord) {
    let compareFunction = (wordA, wordB) => {
        const wordAFrequency = wordFrequenciesByWord[wordA];
        const wordBFrequency = wordFrequenciesByWord[wordB];

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
    };

    if (wordFrequenciesByWord instanceof Map) {
        compareFunction = (wordA, wordB) => {
            const wordAFrequency = wordFrequenciesByWord.get(wordA);
            const wordBFrequency = wordFrequenciesByWord.get(wordB);
    
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
        };
    }

    return wordsToSort.sort(compareFunction);
}

export { buildWordCountByLetterMap,
         getAllLowercaseEnglishLetters,
         filterWordsByExclusionLetters,
         filterWordsByContainingAllInclusionLetters,
         sortWordsByMostUsedToLeastUsed };

