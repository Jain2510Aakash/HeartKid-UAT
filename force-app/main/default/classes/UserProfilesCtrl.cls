/*
Created By          : Girikon (Mohd Sahil)
Created On          : March 21, 2024
@description        : 
Test Class          : 

Modification log --
Modified By         : 
Modified On         : 

*/
public with sharing class UserProfilesCtrl 
{

    // Method to fetch active users and their profiles
    @AuraEnabled(cacheable=true)
    public static List<ProfileUsageWrapper> getActiveUsersAndProfiles() 
    {
        List<ProfileUsageWrapper> profilesUsage = new List<ProfileUsageWrapper>();
        
        // Query active users and their profiles
        for(User user : [SELECT Id, Profile.Name FROM User WHERE IsActive = true AND Profile.Name != Null WITH SECURITY_ENFORCED]) {
            profilesUsage.add(new ProfileUsageWrapper(user.Profile.Name, 1));
        }
        
        // Aggregate the count of active users per profile
        Map<String, Integer> profileCountMap = new Map<String, Integer>();
        for(ProfileUsageWrapper wrapper : profilesUsage) {
            if(profileCountMap.containsKey(wrapper.profileName)) {
                profileCountMap.put(wrapper.profileName, profileCountMap.get(wrapper.profileName) + 1);
            } else {
                profileCountMap.put(wrapper.profileName, 1);
            }
        }
        
        // Create final list with aggregated counts
        List<ProfileUsageWrapper> finalList = new List<ProfileUsageWrapper>();
        for(String profileName : profileCountMap.keySet()) {
            finalList.add(new ProfileUsageWrapper(profileName, profileCountMap.get(profileName)));
        }
        
        return finalList;
    }

    // Method to fetch active users and their Roles then calculate user percentage with active use with roles.
    @AuraEnabled(cacheable=true)
    public static Decimal getActiveUsersWithRoles(){
        Integer noOfActiveUsers = 0; // Size of active users.
        Integer noOfActiveUsersWithRole = 0; //Size of active user with roles.
        // Query active users.
        List<User> userList = [SELECT Name FROM User WHERE IsActive = true WITH SECURITY_ENFORCED];
        // Query active users and their roles
        List<User> userListWithRole = [SELECT Name , IsActive , Profile.Name , UserRole.Name FROM User WHERE IsActive = true AND UserRole.Name != Null WITH SECURITY_ENFORCED];
        if(!userList.isEmpty())
        {
            noOfActiveUsers = userList.size();
        }

        if(!userListWithRole.isEmpty())
        {
            noOfActiveUsersWithRole = userListWithRole.size();
        }

         // Calculate the percentage
         Decimal percentage = (Decimal.valueOf(noOfActiveUsersWithRole) / Decimal.valueOf(noOfActiveUsers)) * 100;

         //Round of for two decimal places.
         Decimal rounded = Math.round(percentage * 100) / 100.0;
 
         // Print or return the percentage
         System.debug('Percentage of active user with role: ' + rounded + '%');
 
         return rounded;
       
    }

    @AuraEnabled(cacheable=true)
    public static List<User> userWithProfile(){
        // Query active users and their profiles
        List<User> userList = [SELECT Name , IsActive , Email, Profile.Name  FROM User WHERE IsActive = true AND Profile.Name != Null WITH SECURITY_ENFORCED Limit 20];

        if(!userList.isEmpty())
        {
            return userList;
        }

        return null;
    }
    
    // Wrapper class to hold profile name and usage count
    public class ProfileUsageWrapper {
        @AuraEnabled
        public String profileName;
        @AuraEnabled
        public Integer userCount;
        
        public ProfileUsageWrapper(String profileName, Integer userCount) {
            this.profileName = profileName;
            this.userCount = userCount;
        }
    }
}