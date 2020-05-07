CREATE OR REPLACE package APPS.apex_integration_sample_apis as
function apex_validate_login (  p_username   in  varchar2
                              , p_password   in  varchar2
                             ) return boolean;
                             
function ebs_authentication( p_username in varchar2,
                            p_password in  varchar2
)return boolean;             

procedure apex_update_email (  p_username        in varchar2
                             , p_owner           in varchar2
                             , p_email_address   in varchar2
                            );

end;

CREATE OR REPLACE package body APPS.apex_integration_sample_apis as
function apex_validate_login (  p_username   in  varchar2
                              , p_password   in  varchar2
                             ) return boolean
is
begin
    return fnd_user_pkg.validatelogin(p_username, p_password);
end apex_validate_login;
function ebs_authentication(
    p_username in varchar2,
    p_password in  varchar2
)return boolean
is 
begin 
--Web authentication 
return FND_WEB_SEC.VALIDATE_LOGIN(p_username,p_password)='Y';
end ebs_authentication;

procedure apex_update_email (  p_username        in varchar2
                             , p_owner           in varchar2
                             , p_email_address   in varchar2
                            )
is
begin
    wf_event.setdispatchmode('async');
    fnd_user_pkg.updateuser(x_user_name=>p_username, x_owner=>p_owner, x_email_address=>p_email_address);
end apex_update_email;
end apex_integration_sample_apis;
/