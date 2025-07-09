import { LightningElement,track,api } from 'lwc';
import getTriggers from "@salesforce/apex/ExtractDataCls.getTriggers";
import getRecordTypes from "@salesforce/apex/Summary_Cls.getRecordTypeDetails";
import getValidationRules from "@salesforce/apex/Summary_Cls.getValidationRules";
import getApexClasses from "@salesforce/apex/Summary_Cls.getApexClasses";
import getflows from "@salesforce/apex/Summary_Cls.getflows";
import getCustomObject from "@salesforce/apex/Summary_Cls.getCustomObject";
import getAssisData from "@salesforce/apex/Summary_Cls.getSalesforceAssistData";
import getAssisScore from "@salesforce/apex/Summary_Cls.allObjectScore";
export default class SummaryComponent extends LightningElement {
 @track recordTypesData;
 @track visibleRecordType;
 @track totalTriggers;
 @track visibleTriggers;
 @track totalValidation;
 @track visibleValidaiton;
 @track totalApexClass;
 @track visibleApexClass;
 @track totalFlows;
 @track visibleFlows;
 @track totalCustomObject;
 @track visibleCustomObject;
 @track isScore = false;
 @track isOpenModal = false;
 @api allObjectScore;
 @track visibleAllObjectScore;
 @api allObjectData;
 @track aiDiagramData;
 @track isSpinner = false;
 @track leadScore;
 @track accountScore;
 @track contactScore;
 @track opportunityScore;
 @track overAllHealthScore;
 


 connectedCallback()
 {
  console.log('all object scores=>',JSON.stringify(this.allObjectScore));
  console.log('all object Data=>',JSON.stringify(this.allObjectData));
  console.log('is score value=>',this.isScore);
 }

  handleSummary()
  {
      //this.refreshHandle();
      this.isSpinner = true;
      this.handleRecordTypes();
      this.handleTriggerMethod();
      this.handleValidationRule();
      this.handleApexClassMethod();
      this.handleFlowMethod();
      this.handleCustomObjectMethod();
      this.hanldeObjectScore();
      console.log('all object scores=>',JSON.stringify(this.allObjectScore));
  }

  // refreshHandle()
  // {
  //   this.recordTypesData = [];
  //   this.visibleRecordType=[];
  //   this.totalTriggers = [];
  //   this.visibleTriggers =[];
  //   this.totalValidation = [];
  //   this.visibleValidaiton = [];
  //   this.totalApexClass = [];
  //   this.visibleApexClass = [];
  //   this.totalFlows = [];
  //   this.visibleFlows=[];
  //   this.totalCustomObject=[];
  //   this.visibleCustomObject=[];
  //   this.isScore = false;
  //   this.isOpenModal = false;
  //   this.allObjectScore=[];
  //   this.visibleAllObjectScore=[];
  //   this.allObjectData=[];
  // }

  handleViewData()
  {
    this.isSpinner = true;
    getAssisData()
        .then(result => {
          this.isSpinner = false;
          this.isOpenModal = true;
          console.log('Open modal=>',this.isOpenModal);
          this.aiDiagramData = result;
          console.log('Diagram Body=>',JSON.parse(JSON.stringify(this.aiDiagramData)));
        })
        .catch(error => {
           this.isSpinner = false;
            console.log('Error==>',error);
        });
  }

  handleCloseModal(event)
  {
      this.isOpenModal = event.detail;
  }

    handleRecordTypes()
    {
      getRecordTypes({objectName: ''})
        .then(result => {
          this.isSpinner = false;
          console.log('Record type Result', result);
          this.recordTypesData = result;
        })
        .catch(error => {
          console.error('Record Type Error:', error);
      });
    }

    handleTriggerMethod()
    {
      getTriggers({ objectName: ''})
        .then(result => {
          this.isSpinner = false;
          this.totalTriggers = JSON.parse(JSON.stringify(result));
          this.totalTriggers.forEach(element => {
            if(element.CreatedBy)
            {
              element.CreatedByName = element.CreatedBy.Name
              console.log('created by :', element.CreatedBy.Name);
            }
          });
          console.log('Trigger', result);
        })
        .catch(error => {
          console.error('trigger Error:', error);
      });
    }

    handleValidationRule()
    {
      getValidationRules()
        .then(result => {
          this.isSpinner = false;
          this.totalValidation = result;
          console.log('validation result', result);
        })
        .catch(error => {
          console.error('validation Error:', error);
      });
    }

