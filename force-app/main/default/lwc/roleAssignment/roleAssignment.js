import { LightningElement, track } from 'lwc';
import getActiveStandardUsers from '@salesforce/apex/RoleAssignmentHelper.getActiveStandardUsers';
import getFromUserList from '@salesforce/apex/RoleAssignmentHelper.getFromUserList';
import transferRecords from '@salesforce/apex/RoleAssignmentHelper.transferRecords';
import getInactiveUsersMailingState from '@salesforce/apex/RoleAssignmentHelper.getInactiveUsersMailingState';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class RoleAssignment extends LightningElement {
    objName = '';
    fieldName = '';
    fromUsersList = [];
    fromUser = '';
    @track mailingState = '';
    @track  mailingStateVal;
    parentField = '';
    toUserList = [];
    toUser = '';
    @track isTransferDisabled = true;
    prvObjName = '';
    prvFieldName = '';
    @track isLoading = false;
    @track showMailingState = true;

    connectedCallback() {
        this.getActiveStandardUsers();
    }
    getActiveStandardUsers() {
        getActiveStandardUsers()
            .then(result => {
                this.toUserList = result.map(user => ({
                    label: user.Name,
                    value: user.Id
                }));
            })
            .catch(error => {
                console.error('Error fetching users:', error);
            });
    }
    get objectVal() {
        return [
            { label: 'Account', value: 'Account' },
            { label: 'Contact', value: 'Contact' },
        ];
    }


    get fieldVal() {
        if (this.objName == 'Account') {
            return [
                { label: 'PRM', value: 'Primary_Relationship_Manager__c' },
                { label: 'Owner', value: 'OwnerId' },
            ];
        } else if (this.objName == 'Contact') {
            return [
                { label: 'PRM', value: 'Primary_Relationship_Manager__c' },
                { label: 'PSRM', value: 'Primary_Support_Relationship_Manager__c' },
                { label: 'Owner', value: 'OwnerId' },
            ];
        }

    }

    /*get mailingStateVal() {
        return [
            { label: 'WA', value: 'WA' },
            { label: 'QLD', value: 'QLD' },
            { label: 'NT', value: 'NT' },
            { label: 'SA', value: 'SA' },
            { label: 'NSW', value: 'NSW' },
            { label: 'ACT', value: 'ACT' },
            { label: 'VIC', value: 'VIC' },
            { label: 'TAS', value: 'TAS' }
        ];

    }*/

    get isTransferDisabled() {
        return !(this.objName && this.fieldName && this.fromUser && this.toUser);
    }

    handleChange(event) {
        debugger;
        const name = event.target.name;
        const value = event.detail.value;

        console.log('name', name);
        console.log('value', value);

        if (name === 'object') {
            this.objName = value;
            this.fieldName = '';
            this.fromUser = '';
            this.toUser = '';
            this.mailingState = '';
            /*if(this.objName == 'Contact'){
                this.showMailingState = true;
            }else{
                this.showMailingState = false;
                this.mailingState = '';
            }*/
        } else if (name === 'field') {
            this.fieldName = value;
            this.fromUser = '';
            this.toUser = '';
            this.mailingState = '';
        } else if (name === 'fromUser') {
            this.fromUser = value;
            this.toUser = '';
            this.mailingState = '';
            this.getMailingState();
        } else if (name === 'toUser') {
            this.toUser = value;
        } else if (name === 'mailingState') {
            this.mailingState = value;
        }

        console.log('name', this.objName);
        console.log('field', this.fieldName);
        console.log('fromUser', this.fromUser);
        console.log('toUser', this.toUser);

        this.isTransferDisabled = !(this.objName && this.fieldName && this.fromUser && this.toUser);

        if (this.objName && this.fieldName && (this.prvObjName !== this.objName || this.prvFieldName !== this.fieldName)) {
            this.prvObjName = this.objName;
            this.prvFieldName = this.fieldName;

            this.parentField = this.fieldName.includes('__c')
                ? this.fieldName.replace('__c', '__r')
                : this.fieldName.replace('Id', '');

            this.isLoading = true;
            getFromUserList({ objName: this.objName, fieldName: this.fieldName })
                .then(result => {
                    this.fromUsersList = result.map(user => {
                        return {
                            label: user.Name,
                            value: user.Id
                        };
                    });
                    console.log('fromUsersList:', this.fromUsersList);
                    this.fromUser = '';
                })
                .catch(error => {
                    console.error('Error fetching from user list:', error);
                })
                .finally(() => {
                    this.isLoading = false; // Hide spinner when done
                });
        }
    }

    handleTransferClick() {
        if (!this.objName || !this.fieldName || !this.fromUser || !this.toUser) {
            alert('Please select all values');
            return;
        }

        this.isTransferDisabled = true;

        transferRecords({
            objName: this.objName,
            fieldName: this.fieldName,
            fromUserId: this.fromUser,
            toUserid: this.toUser,
            mailingState: this.mailingState
        })
            .then(result => {
                this.parentField = this.fieldName.includes('__c')
                    ? this.fieldName.replace('__c', '__r')
                    : this.fieldName.replace('Id', '');

                this.fromUsersList = Array.isArray(result)
                    ? result.map(record => {
                        const related = record[this.parentField];
                        return {
                            label: related?.Name || 'Unknown',
                            value: related?.Id || ''
                        };
                    })
                    : [];

                this.dispatchEvent(new ShowToastEvent({
                    title: 'Success',
                    message: '✅Records transferring process initiated!!',
                    variant: 'success'
                }));

                console.log('Updated fromUsersList:', this.fromUsersList);
            })
            .catch(error => {
                console.error('Error transferring records:', error);
                this.dispatchEvent(new ShowToastEvent({
                    title: 'Error',
                    message: error.body?.message || 'An error occurred during record transfer.',
                    variant: 'error'
                }));
            });

        // Reset form values
        this.fromUser = '';
        this.toUser = '';
        this.objName = '';
        this.fieldName = '';
        this.fromUsersList = [];
        this.parentField = '';
        this.prvObjName = '';
        this.prvFieldName = '';
        this.mailingState = '';
        this.toUser = '';
    }
    getMailingState() {
        debugger;
        getInactiveUsersMailingState({
            objName: this.objName,
            fieldName: this.fieldName,
            fromUserId: this.fromUser // example User Id
        })
            .then(result => {
                this.mailingStateVal = result;
                console.log('Mailing states:', result);
                console.log('Apex method executed successfully:', result);
            })
            .catch(error => {
                console.error('Error calling Apex method:', error);
            });
    }
}