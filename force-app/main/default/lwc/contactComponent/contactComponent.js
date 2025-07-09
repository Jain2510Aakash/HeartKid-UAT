import { LightningElement,track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent'
import getContactData from "@salesforce/apex/ExtractContactDataCls.extractContact";
import updateRecord from "@salesforce/apex/ExtractDataCls.updateSalesforceAssistData";
//import getMetadataData from "@salesforce/apex/Summary_Cls.getMetadataType";
import getFieldRecord from "@salesforce/apex/InterrogationComponent_Ctrl.getAllTheFieldValues";
import updateFieldRecord from "@salesforce/apex/InterrogationComponent_Ctrl.updateRecords";
import getOpportunityScoreRecord from "@salesforce/apex/SalesforceAssistScore_Ctrl.getScoreRecords";
export default class ContactComponent extends LightningElement {
    @track data = [];
    @track isRelation = false;
    @track isSpinner = false;
    @track isBtnDsbl = true;
    @track isContBtnDsbl = false;
    @track isRecordTypes = false;
    @track isTrigger = false;
    @track isDuplicateRule = false;
    @track isPageLayout = false;
    @track metric = [];
    @track isMetricSpinner = false;
    @track isScoreTable = false;
    @track metadata;
    @track relationShipObject = [];
    @track recordTypeData = [];
    @track pageLayoutData = [];
    @track isOpenModal = false;
    @track isOpenFieldModal = false;
    @track objectName = 'Contact';
    @track getFieldData;
    @track isOpenEditFieldModal = false;
    @track editFieldRecordId;
    @track fieldRecordData = [];
   @track flowApiName = 'Contact_Score_Calculator';
    @track isFlowOpen = false;
    @track scoreData = [];
    @track isValidationRule = false;
    @track isFlow = false;
    @track isPercentageOfActivities = false;

   connectedCallback()
   {
        //this.handleMetadataRecords();
        this.handleGetRecordMethod('Contact');
        this.handleGetContactScoreRecord('Contact');
   }

    handleApexMethod()
    {
        this.isSpinner = true;
        this.data = [];
        this.relationShipObject = [];
        this.recordTypeData = [];
        this.pageLayoutData = [];
        getContactData()
        .then(result => {
            this.isSpinner = false;
            this.data = JSON.parse(JSON.stringify(result));
            this.isBtnDsbl = false;
            this.isAccBtnDsbl = true;
            let assistData = {};// this is used for sending data to salesforce object for saving record in database.
            console.log('Contact data=>',result);
            assistData.percentageOfActivities = this.data.percentageOfActivities ? this.data.percentageOfActivities:0;
            if(!this.data.percentageOfActivities)
            {
              this.isPercentageOfActivities = true;
            }
            //Check if child object is exist or not.
            if(!this.data.relationShipObjectList)
            {
                this.isRelation = true;
            }
            else
            {
              let count = 0;
              this.data.relationShipObjectList.forEach(element => {
                count++
                this.relationShipObject.push({index:count,value:element});
              });
              assistData.relatedObject = this.data.relationShipObjectList.join(';');
              console.log('Custom object=>',JSON.stringify(this.relationShipObject));
            }
            assistData.recordType = this.data.recordTypeList ? Number(this.data.recordTypeList.length) : 0;
            //Check If record type are there or not.
            if(!this.data.recordTypeList)
            {
                this.isRecordTypes = true;
            }
            else
            {
              let count = 0;
              this.data.recordTypeList.forEach(element => {
                count++
                this.recordTypeData.push({index:count,value:element.Name});
              });
              console.log('record Type =>',JSON.stringify(this.recordTypeData));
            }

            assistData.automationCount = this.data.flowList ? Number(this.data.flowList.length) : 0;
            //Check if flows is here or not.
            if(!this.data.flowList)
            {
                this.isFlow = true;
            }
            assistData.automationCount += this.data.triggersList ? Number(this.data.triggersList.length) : 0;
            //Check if, Is there any apex trigger related to the object.
            if(this.data.triggersList)
            {
                this.isTrigger = false;
                this.data.triggersList.forEach(element => {
                    if(element.CreatedBy)
                    {
                      element.CreatedByName = element.CreatedBy.Name
                    //   console.log('created by :', element.CreatedBy.Name);
                    }
                  });
            }
            else
            {
                this.isTrigger = true;
            }
            assistData.validation = this.data.validationRule ? Number(this.data.validationRule.length) : 0;
            // Check If validaiton is here or not.
            if(!this.data.validationRule)
            {
                this.isValidationRule = true; 
            }
            assistData.pageLayout = this.data.pageLayoutList ? Number(this.data.pageLayoutList.length) : 0;
            //Check If page layout are there or not.
            if(!this.data.pageLayoutList)
            {
                this.isPageLayout = true;
            }
            else
            {
              let count = 0;
              this.data.pageLayoutList.forEach(element => {
                count++
                this.pageLayoutData.push({index:count,value:element.name});
              });
              console.log('Page Layout=>',JSON.stringify(this.pageLayoutData));
            }
            assistData.duplicateRule = this.data.duplicateRulesList ? Number(this.data.duplicateRulesList.length) : 0;
            //Check if, Is there any duplicate rules related to the object or not.
            if(this.data.duplicateRulesList)
            {
                this.isDuplicateRule = false;
                this.data.duplicateRulesList.forEach(element => {
                    if(element.CreatedBy)
                    {
                      element.CreatedByName = element.CreatedBy.Name
                    //   console.log('created by :', element.CreatedBy.Name);
                    }
                  });
            }
            else
            {
                this.isDuplicateRule = true;
            }
            this.handleUpdateRecord(assistData);
            console.log('json data of contact=>',JSON.stringify(this.data));
        })
        .catch(error => {
            this.isSpinner = false;
            // TODO Error handling
        });
    }  

    handleUpdateRecord(recordData)
    {
       let salesforceAssistData = {
        Contact_Q_1__c: recordData.relatedObject,
        Contact_Q_2__c:recordData.recordType,
        Contact_Q_3__c:recordData.pageLayout,
        Contact_Q_4__c:recordData.duplicateRule,
        Contact_Q_5__c:recordData.automationCount,
        Contact_Q_6__c:recordData.validation,
        Contact_Q_7__c:recordData.percentageOfActivities
      }
      //Call apex method to update data in Salesforce assist object.
      updateRecord({salesAssistData:salesforceAssistData,objectType:'Contact'})
          .then(result => {
            let msg;
              if(result === 'Inserted')
                {
                  msg = 'Inserted Successful.'
                }
              else if(result === 'Updated')
                {
                  msg = 'Updated Successful.'
                }
              this.showSuccessToast(msg);
          })
          .catch(error => {
              // TODO Error handling
              let errorMsg = 'Record not updated/inserted. Something went wrong!'
              this.showErrorToast(errorMsg);
          });
    
    }

    handleRefresh()
    {
        this.data = [];
        this.isSpinner = true;
        this.isBtnDsbl = false;
        this.isContBtnDsbl = true;
        this.isRelation = false;
        this.isRecordTypes = false;
        this.isTrigger = false;
        this.isPageLayout = false;
        this.isPercentageOfActivities = false;
        this.isValidationRule = false;
        this.isFlow = false;
        this.handleApexMethod();
        this.handleGetRecordMethod('Contact');
        this.handleGetContactScoreRecord('Contact');
    }

    // handleMetadataRecords()
    // {
    //     getMetadataData()
    //         .then(result => {
    //             this.metadata = result;
    //             console.log('metadata=>',JSON.stringify(this.metadata));
    //             let msg = 'Metadata loaded successfully.'
    //             this.showSuccessToast(msg);
    //         })
    //         .catch(error => {
    //             // TODO Error handling
    //             console.log('metadata error=>',error);
    //             let errorMsg = 'Metadata does not loaded.'
    //             this.showErrorToast(errorMsg);
    //         });
    // }

     //Open Child Component
     handleOpenModal()
     {
         console.log('data length:=>',Object.keys(this.data).length);
         if(Object.keys(this.data).length > 0)
         {
             this.isOpenModal = true;
             this.viewContactData = {
                 staticFieldValue: this.data,
                 dynamicFieldValue: this.getFieldData
             }
 
             const event = new CustomEvent("contactdata", {
                 detail: {contactData:this.viewContactData}
                 });
                 this.dispatchEvent(event);
         }
         else
         {
             alert('Please click on extract button before checking score!');
         } 
     }

     //handle custom event.
     handleCloseModal(event)
     {
       console.log('close modal=>',event.detail);
       this.isOpenModal = event.detail;
       this.isOpenFieldModal = event.detail;
       this.isOpenEditFieldModal = event.detail;
       if(!this.isOpenFieldModal || !this.isOpenEditFieldModal)
       {
         this.handleGetRecordMethod('Contact');
       }
     }

    handleGetRecordMethod(args)
    {
       getFieldRecord({sObjectName:args})
           .then(result => {
               console.log('result->'+JSON.stringify(result));
               this.getFieldData = result;
               console.log('get field record from Contact=>',JSON.stringify(this.getFieldData));
           })
           .catch(error => {
               // TODO Error handling
               console.log('get field error from Contact=>',error);
           });
    }
    handleContactField()
     {
      this.isOpenFieldModal = true;
     }

    handleDeleteRecord()
    {
       this.handleGetRecordMethod('Contact');
    }

    handleEditRecord(event)
    {
     const recordId = event.detail.recordId;
     console.log('recordId=>'+recordId);
     this.editFieldRecordId = recordId;
     this.isOpenEditFieldModal = event.detail.isModal;
    }

    handleSaveRecordEvent(event)
    {
        this.fieldRecordData = event.detail.recordData;
    }

    handleUpdateFieldRecord()
     {
      if(this.fieldRecordData.length > 0)
        {
          this.isSpinner = true;
          updateFieldRecord({interList:this.fieldRecordData})
          .then(result => {
              console.log('result->'+result);
              if(result)
                {
                  this.isSpinner = false;
                  let msg = 'Records saved successfully';
                  this.showSuccessToast(msg);
                  this.fieldRecordData = [];
                  this.handleGetRecordMethod('Contact');
                }
              
          })
          .catch(error => {
              // TODO Error handling
              this.isSpinner = false;
              console.log('error=>',error);
              this.showErrorToast(error.body.message);
          });
        }
        else
        {
          alert('Please change/fill the question values. Before saving the record!');
        }
      
     }

    handlScoreMethod()
    {
      if(Object.keys(this.data).length > 0)
      {
        this.isFlowOpen = true;
      }
      else
      {
        alert('Please click on the extract button before checking the score.');
      }
    }

    handleStatusChange(event)
     {
       console.log('Status=>',event.detail.status)
        if (event.detail.status === "FINISHED_SCREEN") 
        {
          this.isFlowOpen = false;
          this.isScoreTable = true;
          this.handleGetContactScoreRecord('Contact');
        }  
     }

     handleGetContactScoreRecord(objectName)
     {
        getOpportunityScoreRecord({objectName:objectName})
            .then(result => {
                console.log('result->'+JSON.stringify(result));
                this.scoreData = result;
                let totalScore = 0;
                this.scoreData.forEach(element => {
                  if(element.Output__c)
                    {
                      totalScore+=element.Output__c;
                    }
                });
                let total = Math.round(totalScore)+'/'+result.length*10;
                //Adding score into the scoreData variable.
                this.scoreData.push({'Id':'001CONTACT','Scoring_Rule_Name__c':'Total Score','Output__c':total}); 
                console.log('score data->'+JSON.stringify(this.scoreData));
            })
            .catch(error => {
                // TODO Error handling
                console.log('get field error=>',error);
            });
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