import { LightningElement, track, api } from 'lwc';
import { getAllLowercaseEnglishLetters } from 'c/wordUtil';
import MailingPostalCode from '@salesforce/schema/Contact.MailingPostalCode';

export default class WordleFilterForm extends LightningElement {
    excludedCharacters = '';
    @track includedCharacters = [];
    wordsByWordLength = new Map();
    selectedWordLength;

    get availableWordLengthsOptions() {
        let opts = [];

        for (const wordLength of this.wordsByWordLength.keys()) {
            const words = this.wordsByWordLength.get(wordLength);

            if (wordLength > 1 &&
                wordLength < 16 &&
                words.length > 0) {
                opts.push({
                    label: wordLength,
                    value: wordLength
                });
            }

        }

        return opts;
    }

    get englishCharacterOptions() {
        const aToZChars = [];

        for (const lowerCaseEnglishLetter of getAllLowercaseEnglishLetters()) {
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
        const opts = [];
        for (let i = 1; i <= this.selectedWordLength; ++i) {
            opts.push({
                label: "Letter " + i,
                value: i.toString()
            });
        }

        return opts;
    }

    @api getFormInput() {
        const formInput = {
            "excludedCharacters": this.excludedCharacters
        };

        formInput.includedCharacterRules = [];

        for (const includedCharacter of this.includedCharacters) {
            if (!includedCharacter.character ||
                !includedCharacter.isOrIsNot ||
                !includedCharacter.letterPosition) {

                continue;
            }

            formInput.includedCharacterRules.push({
                Character: includedCharacter.character,
                Position:  parseInt(includedCharacter.letterPosition) - 1,
                ExactLocation: includedCharacter.isOrIsNot === 'is'
            });
        }

        return formInput;
    }

    @api getSelectedWordLength() {
        return this.selectedWordLength;
    }

    @api load(wordsByWordLengthArg, defaultSelectedWordLength = 5) {
        this.wordsByWordLength = wordsByWordLengthArg;
        this.selectedWordLength = defaultSelectedWordLength;
    }

    connectedCallback() {
        this.addIncludedCharacterRow();
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

    onDeleteIncludedCharacterRow(event) {
        this.deleteIncludedRowAt(event.currentTarget.value);

        // Reset the remaining row indices.
        for (let i = 0; i < this.includedCharacters.length; ++i) {
            let includedCharacter = this.includedCharacters[i];

            includedCharacter.index = i;
        }
    }

    deleteIncludedRowAt(index) {
        this.includedCharacters.splice(index, 1);
    }

    addIncludedCharacterRow() {
        this.includedCharacters.push({
            index: this.includedCharacters.length,
            character: '',
            isOrIsNot: 'is not',
            letterPosition: null
        });
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

    onResetClick(event) {
        this.excludedCharacters = '';
        this.includedCharacters = [];

        this.addIncludedCharacterRow();

        this.dispatchEvent(new CustomEvent('reset'));
    }

    fireGetEligibleWordsEvent(event) {
        this.dispatchEvent(new CustomEvent('getwords'));
    }

    onSelectedWordLengthChange(event) {
        this.selectedWordLength = parseInt(event.detail.value);

        this.onResetClick(event);

        this.dispatchEvent(new CustomEvent('wordlengthchanged', { detail: this.selectedWordLength}));
    }
}