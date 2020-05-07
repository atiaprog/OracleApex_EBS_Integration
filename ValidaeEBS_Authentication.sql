/*
    Developed by atia  FEB - 19  
    Version 1.0.0 
    Purpose  : Validate Login to Oracel EBS Suite  12.13 with Same Authentication with  EBS (SAME USERNAME AND PASSWORD)
    
*/
function ebs_validate_login(
    p_username  in varchar2
    ,p_password in varchar2 
    )return boolean 
is 
l_errornum   varchar2(240);
l_errormsg   varchar2(240);
begin 

return FND_USER_PKG.VALIDATELOGIN(p_username,p_password);

exception when others then  
    l_errornum :=sqlcode;
    l_errormsg :=substr(sqlerrm,1,240);
    raise_application_error(l_errornum,l_errormsg);

end;