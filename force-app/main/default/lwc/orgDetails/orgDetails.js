import { LightningElement,track,wire } from 'lwc';
import getAllLicenses from "@salesforce/apex/ExtractDataCls.getAllLicenses";
import getOrgDetails from "@salesforce/apex/ExtractDataCls.getOrgDetails";
import getUserAndProfiles from "@salesforce/apex/UserProfilesCtrl.getActiveUsersAndProfiles";
import getUserWithRoles from "@salesforce/apex/UserProfilesCtrl.getActiveUsersWithRoles";
export default class OrgDetails extends LightningElement {
    @track licenses;
    @track orgData;
    @track profileData;
    @track userWithRulesPer;
    @track isSpinner = false;
    @track columns = [{
            label: 'Name',
            fieldName: 'name',
            type: 'text',
            sortable: true
        },
        {
            label: 'Total Licenses',
            fieldName: 'totalLicenses',
            type: 'Number',
            sortable: true
        },
        {
            label: 'Used Licenses',
            fieldName: 'usedLicenses',
            type: 'Number',
            sortable: true
        },
        {
            label: 'Status',
            fieldName: 'status',
            type: 'text',
            sortable: true
        },
        {
            label: 'Percentage %',
            fieldName: 'percentage',
            type: 'Number',
            sortable: true
        }
    ];

    @track profilsColumn = [{
        label: 'Profile Name',
        fieldName: 'profileName',
        type: 'text',
        sortable: true
    },
    {
        label: 'User Count',
        fieldName: 'userCount',
        type: 'Number',
        sortable: true
    }
    ]

    @wire(getUserAndProfiles, {})
    userProfiles({error, data}) {
        if (error) {
            // TODO: Error handling
        } else if (data) {
            // TODO: Data handling
            this.profileData = data;
            console.log('profles=>',data);
        }
    }
    
    @wire(getUserWithRoles, {})
    UserWithRoles ({error, data}) {
        if (error) {
            // TODO: Error handling
            console.log('user with role error=>',error);
        } else if (data) {
            // TODO: Data handling
            this.userWithRulesPer = data;
            console.log('user with role=>',data);
        }
    }

    connectedCallback(){
        this.handleGetAllLicenses();
        this.handleGetOrgDetails();
    }

    handleGetAllLicenses()
    {
         this.isSpinner = true;
        getAllLicenses()
          .then(result => {
            this.isSpinner = false;
              this.licenses = result;
            console.log('Result', this.licenses);
          })
          .catch(error => {
            this.isSpinner = false;
            console.error('Error:', error);
        });
    }

    handleGetOrgDetails()
    {
        this.isSpinner = true;
        getOrgDetails()
          .then(result => {
            this.isSpinner = false;
            console.log('org data', result);
            this.orgData = JSON.parse(JSON.stringify(result));
            this.orgData.isSandbox = this.orgData.IsSandbox ? 'Yes': 'No';      
          })
          .catch(error => {
            this.isSpinner = false;
            console.error('Error:', error);
        });
    }
}