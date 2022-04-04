import { buildWordCountByLetterMap, filterWordsByContainingAllInclusionLetters, filterWordsByExclusionLetters } from 'c/wordUtil';

function filterWordleWords(wordsToFilter, excludedCharactersString, includedCharacterRules) {
    const excludedCharactersArray = Array.from(excludedCharactersString);
    const lowerCaseExcludedCharacters = excludedCharactersArray.map(ec => ec.toLowerCase());

    let filteredWords = filterWordsByExclusionLetters(wordsToFilter, lowerCaseExcludedCharacters);

    return filterWordsByInclusionLetterRules(filteredWords, includedCharacterRules);;
}

function filterWordsByInclusionLetterRules(wordsToFilter, inclusionLetterRules) {
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

function calculateNextSuggestedWords(candidateWords) {
    if (candidateWords.length == 1) {
        return candidateWords;
    }

    const wordCountByletterMap = buildWordCountByLetterMap(candidateWords);
    const top5LettersWithWordCountMap = getTop5MosedUsedLetters(wordCountByletterMap);

    let nextSuggestedWord = '';
    let suggestedWords = [];

    for (let currentTopLetters = 5; currentTopLetters >= 3; currentTopLetters--) {
        let topMostCharacters = getTopNCharacters(top5LettersWithWordCountMap, currentTopLetters);

        suggestedWords = filterWordsByContainingAllInclusionLetters(candidateWords, topMostCharacters);

        if (suggestedWords.length > 0) {
            break;
        }
    }

    return suggestedWords;
}

function getTop5MosedUsedLetters(wordCountByletterMap) {
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

function getTopNCharacters(wordCountByletterMap, topNWords) {
    let topNCharacters = [];
    let counter = 0;
    let characters = [...wordCountByletterMap.keys()];

    for (let index = 0; index < topNWords; ++index) {
        topNCharacters.push(characters[index]);
    }

    return topNCharacters;
}

export { filterWordsByInclusionLetterRules, calculateNextSuggestedWords, filterWordleWords };