import { LightningElement,track,api } from 'lwc';
import createFieldRecord from "@salesforce/apex/InterrogationComponent_Ctrl.createFieldRecord";
import getFieldRecord from "@salesforce/apex/InterrogationComponent_Ctrl.getAllTheFieldValues";
import { ShowToastEvent } from 'lightning/platformShowToastEvent'

export default class InterrogationComponent extends LightningElement {
    @track addQuestion = 'slds-show';
    @track addQuestionWithType = 'slds-hide';
    @track otherSectionShowHide = 'slds-show';
    @track picklistSectionShowHide = false;
    @track nextBtnHideShow = 'slds-show'; // Next button would be hide and show by using this class.
    @track btnHideShow = 'slds-hide'; //Previouse and Save button would be hide and show by using this class.
    @api isModalOpen = false;
    @track getFieldData;
    @track isSaveDsbl = false;
    @api sObjectName;
    @track lookupHideShow = 'slds-hide';
    @track dataTypeWithObject = {
        dataType:'text',
        objectType:'',
        label:'',
        pickValue:''  
    }
    get objectOptions()
    {
        return [
            { label: 'Lead', value: 'Lead' },
            { label: 'Account', value: 'Account' },
            { label: 'Contact', value: 'Contact' },
            { label: 'Opportunity', value: 'Opportunity' },
        ];
    }

    connectedCallback()
    {
        //this.handleGetRecordMethod('Lead');
        console.log('object Name=>'+this.sObjectName);
        console.log('is open modal=>'+this.isModalOpen);
        this.dataTypeWithObject.objectType = this.sObjectName;
    }
     
    //  openModal() {
    //      // to open modal set isModalOpen tarck value as true
    //      this.isModalOpen = true;
    //  }

     closeModal() {
         // to close modal set isModalOpen tarck value as false
         const event = new CustomEvent("close", {
            detail: false
        });
        this.dispatchEvent(event);

        this.addQuestion = 'slds-show';
        this.picklistSectionShowHide = 'slds-hide';
        this.otherSectionShowHide = 'slds-hide';
        this.addQuestionWithType = 'slds-hide'; 
        this.nextBtnHideShow = 'slds-show';
        this.btnHideShow = 'slds-hide';
        this.dataTypeWithObject = {
            dataType:'text',
            objectType:'',
            label:'',
            pickValue:''  
        };
     }

     handleNext()
     {
         // to close modal set isModalOpen tarck value as false
         //Add your code to call apex method or do some processing
         //this.isModalOpen = false;
         this.nextBtnHideShow = 'slds-hide';
         this.btnHideShow = 'slds-show';
         this.addQuestion = 'slds-hide';
         this.addQuestionWithType = 'slds-show';
         if(this.dataTypeWithObject.dataType === 'Picklist' || this.dataTypeWithObject.dataType === 'Picklist (Multi-Select)')
        {
            this.otherSectionShowHide = 'slds-hide';
            this.picklistSectionShowHide = 'slds-show';
        }
        else
        {
            this.picklistSectionShowHide = 'slds-hide';
            this.otherSectionShowHide = 'slds-show';
        }
     }

     handlePrev()
     {
        this.addQuestion = 'slds-show';
        this.addQuestionWithType = 'slds-hide';
        this.nextBtnHideShow = 'slds-show';
        this.btnHideShow = 'slds-hide';
        this.picklistSectionShowHide = 'slds-hide';
        this.otherSectionShowHide = 'slds-hide';
        this.dataTypeWithObject.pickValue = '';
     }

