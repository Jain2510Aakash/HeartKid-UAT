import { LightningElement,track } from 'lwc';
import leadExtractData from "@salesforce/apex/ExtractDataCls.leadExtract";
//import getMetadataData from "@salesforce/apex/Summary_Cls.getMetadataType";
//import getUserList from "@salesforce/apex/UserProfilesCtrl.userWithProfile";
import updateRecord from "@salesforce/apex/ExtractDataCls.updateSalesforceAssistData";
import getFieldRecord from "@salesforce/apex/InterrogationComponent_Ctrl.getAllTheFieldValues";
import updateFieldRecord from "@salesforce/apex/InterrogationComponent_Ctrl.updateRecords";
import getLeadScoreRecord from "@salesforce/apex/SalesforceAssistScore_Ctrl.getScoreRecords";
import { ShowToastEvent } from 'lightning/platformShowToastEvent'
export default class LeadComponent extends LightningElement {
    @track data = [];
    @track mapData = [];
    @track licenses;
    @track isChecked = false;
    @track isSpinner = false;
    @track isRelation = false;
    @track isBtnDsbl = true;
    @track isLeadBtnDsbl = false;
    @track isRecordTypes = false;
    @track metric = [];
    @track isMetricSpinner = false;
    @track isScoreTable = false;
    @track metadata;
    //@track userList = [];
    @track selectedUser = [];
    @track selectedDistProfiles = [];
    @track isOpenModal = false;
    @track leadStatusData = [];
    @track relationShipObject = [];
    @track recordTypeData = [];
    @track isConverted = false;
    @track viewLeadData = {};
    @track getFieldData;
    @track recordData = [];  
    @track isOpenFieldModal = false;
    @track isOpenEditFieldModal = false;
    @track editFieldRecordId;
    @track objectName = 'Lead';
    @track isQuestionSpinner = false;
    @track isFlowOpen = false;
    @track flowApiName = 'Score_Calculator';
    @track fieldRecordData = [];
    @track scoreData = [];
    @track mergeFieldOption;
    @track isDuplicateRule = false;
    @track isTrigger = false;
    @track isFlow = false;
    @track isValidationRule = false;
    @track leadWithActivities = false;

    connectedCallback()
  {
  // this.handleMetadataRecords();
   //this.handleUserData();
   this.handleGetRecordMethod('Lead');
   this.handleGetLeadScoreRecord('Lead');
  }

