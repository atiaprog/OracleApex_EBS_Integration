# OracleApex EBS Integration
using this  package to integrate oracle apex with oracle EBS with smooth integration 
# Follow this Steps  and apply it to your apex project to share it with same oracle ebs credintial and session 
## You Can Now Share Same Session with oracle ebs suite  and make smooth integration** .

## Please Refer to Oracle White Paper as reference

**In order to connect from Oracle E-Business Suite to your new Oracle Application Express
Applications, a mechanism is required to hand control from Oracle E-Business Suite to
Oracle Application Express. The following actions need to be performed:

1. Create an Oracle Application Express application.
2. Configure  the Oracle Application Express login process if you want to authenticate user.
before accessing the application.
3. Define Oracle Application Express authorizations.
4. Define Oracle E-Business Suite Profile and functions.
5. Link functions to menus and responsibility.

## Perform below activities from APEX side :
##  Creating an Oracle Application Express Application
We are going to use the cookie settings in the icx_sessions table of Oracle E-Business Suite.
Because, when checking the session variables I store more relevant Oracle E-Business
Suite session information in Oracle Application Express Application Items.

Application Items (Shared Components > Logic)
Scope : Application
Session State Protection : Restricted - May not be set from browser

***Application Item Name Comments**
EBS_USER_ID Key to User; 
**To check EBS authorization and to set EBS context(icx_sessions)**
EBS_RESP_ID Key to Responsibility 
To check EBS authorization and to set EBS context (icx_sessions)
EBS_RESP_APPL_ID Key to Responsibility Application;
To check EBS authorization and to set EBS context (icx_sessions)
EBS_SEC_GROUP_ID Key to Security Group; 
To check EBS authorization and to set EBS
context (icx_sessions)
EBS_TIME_OUT Session Time Out in Oracle E-Business Suite (icx_sessions)
EBS_URL URL to return to EBS Homepage from APEX (icx_session_attributes)
EBS_ORG_ID EBS ORG_ID (icx_sessions) - MO: Operating Unit from Responsibility
EBS_APPLICATION_NAME To be displayed at the left tophand corner (application_name from fnd_application_tl using EBS_RESP_APPL_ID)

## The Application Items are used in queries or when setting the ‘environment’ (apps_initialize).

**Authentication (Shared Components > Security).**
The Oracle Application Express pages are directly launched from the E-Business Suite.
Additional login is not desirable, so no Authentication Scheme.

**Authorization (Shared Components > Security)**
I created an Authorization Scheme 'Check EBS Credentials' that will check whether the user
has a valid E-Business Suite session. If so, then session attributes are copied into the
Application Items. If not, then an error message will be displayed that access is not
allowed. The E-Business Suite function icx_sec.getsessioncookie is used to determine the
session_id. This session_id is the key to retrieve additional information from the E-Business
Suite tables icx_sessions and icx_session_attributes.

**Authorization Schemes: Create>Next>**
Name: Check EBS Credentials
Scheme Type: PL/SQL Function Returning Boolean
PL/SQL Function Body:
BEGIN
RETURN apps.apex_global.check_ebs_credentials;
END;
Error message displayed when scheme violated: "Access not allowed: No valid E-Business Suite session."
Evaluation point: once per page view Create Authorization Scheme .

**Security Attributes (Shared Components > Security)**
Access to any page in the APEX application is not allowed when no E-Business Suite session
is active. This is arranged by setting the Authorization Scheme as a Security Attribute.
However, it is also possible to manage authorization per page. In the latter case don't set
the authorization scheme as shared component.
Security > Security Attributes: Authorization
Authorization Scheme: Check EBS Credentials
Apply Changes.


### Perform below activities from EBS side
Update the FND: APEX URL Profile option with the correct setting at the
site level using the following steps:

1. Log in to Oracle E-Business Suite with the SYSADMIN user.ex(http ://<EBS_Hostname>:8074/OA_HTML/AppsLogin)
2. Navigate to the System Administrator responsibility > Profile > System menu option
3. Search for Profile %APEX%, click Find . 
4. for Profile FND: APEX URL enter Site http://<EBS_Hostname>:8080/apex
5. Save the Profile.

### Perform the following steps to Define the Oracle E-Business Suite functions:

1. Navigate to the System Administrator responsibility > Application > Function menu
option
2. For calls to the page without responsibility, create a function with the following details:
Description > Function: APEX_FUN > User Function Name: APEX Extension Properties –  Type: JSP
##Web HTML : HTML Call: GWY.jsp?targetAppType=APEX& p=<APEX Application Id>:
<APEX Page>:<Session>:<Request>:<Debug>:<Clear Cache>:<Parameter Pairs>
{ For example, to call Oracle Application Express application 104, Page 1
use GWY.jsp?targetAppType=APEX&p=104:1:0::NO:1: , all other parameters are
optional}
  
 **Add menu component under required Menu as shown below**
 Menu Name: [Specify Menu Name here]
User Menu Name : [Specify User Menu Name here]
Menu Type: Standard
3. Create menu component –
Sequence: 1
Prompt: Launch APEX Page
Function: APEX Extension
4. Save the menu.
  










