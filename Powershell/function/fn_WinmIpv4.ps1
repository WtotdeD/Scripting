
get-wmiobject win32_networkadapter | select netconnectionid, name, InterfaceIndex, netconnectionstatus

get-wmiobject win32_networkadapter -filter "netconnectionstatus = 2" |

select netconnectionid, name, InterfaceIndex, netconnectionstatus