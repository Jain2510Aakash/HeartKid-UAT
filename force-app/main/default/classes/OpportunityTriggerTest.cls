@isTest
public class OpportunityTriggerTest {
    
    @isTest
    static void testOpportunityNameWithSpecialCharacters() {
        Opportunity opp = new Opportunity(
            Name = '!@#$ Testing Opportunity',
            StageName = 'Prospecting',
            CloseDate = Date.today().addDays(10)
        );
        
        insert opp;
    }

}