     handleSubmit()
     {
        //alert('submit btn');
        let pettern = /^[a-zA-Z0-9]+(?: [a-zA-Z0-9]+)*;(?:[a-zA-Z0-9]+(?: [a-zA-Z0-9]+)*)(?:;[a-zA-Z0-9]+(?: [a-zA-Z0-9]+)*)*$/;
        const inputFields = this.template.querySelectorAll('.validate');
        let isValid = true;

        inputFields.forEach((field) => {
            if (field.required && !field.value) {
              field.setCustomValidity(field.messageWhenValueMissing);
              field.reportValidity();
              isValid = false;
            } 
            else {
                console.log('Field Label=>',field.label);
                if(field.name === 'picklist')
                {
                    console.log('Field value=>',field.value);
                    if(field.required && pettern.test(field.value))
                    {
                        field.setCustomValidity('');
                        field.reportValidity();
                    }
                    else
                    {
                        field.setCustomValidity('Input must be alphanumeric characters, possibly with spaces within words, separated by semicolons with no spaces immediately after the semicolon.');
                        field.reportValidity();
                        isValid = false;
                    }
                    
                }
                else
                {
                    field.setCustomValidity('');
                    field.reportValidity();
                }
              
            }
          });
          //console.log('isvalid value==>',isValid);
          if (isValid)
            {
                this.isSaveDsbl = true;
              let interrogationData = {
                Label__c: this.dataTypeWithObject.label,
                Object_Type__c: this.dataTypeWithObject.objectType,
                Pick_Values__c: this.dataTypeWithObject.pickValue,
                DataType__c	: this.dataTypeWithObject.dataType
            } ;    
            console.log('interrogation data=>',JSON.stringify(interrogationData));
            this.handleApexMethod(interrogationData);
            }
        }

     handleApexMethod(interData)
     {
        createFieldRecord({interrogationData:interData})
        .then(result => {
            if(result === 'Success')
            {
                this.handleGetRecordMethod('Lead');
                let msg = 'Record is created successfully.';
                this.showSuccessToast(msg);
            }
            else if(result === 'Error')
            {
                let msg = 'Record is not created. Please try again!';
                this.showErrorToast(msg);
            } 
            this.closeModal();
        })
        .catch(error => {
            // TODO Error handling
            this.closeModal();
            //let msg = 'Record is not created. Please try again!';
            this.showErrorToast(error.body.message);
        });
     }
    
     handleGetRecordMethod(args)
     {
        getFieldRecord({sObjectName:args})
            .then(result => {
                console.log('result->'+JSON.stringify(result));
                this.getFieldData = result;
                console.log('get field record=>',JSON.stringify(this.getFieldData));
            })
            .catch(error => {
                // TODO Error handling
                console.log('get field error=>',error);
            });
     }

     handleInputs(event)
     {
         const name = event.currentTarget.dataset.field;
         console.log('name==>',name,'value==>',event.target.value);
         if(event.currentTarget.dataset.field === 'picklist')
        {
            console.log('picklist value==>',event.target.value);
            this.picklistSectionShowHide = true;
            this.dataTypeWithObject.dataType = event.target.value;
        }
        else if(event.currentTarget.dataset.field === 'multi_picklist')
        {
            console.log('multi picklist value==>',event.target.value);
            this.picklistSectionShowHide = true;
            this.dataTypeWithObject.dataType = event.target.value;
        }
        else if(event.currentTarget.dataset.field === 'text')
        {
            console.log('multi picklist value==>',event.target.value);
            this.picklistSectionShowHide = false;
            this.dataTypeWithObject.dataType = event.target.value;
        }
        else if(event.currentTarget.dataset.field === 'number')
        {
            console.log('multi picklist value==>',event.target.value);
            this.picklistSectionShowHide = false;
            this.dataTypeWithObject.dataType = event.target.value;
        }
        else if(event.currentTarget.dataset.field === 'checkbox')
        {
            console.log('multi picklist value==>',event.target.value);
            this.picklistSectionShowHide = false;
            this.dataTypeWithObject.dataType = event.target.value;
        }
        else if(event.currentTarget.dataset.field === 'label')
            {
                this.dataTypeWithObject[event.currentTarget.dataset.field] = event.target.value;
            }
        else if(event.currentTarget.dataset.field === 'pickValue')
            {
                this.dataTypeWithObject[event.currentTarget.dataset.field] = event.target.value;
            }
        else if(event.currentTarget.dataset.field === 'objectType')
        {
            this.dataTypeWithObject[event.currentTarget.dataset.field] = event.target.value;
        }
        console.log('data Tpe with object=>',JSON.stringify(this.dataTypeWithObject));
     }

    showSuccessToast(msg) {
        const event = new ShowToastEvent({
            //title: 'Toast message',
            message: msg,
            variant: 'success',
            mode: 'dismissable'
        });
        this.dispatchEvent(event);
    }
  
    showErrorToast(errorMsg) {
        const evt = new ShowToastEvent({
            //title: 'Toast Error',
            message: errorMsg,
            variant: 'error',
            mode: 'dismissable'
        });
        this.dispatchEvent(evt);
    }
}