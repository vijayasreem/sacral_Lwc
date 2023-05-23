// Unit Tests
import { createElement } from 'lwc';
import SurveyFeedback from 'c/surveyFeedback';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getQuestions from '@salesforce/apex/SurveyQuestionsController.getQuestions';
import saveResponse from '@salesforce/apex/SurveyQuestionsController.saveResponse';

describe('SurveyFeedback', () => {
    let element;

    beforeEach(() => {
        element = createElement('c-survey-feedback', {
            is: SurveyFeedback
        });
        document.body.appendChild(element);
    });

    afterEach(() => {
        while (document.body.firstChild) {
            document.body.removeChild(document.body.firstChild);
        }
    });

    it('should render correct elements', () => {
        const questions = element.shadowRoot.querySelector('lightning-record-edit-form');
        expect(questions).not.toBeNull();
    });

    it('should call apex method getQuestions', () => {
        let recordId = '123';
        let getQuestionsCalled = false;
        getQuestions = jest.fn().mockImplementation(() => {
            getQuestionsCalled = true;
            return Promise.resolve([]);
        });

        element.recordId = recordId;
        element.connectedCallback();
        expect(getQuestionsCalled).toBe(true);
    });

    it('should call apex method saveResponse', () => {
        let recordId = '123';
        let selectedAnswers = [{
            questionId: '1',
            answerId: '2'
        }];
        let saveResponseCalled = false;
        saveResponse = jest.fn().mockImplementation(() => {
            saveResponseCalled = true;
            return Promise.resolve();
        });

        element.recordId = recordId;
        element.selectedAnswers = selectedAnswers;
        element.handleSubmit();
        expect(saveResponseCalled).toBe(true);
    });

    it('should show toast message on error', () => {
        let title = 'ERROR';
        let message = 'An error occurred';
        let variant = 'error';
        let showToastCalled = false;
        element.showToast = jest.fn().mockImplementation(() => {
            showToastCalled = true;
        });

        element.showToast(title, message, variant);
        expect(showToastCalled).toBe(true);
    });

});