import { LightningElement, api, track } from 'lwc';
import getSurveyQuestion from '@salesforce/apex/SurveyQuestionController.getSurveyQuestion';
import saveSurveyResponse from '@salesforce/apex/SurveyQuestionController.saveSurveyResponse';

export default class SurveyFeedback extends LightningElement {
    @track surveyQuestions;
    @track surveyResponses = [];
    @api surveyId;

    // Retrieve survey questions from server
    connectedCallback() {
        getSurveyQuestion({ surveyId: this.surveyId })
            .then(result => {
                this.surveyQuestions = result;
            })
            .catch(error => {
                console.log('error', error);
            });
    }

    // Handle selection of answer
    handleAnswerSelect(event) {
        const questionId = event.detail.questionId;

        // Find the response for the question
        let response = this.surveyResponses.find(response => response.Question__c === questionId);
        if (!response) {
            // If the response is not found, create a new one
            response = { Question__c: questionId };
            this.surveyResponses.push(response);
        }

        // Store the answer
        response.Answer__c = event.detail.answerId;
    }

    // Handle submission of survey
    handleSurveySubmit() {
        saveSurveyResponse({ surveyResponses: this.surveyResponses })
            .then(result => {
                console.log('Survey response saved', result);
            })
            .catch(error => {
                console.log('error', error);
            });
    }
}