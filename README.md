## _Bharpett - INFERNO_

## _API DOCS_ 
---
_LOGIN : post : used to login_
https://bharpett.herokuapp.com/ 
{
    "email": "test@gmail.com",
    "password": "test@123"
}
---
_REGISTER : post : used to register_
https://bharpett.herokuapp.com/accounts/register/
{
    "fullname":"test test",
    "email":"test@gmail.com",
    "phone":"9782391873",
    "role":"VOLUNTEER",
    "password": "123456"
}
---
_USER DATA : get : used to get user data_
https://bharpett.herokuapp.com/accounts/user-data/
headers :: Authorization: token
---
_GET ALL RESTAURANTS : post : used to get all restaurants near  user's location_
https://bharpett.herokuapp.com/api/get_all_restaurants/
{
    "latitude": "23.37498889",
    "longitude": "85.33548611"
}
---
_GET SINGLE RESTAURANT : get : used to get detailed information about a restaurant_
https://bharpett.herokuapp.com/api/get_single_restaurant/<int:id>/
---
_GET RECOMMENDED RESTAURANTS : post : used to get restaurants filtered under basis of distance, average-cost, rating, votes, etc. _
https://bharpett.herokuapp.com/api/get_recommended_restaurants/
{
    "latitude": "23.37498889",
    "longitude": "85.33548611"
}
---
_DONATE : post : used to donate food by posting information about it_
https://bharpett.herokuapp.com/api/donate/
{
    "name":"Temple",
    "latitude": "23.37498889",
    "longitude": "85.33548611",
    "sufficient_for":"3",
    "date": "2022-05-01",
    "time": "3:00:00"
}
---
_MY DONATIONS : get : used to get all donations posted by a particular user_
https://bharpett.herokuapp.com/api/get_my_donations/
headers :: Authorization: token
---
_ALL DONATIONS : post : used to get all donations based on user's location_
https://bharpett.herokuapp.com/api/get_all_donations/
{
“latitude”: “23.37498889”,
“longitude”: “85.33548611”
}