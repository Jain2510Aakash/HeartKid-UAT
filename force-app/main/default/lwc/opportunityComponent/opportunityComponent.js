import { LightningElement,track } from 'lwc';
//import opportunityWithProducts from "@salesforce/apex/ExtractDataCls.opportunityWithProducts";
import opporunityExtract from "@salesforce/apex/ExtractDataCls.opporunityExtract";
//import getMetadataData from "@salesforce/apex/Summary_Cls.getMetadataType";
//import getUserList from "@salesforce/apex/UserProfilesCtrl.userWithProfile";
import updateRecord from "@salesforce/apex/ExtractDataCls.updateSalesforceAssistData";
import getFieldRecord from "@salesforce/apex/InterrogationComponent_Ctrl.getAllTheFieldValues";
import updateFieldRecord from "@salesforce/apex/InterrogationComponent_Ctrl.updateRecords";
import getOpportunityScoreRecord from "@salesforce/apex/SalesforceAssistScore_Ctrl.getScoreRecords";
import { ShowToastEvent } from 'lightning/platformShowToastEvent'
export default class OpportunityComponent extends LightningElement {

    @track opportunityData = [];
    @track isOpportunity = true;
    @track isValidationRule = false;
    @track isTrigger = false;
    @track isSpinner = false;
    @track isFlow = false;
    @track isOppBtnDsbl = false;
    @track isBtnDsbl = true;
    @track isRelation = false;
    @track isRecordTypes = false;
    @track metric = [];
    @track isMetricSpinner = false;
    @track isScoreTable = false;
    @track metadata;
    //@track userList = [];
    @track selectedUser = [];
    @track selectedDistProfiles = [];
    @track oppStagesData = [];
    @track relationShipObject = [];
    @track recordTypeData = [];
    @track viewOpportunityData = {};
    @track isOpenModal = false;
    @track isOpenFieldModal = false;
    @track objectName = 'Opportunity';
    @track getFieldData;
    @track isOpenEditFieldModal = false;
    @track editFieldRecordId;
    @track fieldRecordData = [];
    @track flowApiName = 'Opportunity_Score_Calculator';
    @track isFlowOpen = false;
    @track scoreData = [];
    @track isDuplicateRule = false;
    @track pageLayoutData = [];
    @track isPageLayout = false;
    @track oppWithActivity = false;

    connectedCallback()
    {
      //this.handleMetadataRecords();
      //this.handleUserData();
      this.handleGetRecordMethod('Opportunity');
      this.handleGetOpportunityScoreRecord('Opportunity');
    }
  