    handleFlowMethod()
    {
      getflows({objectName:''})
        .then(result => {
          this.isSpinner = false;
          this.totalFlows = result;
          console.log('flow result', result);
        })
        .catch(error => {
          console.error('flow Error:', error);
      });
    }

    handleCustomObjectMethod()
    {
      getCustomObject()
        .then(result => {
          this.isSpinner = false;
          this.totalCustomObject = result;
          console.log('Custom Object result', result);
        })
        .catch(error => {
          console.error('Custom Object Error:', error);
      });
    }

    handleApexClassMethod()
    {
      getApexClasses()
        .then(result => {
          this.isSpinner = false;
          this.totalApexClass = JSON.parse(JSON.stringify(result));
          this.totalApexClass.forEach(element => {
            if(element.CreatedBy)
            {
              element.CreatedByName = element.CreatedBy.Name
              console.log('created by :', element.CreatedBy.Name);
            }
          });
          console.log('apex class result', JSON.stringify(this.totalApexClass));
        })
        .catch(error => {
          console.error('apex class Error:', error);
      });
    }

    hanldeObjectScore()
    {
      getAssisScore()
          .then(result => {
            this.isSpinner = false;
              console.log('Assist Score=>',JSON.stringify(result));
              this.isScore = true;
              let totalLeadsScore = 0;
              let totalLeads = 0;//This is used to store the object type occurrence.
              let totalAccountsScore = 0;
              let totalAccounts = 0;//This is used to store the object type occurrence.
              let totalContactsScore = 0;
              let totalContacts = 0;//This is used to store the object type occurrence.
              let totalOpportunityScore = 0;
              let totalOpportunities = 0;//This is used to store the object type occurrence.
              result.forEach(element => {
                if(element.Object_Type__c === 'Lead')
                {
                  totalLeads++;
                  totalLeadsScore+=element.Output__c;
                }
                if(element.Object_Type__c === 'Account')
                {
                  totalAccounts++;
                  totalAccountsScore+=element.Output__c;
                }
                if(element.Object_Type__c === 'Contact')
                {
                  totalContacts++;
                  totalContactsScore+=element.Output__c;
                }
                if(element.Object_Type__c === 'Opportunity')
                  {
                    totalOpportunities++;
                    totalOpportunityScore+=element.Output__c;
                  }
              })
              let leadPercent = (Math.round(totalLeadsScore) / (totalLeads)*10);
              let accountPercent = (Math.round(totalAccountsScore) / (totalAccounts)*10);
              let contactPercent = (Math.round(totalContactsScore) / (totalContacts)*10);
              let opportunityPercent = (Math.round(totalOpportunityScore) / (totalOpportunities)*10);
              this.leadScore = leadPercent+'%';
              console.log('lead score =>',JSON.stringify(this.leadScore));
              this.accountScore = accountPercent+'%';
              console.log('account score =>',JSON.stringify(this.accountScore));
              this.contactScore = contactPercent+'%';
              console.log('contact score =>',JSON.stringify(this.contactScore));
              this.opportunityScore = opportunityPercent+'%';
              console.log('opportunity score =>',JSON.stringify(this.opportunityScore));
              this.overAllHealthScore = (leadPercent+accountPercent+contactPercent+opportunityPercent)/4+'%';
              
          })
          .catch(error => {
              // TODO Error handling
              this.isScore = false;
              console.log('Assist Score error=>',error);
          });
    }

    updateRecordTypesHandler(event){
        this.visibleRecordType=[...event.detail.records]
        console.log(event.detail.records)
    }

    updateTriggerHandler(event)
    {
      this.visibleTriggers=[...event.detail.records]
        //console.log(event.detail.records)
    }

    updateValidationHandler(event)
    {
      this.visibleValidaiton=[...event.detail.records]
        //console.log(event.detail.records)
    }

    updateApexClassHandler(event)
    {
      this.visibleApexClass=[...event.detail.records]
        //console.log(event.detail.records)
    }

    updateFlowsHandler(event)
    {
      this.visibleFlows=[...event.detail.records]
        //console.log(event.detail.records)
    }

    updateCustomObjectHandler(event)
    {
      this.visibleCustomObject=[...event.detail.records]
        //console.log(event.detail.records)
    }

    updateAllObjectScoreHandler(event){
      this.visibleAllObjectScore = [...event.detail.records]
  }
}