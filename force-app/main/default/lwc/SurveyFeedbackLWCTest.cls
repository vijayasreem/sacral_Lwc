// Unit Test 1:

import { createElement } from 'lwc';
import SurveyFeedback from 'c/surveyFeedback';

describe('c-survey-feedback', () => {
    afterEach(() => {
        // The jsdom instance is shared across test cases in a single file so reset the DOM
        while (document.body.firstChild) {
            document.body.removeChild(document.body.firstChild);
        }
    });

    it('calls getSurveyQuestion on connectedCallback', () => {
        // Create initial element
        const element = createElement('c-survey-feedback', {
            is: SurveyFeedback
        });
        document.body.appendChild(element);
        // Mock getSurveyQuestion
        const getSurveyQuestion = jest.fn();
        element.getSurveyQuestion = getSurveyQuestion;

        // Trigger connectedCallback
        const connectedCallback = jest.fn();
        element.connectedCallback(connectedCallback);

        // Validate if getSurveyQuestion is called
        expect(getSurveyQuestion).toHaveBeenCalled();
    });
});

// Unit Test 2:

import { createElement } from 'lwc';
import SurveyFeedback from 'c/surveyFeedback';

describe('c-survey-feedback', () => {
    afterEach(() => {
        // The jsdom instance is shared across test cases in a single file so reset the DOM
        while (document.body.firstChild) {
            document.body.removeChild(document.body.firstChild);
        }
    });

    it('handles the selection of answer', () => {
        // Create initial element
        const element = createElement('c-survey-feedback', {
            is: SurveyFeedback
        });
        document.body.appendChild(element);
        // Mock handleAnswerSelect
        const handleAnswerSelect = jest.fn();
        element.handleAnswerSelect = handleAnswerSelect;

        // Trigger the selection of an answer
        const event = {
            detail: {
                questionId: '1',
                answerId: '2'
            }
        };
        element.handleAnswerSelect(event);

        // Validate if handleAnswerSelect is called
        expect(handleAnswerSelect).toHaveBeenCalled();
    });
});