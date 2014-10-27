magentoCustomerAddressSql
=========================

A sql to query magento's customers name/address/ and output as CSV.

In Magento, customer addresses are stored in 2 tables.
customer_address_entity_test has the street address.
customer_address_entity_varchar has the city, zip code, etc...
Attribute 26 is the city,
28 is the state
30 is the zip code,
31 is the phone number

I process the data by using IF and GROUP_CONCAT.