    handleGetAllOpportunityWithProduct()
    {
      this.isSpinner = true;
      this.opportunityData = [];
      this.oppStagesData = [];
      this.relationShipObject = [];
      this.recordTypeData = [];
      this.pageLayoutData = [];
        opporunityExtract()
          .then(result => {   
            this.isSpinner = false; 
            this.isBtnDsbl = false;
            this.isOppBtnDsbl = true;
            this.opportunityData = JSON.parse(JSON.stringify(result));
            let assistData = {};// this is used for sending data to salesforce object for saving record in database.
            console.log('Opportunity Result', result);
            console.log('data=>', JSON.stringify(this.opportunityData));
            assistData.percentageOfOpporunity = this.opportunityData.percentageOfOpporunity ? this.opportunityData.percentageOfOpporunity : 0;
            assistData.percentageOfActivities = this.opportunityData.percentageOfActivities ? this.opportunityData.percentageOfActivities : 0;
            assistData.validationRule = this.opportunityData.validationRule ? Number(this.opportunityData.validationRule.length) : 0;
            assistData.flow = this.opportunityData.flowList ? Number(this.opportunityData.flowList.length) : 0;
            assistData.recordType = this.opportunityData.recordType ? Number(this.opportunityData.recordType.length) : 0;
            assistData.stages = this.opportunityData.opportunityStages ? this.opportunityData.opportunityStages.join(';') : '';
            assistData.trigger = this.opportunityData.isTriggers ? Number(this.opportunityData.isTriggers.length) : 0;
            assistData.relatedObject = this.opportunityData.relationShipObject ? this.opportunityData.relationShipObject.join(';') : '';
            assistData.duplicateRule = this.opportunityData.duplicateRulesList ? Number(this.opportunityData.duplicateRulesList.length) : 0;
            assistData.pageLayout = this.opportunityData.pageLayoutList ? Number(this.opportunityData.pageLayoutList.length) : 0;
            
            if(this.opportunityData.percentageOfOpporunity === 0)
            {
              this.isOpportunity = false;
            }
            if(!this.opportunityData.percentageOfActivities)
              {
                this.oppWithActivity = true;
              }
            if(this.opportunityData.opportunityStages)
            {
              let count = 0;
              this.opportunityData.opportunityStages.forEach(element => {
                count++
                this.oppStagesData.push({index:count,value:element});
             });
            }
            //Check if trigger is here or not.
            if(this.opportunityData.isTriggers)
            {
                this.isTrigger = false;
                this.opportunityData.isTriggers.forEach(element => {
                  if(element.CreatedBy)
                  {
                    element.CreatedByName = element.CreatedBy.Name
                    console.log('created by :', element.CreatedBy.Name);
                  }
                });
            }
            else
            {
              this.isTrigger = true;
            }
            //Check if flows is here or not.
            if(!this.opportunityData.flowList)
            {
                this.isFlow = true;
            }
            // Check If validaiton is here or not.
            if(!this.opportunityData.validationRule)
            {
                this.isValidationRule = true;
            }

            if(!this.opportunityData.relationShipObject)
            {
                this.isRelation = true;
            }
            else
            {
              let count = 0;
              this.opportunityData.relationShipObject.forEach(element => {
                count++
                this.relationShipObject.push({index:count,value:element});
              });
            }
            if(!this.opportunityData.recordType)
            {
                this.isRecordTypes = true;
            }
            else
            {
              let count = 0;
              this.opportunityData.recordType.forEach(element => {
                count++
                this.recordTypeData.push({index:count,value:element.Name});
              });
            }
            //Check if, Is there any duplicate rules related to the object or not.
            if(this.opportunityData.duplicateRulesList)
            {
                this.isDuplicateRule = false;
                this.opportunityData.duplicateRulesList.forEach(element => {
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
            //Check If page layout are there or not.
            if(!this.opportunityData.pageLayoutList)
            {
                this.isPageLayout = true;
            }
            else
            {
              let count = 0;
              this.opportunityData.pageLayoutList.forEach(element => {
                count++
                this.pageLayoutData.push({index:count,value:element.name});
              });
              console.log('Page Layout=>',JSON.stringify(this.pageLayoutData));
            }

            this.handleUpdateRecord(assistData);
            console.log('data modified=>', JSON.stringify(this.opportunityData));
            //console.log('mapdata==>',JSON.stringify(this.mapData));
            
          })
          .catch(error => {
            this.isSpinner = false;
            console.error('Error:', error);
        });
    }

    handleRefresh()
    {
      //if(this.opportunityData)
      this.opportunityData = [];
      this.isOpportunity = true;
      this.isValidationRule = false;
      this.isTrigger = false;
      this.isSpinner = false;
      this.isFlow = false;
      this.isBtnDsbl = true;
      this.isOppBtnDsbl = false;
      this.isRecordTypes = false;
      this.metric = [];
      this.isMetricSpinner = false;
      this.isScoreTable = false;
      this.metadata;
      //this.userList = [];
      this.selectedDistProfiles = [];
      this.selectedUser = [];
      this.viewOpportunityData = {};
      this.isOpenModal = false;
      this.isDuplicateRule = false;
      this.isPageLayout = false;
      this.pageLayoutData = [];
      this.handleGetAllOpportunityWithProduct();
      //this.handleMetadataRecords();
      //this.handleUserData();
      this.handleGetRecordMethod('Opportunity');
      this.handleGetOpportunityScoreRecord('Opportunity');
    }

    handleUpdateRecord(recordData)
    {
       let salesforceAssistData = {
        Opportunity_Q_1__c: recordData.percentageOfOpporunity,
        Opportunity_Q_2__c: recordData.percentageOfActivities,
        Opportunity_Q_3__c: recordData.stages,
        Opportunity_Q_4__c: recordData.relatedObject,
        Opportunity_Q_5__c: recordData.recordType,
		    Opportunity_Q_6__c: recordData.flow + recordData.trigger,//The combination of trigger and flow length.
        Opportunity_Q_7__c: recordData.validationRule,
        Opportunity_Q_8__c: recordData.duplicateRule,
        Opportunity_Q_9__c: recordData.pageLayout
      }
      console.log('Salesforce assist data=>',salesforceAssistData);
      //Call apex method to update data in Salesforce assist object.
      updateRecord({salesAssistData:salesforceAssistData,objectType:'Opportunity'})
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

    // handleMetadataRecords()
    // {
    //   getMetadataData()
    //       .then(result => {
    //           this.metadata = result;
    //           console.log('metadata=>',JSON.stringify(this.metadata));
    //           let msg = 'Metadata loaded successfully.'
    //           this.showSuccessToast(msg);
    //       })
    //       .catch(error => {
    //           // TODO Error handling
    //           console.log('metadata error=>',error);
    //           let errorMsg = 'Metadata does not loaded.'
    //           this.showErrorToast(errorMsg);
    //       });
    // }

    // handleUserData()
    // {
    //     getUserList()
    //       .then(result => {
    //           this.userList = JSON.parse(JSON.stringify(result));
    //           console.log('user data result=>',result);
    //           this.userList.forEach(element => {
    //             if(element.Profile)
    //             {
    //               element.ProfileName = element.Profile.Name
    //               console.log('Profile Name :', element.Profile.Name);
    //             }
    //           });
    //           console.log('user data=>',JSON.stringify(this.userList));
    //       })
    //       .catch(error => {
    //           // TODO Error handling
    //           console.log('user data error=>',error);
    //       });
    // }

    handleRowAction(event) {
      this.selectedDistProfiles = [];
      this.selectedUser = [];
      const selectedRows = event.detail.selectedRows;
      //console.log(`Selected Row length ${selectedRows.length} and data ${JSON.stringify(selectedRows)}`);
      if (selectedRows.length > 0) {
          this.selectedUser = selectedRows.map(row => row.Id);
          let userProfiles = selectedRows.map(row => row.ProfileName);
          //console.log('all selected profiles',userProfiles);
          userProfiles.forEach(element => {
              if (!this.selectedDistProfiles.includes(element)) {
                  this.selectedDistProfiles.push(element);
              }
          });
          //console.log('Distinct Profile:',JSON.stringify(this.selectedDistProfiles));
      } else {
          // No rows selected, clear the selectedUserId
          this.selectedDistProfiles = [];
          this.selectedUser = [];
      }
      //console.log('Selcted USer=>',JSON.stringify(this.selectedUser));
      // Fetch and display the profile of the selected user
      // You need to implement this part
  }

  //Open Child Component
  handleOpenModal()
  {
    console.log('opportunityData length=>',Object.keys(this.opportunityData).length);
    if(Object.keys(this.opportunityData).length >0)
    {
      this.isOpenModal = true;
      this.viewOpportunityData = {
        staticFieldValue: this.opportunityData,
        dynamicFieldValue: this.getFieldData
      }

      const event = new CustomEvent("opportunitydata", {
       // detail: {key:'Opportunity',opportunityData: this.viewOpportunityData}
       detail: {opportunityData: this.viewOpportunityData}
      });
      this.dispatchEvent(event);
      //console.log('view lead data==>',this.viewLeadData);
    }
    else
    {
      alert('Please click exract opportunity button!');
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
        this.handleGetRecordMethod('Opportunity');
      }
    
  }

  handleOpportunityField()
  {
   this.isOpenFieldModal = true;
  }

  handleGetRecordMethod(args)
    {
       getFieldRecord({sObjectName:args})
           .then(result => {
               console.log('result->'+JSON.stringify(result));
               this.getFieldData = result;
               console.log('get field record from account=>',JSON.stringify(this.getFieldData));
           })
           .catch(error => {
               // TODO Error handling
               console.log('get field error from account=>',error);
           });
    }

    handleDeleteRecord()
    {
       this.handleGetRecordMethod('Opportunity');
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
                  this.handleGetRecordMethod('Opportunity');
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
      if(this.opportunityData.length === 0)
      {
          alert('Please click on the extract button before checking the score.');
      }
      else
      {
        this.isFlowOpen = true;
      }
    }

    handleStatusChange(event)
     {
       console.log('Status=>',event.detail.status)
        if (event.detail.status === "FINISHED_SCREEN") 
        {
          this.isFlowOpen = false;
          this.isScoreTable = true;
          this.handleGetOpportunityScoreRecord('Opportunity');
        }  
     }

     handleGetOpportunityScoreRecord(objectName)
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
                this.scoreData.push({'Id':'001OPP','Scoring_Rule_Name__c':'Total Score','Output__c':total}); 
                console.log('score data->'+JSON.stringify(this.scoreData));
            })
            .catch(error => {
                // TODO Error handling
                console.log('get field error=>',error);
            });
     }

    showSuccessToast(msg) {
      const event = new ShowToastEvent({
          title: 'Toast message',
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