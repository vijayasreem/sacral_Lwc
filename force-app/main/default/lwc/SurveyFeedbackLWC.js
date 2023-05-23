.

import { LightningElement, track, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getQuestions from '@salesforce/apex/SurveyQuestionsController.getQuestions';
import saveResponse from '@salesforce/apex/SurveyQuestionsController.saveResponse';

export default class SurveyFeedback extends LightningElement {
    @api recordId;
    @track questions;
    @track selectedAnswers = [];
    @track surveyCompleted = false;

    connectedCallback() {
        getQuestions({
            surveyId: this.recordId
        })
        .then(result => {
            this.questions = result;
        })
        .catch(error => {
            this.showToast('ERROR', error.body.message, 'error');
        });
    }

    handleSelection(event) {
        const questionId = event.detail.questionId;
        const answerId = event.detail.answerId;
        const selectedAnswer = {
            questionId,
            answerId
        };

        this.selectedAnswers = [...this.selectedAnswers, selectedAnswer];
    }

    handleSubmit() {
        saveResponse({
            surveyId: this.recordId,
            selectedAnswers: this.selectedAnswers
        })
        .then(() => {
            this.showToast('SUCCESS', 'Survey response saved successfully', 'success');
            this.surveyCompleted = true;
        })
        .catch(error => {
            this.showToast('ERROR', error.body.message, 'error');
        });
    }

    showToast(title, message, variant) {
        const evt = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant,
        });
        this.dispatchEvent(evt);
    }

}