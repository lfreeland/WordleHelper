import { LightningElement, track } from 'lwc';
import getWordleContext from '@salesforce/apex/WordleHelperController.getWordleContext';
import getAll5LetterWords from '@salesforce/apex/WordleHelperController.getAll5LetterWords';
import getAllWordsWithFrequenciesFileContents from '@salesforce/apex/WordleHelperController.getAllWordsWithFrequenciesFileContents';
import { sortWordsByMostUsedToLeastUsed } from 'c/wordUtil';
import { calculateNextSuggestedWords, filterWordleWords } from 'c/wordleUtil';

const NEWLINE = '\n';

export default class WordleHelper extends LightningElement {
    @track candidateWords = [];
    showCandidateWords = false;
    //wordLengthWords = [];
    @track wordFrequenciesByWord = new Map();
    @track wordsByWordLength = new Map();

    get hasCandidateWords() {
        return this.candidateWords && this.candidateWords.length > 0;
    }

    get hasSuggestedWords() {
        return this.suggestedNextWords && this.suggestedNextWords.length > 0;
    }

    get selectedWordLengthWords() {
        const formInputElement = this.getWordleFilterFormElement();
        const selectedWordLength = formInputElement.getSelectedWordLength();

        return this.wordsByWordLength.get(selectedWordLength);
    }

    connectedCallback() {
        this.loadWordleContext();
    }

    onResetClick(event) {
        this.showCandidateWords = false;
        this.candidateWords = [];
    }

    onGetEligibleWordsClick(event) {
        this.candidateWords = this.filter5LetterWordleWords();
        this.showCandidateWords = true;

        this.suggestedNextWords = this.getNextSuggestedWords(this.candidateWords);
    }

    onWordLengthWordleChange(event) {

    }

    getNextSuggestedWords(candidateWords) {
        const nextSuggestedWords = calculateNextSuggestedWords(candidateWords);

        return sortWordsByMostUsedToLeastUsed(nextSuggestedWords, this.wordFrequenciesByWord);
    }

    filter5LetterWordleWords() {
        const formInputElement = this.getWordleFilterFormElement();
        const formInput = formInputElement.getFormInput();

        const filtered5LetterWords = filterWordleWords(this.selectedWordLengthWords, formInput.excludedCharacters, formInput.includedCharacterRules);

        return sortWordsByMostUsedToLeastUsed(filtered5LetterWords, this.wordFrequenciesByWord);
    }

    getWordleFilterFormElement() {
        return this.template.querySelector('c-wordle-filter-form');
    }

    loadWordleContext() {
        getAllWordsWithFrequenciesFileContents()
        .then(result => {
            this.parseWordsWithFrequencies(result);

            this.getWordleFilterFormElement().load(this.wordsByWordLength);
        });
    }

    parseWordsWithFrequencies(rawWordsWithFrequenciesString) {
        let wordsWithFrequencyLines = rawWordsWithFrequenciesString.split(NEWLINE);

        console.log(`wordsWithFrequencyLines length: ${wordsWithFrequencyLines.length}`);
        const wordsCount = wordsWithFrequencyLines.length;

        for (let wordLengthIndex = 0; wordLengthIndex < 40; ++wordLengthIndex) {
            this.wordsByWordLength.set(wordLengthIndex, []);
        }

        for (let i = 1; i < wordsCount; ++i) {
            const wordWithFrequencyCommaSeparated = wordsWithFrequencyLines[i];
            const parts = wordWithFrequencyCommaSeparated.split(',');
            const word = parts[0];
            const wordFrequency = parseInt(parts[1]);
            
            const wordLengthWords = this.wordsByWordLength.get(word.length);
            wordLengthWords.push(word);

            this.wordFrequenciesByWord.set(word, wordFrequency);
        }

        for (const wordLength of this.wordsByWordLength.keys()) {
            console.log(`${wordLength} has ${this.wordsByWordLength.get(wordLength).length} words`);
        }
    }
}