    handleExtractData()
    {
        //alert('Extract data');
        this.isSpinner = true;
        this.data = [];
        this.mapData = [];
        this.leadStatusData = [];
        this.relationShipObject = [];
        this.recordTypeData = [];
        leadExtractData()
        .then(result => {
            this.isSpinner = false;
            this.isBtnDsbl = false;
            this.isLeadBtnDsbl = true;
            this.data = result;
            let assistData = {};// this is used for sending data to salesforce object for saving record in database.
            assistData.isLeadConverted = this.data.isConverted;
            assistData.percentageOfActivities = this.data.percentageOfActivities;
            assistData.leadStatus = this.data.leadStatus ? this.data.leadStatus.join(';'):'';
            let automationCount = this.data.flowList ? Number(this.data.flowList.length) : 0;
            automationCount += this.data.isTriggers ? Number(this.data.isTriggers.length) : 0;
            assistData.automationCount = automationCount; // The sum of trigger, flow, and validation length.
            assistData.relatedObject = this.data.relationShipObject ? this.data.relationShipObject.join(';'):'';
            assistData.validationRule = this.data.validationRule ? Number(this.data.validationRule.length) : 0;
            assistData.duplicateRule = this.data.duplicateRulesList ? Number(this.data.duplicateRulesList.length) : 0;
            assistData.recordType = this.data.recordType ? Number(this.data.recordType.length):1;//If record type is does not exist assign 1 as default value.

            if(!this.data.isConverted)
            {
              this.isConverted = true;
            }
            if(!this.data.percentageOfActivities)
            {
              this.leadWithActivities = true;
            }
            if(this.data.leadStatus)
            {
              let count = 0;
              this.data.leadStatus.forEach(element => {
                count++
                this.leadStatusData.push({index:count,value:element});
             });
            }
            if(this.data.leadSource)
            {   
              let count = 0;
              let sourceData = [];
                for(let key in this.data.leadSource) 
                {
                  if (Object.hasOwn(this.data.leadSource, key)) 
                  {
                    count++
                    this.mapData.push({index:count,Key:key,value:this.data.leadSource[key]});
                    sourceData.push(key);
                   }
                }
                assistData.leadSource =  sourceData.join(';');
            }
            if(!this.data.relationShipObject)
            {
                this.isRelation = true;
            }
            else
            {
              let count = 0;
              this.data.relationShipObject.forEach(element => {
                count++
                this.relationShipObject.push({index:count,value:element});
              });
            }
            //Check if flows is here or not.
            if(!this.data.flowList)
            {
                this.isFlow = true;
            }
            // Check If validaiton is here or not.
            if(!this.data.validationRule)
            {
                this.isValidationRule = true;
            } 
            //Check if trigger is here or not.
            if(this.data.isTriggers)
            {
                this.isTrigger = false;
                this.data.isTriggers.forEach(element => {
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
            if(!this.data.recordType)
            {
                this.isRecordTypes = true;
            }
            else
            {
              let count = 0;
              this.data.recordType.forEach(element => {
                count++
                this.recordTypeData.push({index:count,value:element});
              });
            }

            this.handleUpdateRecord(assistData);
            console.log('Result', JSON.stringify(this.data));
            console.log('mapdata==>',JSON.stringify(this.mapData));
        })
        .catch(error => {
            this.isSpinner = false;
            console.error('Error:', error);
        });

    }

    handleUpdateRecord(recordData)
    {
       let salesforceAssistData = {
        Lead_Q_1__c: recordData.percentageOfActivities,
        Lead_Q_2__c:recordData.leadStatus,
        Lead_Q_3__c:recordData.isLeadConverted,
        Lead_Q_4__c:recordData.leadSource,
        Lead_Q_5__c:recordData.relatedObject,
        Lead_Q_6__c:recordData.recordType,
        Lead_Q_7__c:recordData.duplicateRule,
        Lead_Q_8__c:recordData.automationCount,
        Lead_Q_9__c:recordData.validationRule
      }
      //Call apex method to update data in Salesforce assist object.
      updateRecord({salesAssistData:salesforceAssistData,objectType:'Lead'})
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

    handleSaveRecordEvent(event)
    {
        this.fieldRecordData = event.detail.recordData;
    }

    handleRefresh()
    {
        this.data = [];
        this.mapData = [];
        this.licenses;
        this.isChecked = false;
        this.isSpinner = false;
        this.isRelation = false;
        this.isBtnDsbl = true;
        this.isLeadBtnDsbl = false;
        this.isRecordTypes = false;
        this.metric = [];
        this.isMetricSpinner = false;
        this.isScoreTable = false;
        this.metadata;
        this.fields = {
            progress: 'Mail Chimp',
            bsprocesses: '',
            isTeamMembers: false,
            members: ''
        };
        //this.userList = [];
        this.selectedDistProfiles = [];
        this.selectedUser = [];
        this.leadStatusData = [];
        this.relationShipObject = [];
        this.recordTypeData = [];
        this.isConverted = false;
        this.viewLeadData = {};
        this.handleExtractData();
        //this.handleMetadataRecords();
        //this.handleUserData();
        this.handleGetRecordMethod('Lead');
    }

    handlScoreMethod()
    {
      if(this.data.length === 0)
      {
          alert('Please click on the extract button before checking the score.');
      }
      else
      {
        this.isFlowOpen = true;
      }
    }

    // handleMetadataRecords()
    // {
    //   getMetadataData()
    //       .then(result => {
    //           this.metadata = result;
    //           console.log('metadata=>',result);
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
    //              // console.log('Profile Name :', element.Profile.Name);
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
      if(this.data.leadSource)
      {
        this.isOpenModal = true;
        this.viewLeadData = {
          staticFieldValue: this.data,
          dynamicFieldValue: this.getFieldData
        }

        const event = new CustomEvent("leaddata", {
          //detail: {key:'Lead',leadData:this.viewLeadData}
          detail: {leadData:this.viewLeadData}
        });
        this.dispatchEvent(event);
        //console.log('view lead data==>',this.viewLeadData);
      }
      else
      {
        alert('Please click exract lead button for creating diagram!');
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
        this.handleGetRecordMethod('Lead');
      }
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

     handleGetLeadScoreRecord(objectName)
     {
      getLeadScoreRecord({objectName:objectName})
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
                this.scoreData.push({'Id':'001LEAD','Scoring_Rule_Name__c':'Total Score','Output__c':total}); 
                console.log('score data->'+JSON.stringify(this.scoreData));
            })
            .catch(error => {
                // TODO Error handling
                console.log('get field error=>',error);
            });
     }

     handleDeleteRecord()
     {
        this.handleGetRecordMethod('Lead');
     }

     handleEditRecord(event)
     {
      const recordId = event.detail.recordId;
      console.log('recordId=>'+recordId);
      this.editFieldRecordId = recordId;
      this.isOpenEditFieldModal = event.detail.isModal;
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
                  this.handleGetRecordMethod('Lead');
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

     handleAddField()
     {
      this.isOpenFieldModal = true;
     }

     handleStatusChange(event)
     {
       console.log('Status=>',event.detail.status)
        if (event.detail.status === "FINISHED_SCREEN") 
        {
          this.isFlowOpen = false;
          this.isScoreTable = true;
          this.handleGetLeadScoreRecord('Lead');
        }  
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