#pragma once
/*
@author zhp
@date 2014/4/28 0:08
@purpose for check and login
*/
#include "Net/client.h"
#include <boost/shared_ptr.hpp>
#include <boost/weak_ptr.hpp>
#include <Net/PocoMore.h>
#include <Net/CmnLogin.h>
#include "ServerIpInfo.h"

class CheckLoginC : public CmnCheckLoginC<CmnCheckLoginOperC, CheckLoginC>{
public:
	CheckLoginC( const std::string& check_server_ip );
	//登陆成功后做的事
	static bool AfterLoginSucced( const std::function<void( SelfPtr& conne_self )>& func );

	//interface
public:
	static auto GetIpInfo()->const decltype(kRemoteCheckSvrDomain)&{
		return kRemoteCheckSvrDomain;
	}
	/*static const char* GetIpInfo(){
		return "127.0.0.1";
	}*/

protected:
	void OnDisconnect( IoConnectBase* connect ) override;
	bool OnConnected( IoConnectBase* connect ) override;

private:
	bool OnLoginRes( bool res, pt_csz info, pt_csz ac_pwd_machine_mix, pt_csz new_cookie, 
		const TimeT& end_day_time, const TimeT& ser_cur_time, const AddrDatasT& addr_datas, const StrDatasT& str_addr_datas ) override;
	bool OnRemoveBind( bool res, pt_csz info ) override;
	bool OnRegUser( bool res, pt_csz info ) override;
	bool OnUserPay( bool res, pt_csz info ) override;
	bool OnLeaveMsg( bool res, pt_csz info ) override;
};