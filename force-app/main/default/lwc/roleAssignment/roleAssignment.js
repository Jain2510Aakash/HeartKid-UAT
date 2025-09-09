import { LightningElement, track } from 'lwc';
import getActiveStandardUsers from '@salesforce/apex/RoleAssignmentHelper.getActiveStandardUsers';
import getFromUserList from '@salesforce/apex/RoleAssignmentHelper.getFromUserList';
import transferRecords from '@salesforce/apex/RoleAssignmentHelper.transferRecords';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class RoleAssignment extends LightningElement {
    objName = '';
    fieldName = '';
    fromUsersList = [];
    fromUser = '';
    parentField = '';
    toUserList = [];
    toUser = '';
    @track isTransferDisabled = true;
    prvObjName = '';
    prvFieldName = '';
    @track isLoading = false;

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
        return [
            { label: 'PRM', value: 'Primary_Relationship_Manager__c' },
            { label: 'Owner', value: 'OwnerId' },
        ];
    }

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
        } else if (name === 'field') {
            this.fieldName = value;
            this.fromUser = '';
            this.toUser = '';
        } else if (name === 'fromUser') {
            this.fromUser = value;
            this.toUser = '';
        } else if (name === 'toUser') {
            this.toUser = value;
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
            toUserid: this.toUser
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
    }
}