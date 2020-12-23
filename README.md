# engagement-churn-prediction
Predict engagement and churn using financial data.



**Problem Statement** 

Predict **engagement** and **churn** using financial data.

Utilizing this data, your business knowledge and potentially your interests, please accomplish the following tasks: 

1. Write a SQL query to answer the following question: 

a. For all users that received a notification, what is the difference in average transactions 7 days before the notification arrived vs. 7 days after the notification arrived, by country and age group? 

2. Define a target metric to measure user engagement. How would you define an *engaged* vs. *unengaged* user? 

a. Please provide the business justification and associated visualisations / rationale in choosing your definition of engagement 

3. Using your logic from above, build a model (heuristic/statistical/ML) to classify *engaged* and *unengaged* users 

a. Note that features which are directly correlated with your target metric could lead to overfitting 

4. Let’s assume an *unengaged* user is a churned user. Now suppose we use your model to identify unengaged users and implement some business actions try to convert them to engaged users (commonly known as reducing churn) 

a. How would you set up a test/experiment to check whether we are actually reducing churn? 
b. What metrics and techniques would you use to assess the impact of the business action? 



**The Datasets** 

**1. devices.csv** a table of devices associated with a user 

- **brand**: string corresponding to the phone brand 

- **user_id**: string uniquely identifying the user 

**2. users.csv** a table of user data 

- **user_id**: string uniquely identifying the user 

- **birth_year**: integer corresponding to the user’s birth year 

- **country**: two letter string corresponding to the user’s country of residence 

- **city**: two string corresponding to the user’s city of residence 

- **created_date**: datetime corresponding to the user’s created date 

- **user_settings_crypto_unlocked**: integer indicating if the user has unlocked the crypto currencies in the app 

- **plan**: string indicating on which plan the user is on 

- **attributes_notifications_marketing_push**: float indicating if the user has accepted to receive marketing push notifications 

- **attributes_notifications_marketing_email**: float indicating if the user has accepted to receive marketing email notifications

- **num_contacts**: integer corresponding to the number of contacts the user has

- **num_referrals**: integer corresponding to the number of users referred by the selected user 

- **num_successful_referrals**: integer corresponding to the number of users successfully referred by the selected user (successfully means users who have actually installed the app and are able to use the product) 

**3. notifications.csv** a table of notifications that a user has received

- **reason**: string indicating the purpose of the notification 

- **channel**: string indicating how the user has been notified 

- **status**: string indicating the status of the notification 

- **user_id**: string uniquely identifying the user 

- **created_date**: datetime indicating when the notification has been sent 

**4. transactions.csv** a table with transactions that a user made 

- **transaction_id**: string uniquely identifying the transaction 

- **transactions_type**: string indicating the type of the transaction 

- **transactions_currency**: string indicating the currency of the transaction 

- **amount_usd**: float corresponding to the transaction amount in USD 

- **transactions_state**: string indicating the state of a transaction 

- COMPLETED - the transaction was completed and the user's balance was changed 

- DECLINED/FAILED - the transaction was declined for some reason, usually pertains to insufficient balance 

- REVERTED - the associated transaction was completed first but was then rolled back later in time potentially due to customer reaching out

- **ea_cardholderpresence**: string indicating if the card holder was present when the transaction happened 

- **ea_merchant_mcc**: float corresponding to the Merchant Category Code (MCC) 

- **ea_merchant_city**: string corresponding to the merchant’s city 

- **ea_merchant_country**: string corresponding to the merchant’s country 

- **direction**: string indicating the direction of the transaction 

- **user_id**: string uniquely identifying the user 

- **created_date**: datetime corresponding to the transaction’s created date 
