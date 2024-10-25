CommitUrlCacheEntryA(lpszUrlName, lpszLocalFileName, ExpireTime, LastModifiedTime, CacheEntryType, lpHeaderInfo, cchHeaderInfo, lpszFileExtension, lpszOriginalUrl) => DllCall('Wininet\CommitUrlCacheEntryA', 'astr', lpszUrlName, 'astr', lpszLocalFileName, 'ptr', ExpireTime, 'ptr', LastModifiedTime, 'uint', CacheEntryType, 'ptr', lpHeaderInfo, 'uint', cchHeaderInfo, 'astr', lpszFileExtension, 'astr', lpszOriginalUrl, 'int')
CommitUrlCacheEntryW(lpszUrlName, lpszLocalFileName, ExpireTime, LastModifiedTime, CacheEntryType, lpHeaderInfo, cchHeaderInfo, lpszFileExtension, lpszOriginalUrl) => DllCall('Wininet\CommitUrlCacheEntryW', 'wstr', lpszUrlName, 'wstr', lpszLocalFileName, 'ptr', ExpireTime, 'ptr', LastModifiedTime, 'uint', CacheEntryType, 'wstr', lpHeaderInfo, 'uint', cchHeaderInfo, 'wstr', lpszFileExtension, 'wstr', lpszOriginalUrl, 'int')
CreateMD5SSOHash(pszChallengeInfo, pwszRealm, pwszTarget, pbHexHash) => DllCall('Wininet\CreateMD5SSOHash', 'ptr', pszChallengeInfo, 'ptr', pwszRealm, 'ptr', pwszTarget, 'ptr', pbHexHash, 'int')
CreateUrlCacheEntry(lpszUrlName, dwExpectedFileSize, lpszFileExtension, lpszFileName, dwReserved) => DllCall('Wininet\CreateUrlCacheEntry', 'str', lpszUrlName, 'uint', dwExpectedFileSize, 'str', lpszFileExtension, 'str', lpszFileName, 'uint', dwReserved, 'int')
CreateUrlCacheGroup(dwFlags, lpReserved) => DllCall('Wininet\CreateUrlCacheGroup', 'uint', dwFlags, 'ptr', lpReserved, 'int64')
DeleteUrlCacheEntry(lpszUrlName) => DllCall('Wininet\DeleteUrlCacheEntry', 'str', lpszUrlName, 'int')
DeleteUrlCacheGroup(GroupId, dwFlags, lpReserved) => DllCall('Wininet\DeleteUrlCacheGroup', 'int64', GroupId, 'uint', dwFlags, 'ptr', lpReserved, 'int')
DetectAutoProxyUrl(lpszAutoProxyUrl, dwAutoProxyUrlLength, dwDetectFlags) => DllCall('Wininet\DetectAutoProxyUrl', 'astr', lpszAutoProxyUrl, 'uint', dwAutoProxyUrlLength, 'uint', dwDetectFlags, 'int')
FindCloseUrlCache(hEnumHandle) => DllCall('Wininet\FindCloseUrlCache', 'ptr', hEnumHandle, 'int')
FindFirstUrlCacheEntry(lpszUrlSearchPattern, lpFirstCacheEntryInfo, lpcbCacheEntryInfo) => DllCall('Wininet\FindFirstUrlCacheEntry', 'str', lpszUrlSearchPattern, 'ptr', lpFirstCacheEntryInfo, 'ptr', lpcbCacheEntryInfo, 'ptr')
FindFirstUrlCacheEntryEx(lpszUrlSearchPattern, dwFlags, dwFilter, GroupId, lpFirstCacheEntryInfo, lpdwEntryInfo, lpGroupAttributes, lpcbGroupAttributes, lpReserved) => DllCall('Wininet\FindFirstUrlCacheEntryEx', 'str', lpszUrlSearchPattern, 'uint', dwFlags, 'uint', dwFilter, 'int64', GroupId, 'ptr', lpFirstCacheEntryInfo, 'ptr', lpdwEntryInfo, 'ptr', lpGroupAttributes, 'ptr', lpcbGroupAttributes, 'ptr', lpReserved, 'ptr')
FindFirstUrlCacheGroup(dwFlags, dwFilter, lpSearchCondition, dwSearchCondition, lpGroupId, lpReserved) => DllCall('Wininet\FindFirstUrlCacheGroup', 'uint', dwFlags, 'uint', dwFilter, 'ptr', lpSearchCondition, 'uint', dwSearchCondition, 'ptr', lpGroupId, 'ptr', lpReserved, 'ptr')
FindNextUrlCacheEntry(hEnumHandle, lpNextCacheEntryInfo, lpcbCacheEntryInfo) => DllCall('Wininet\FindNextUrlCacheEntry', 'ptr', hEnumHandle, 'ptr', lpNextCacheEntryInfo, 'ptr', lpcbCacheEntryInfo, 'int')
FindNextUrlCacheEntryEx(hEnumHandle, lpNextCacheEntryInfo, lpcbEntryInfo, lpGroupAttributes, lpcbGroupAttributes, lpReserved) => DllCall('Wininet\FindNextUrlCacheEntryEx', 'ptr', hEnumHandle, 'ptr', lpNextCacheEntryInfo, 'ptr', lpcbEntryInfo, 'ptr', lpGroupAttributes, 'ptr', lpcbGroupAttributes, 'ptr', lpReserved, 'int')
FindNextUrlCacheGroup(hFind, lpGroupId, lpReserved) => DllCall('Wininet\FindNextUrlCacheGroup', 'ptr', hFind, 'ptr', lpGroupId, 'ptr', lpReserved, 'int')
FtpCommand(hConnect, fExpectResponse, dwFlags, lpszCommand, dwContext, phFtpCommand) => DllCall('Wininet\FtpCommand', 'ptr', hConnect, 'int', fExpectResponse, 'uint', dwFlags, 'str', lpszCommand, 'uptr', dwContext, 'ptr', phFtpCommand, 'int')
FtpCreateDirectory(hConnect, lpszDirectory) => DllCall('Wininet\FtpCreateDirectory', 'ptr', hConnect, 'str', lpszDirectory, 'int')
FtpDeleteFile(hConnect, lpszFileName) => DllCall('Wininet\FtpDeleteFile', 'ptr', hConnect, 'str', lpszFileName, 'int')
FtpFindFirstFile(hConnect, lpszSearchFile, lpFindFileData, dwFlags, dwContext) => DllCall('Wininet\FtpFindFirstFile', 'ptr', hConnect, 'str', lpszSearchFile, 'ptr', lpFindFileData, 'uint', dwFlags, 'uptr', dwContext, 'ptr')
FtpGetCurrentDirectory(hConnect, lpszCurrentDirectory, lpdwCurrentDirectory) => DllCall('Wininet\FtpGetCurrentDirectory', 'ptr', hConnect, 'str', lpszCurrentDirectory, 'ptr', lpdwCurrentDirectory, 'int')
FtpGetFile(hConnect, lpszRemoteFile, lpszNewFile, fFailIfExists, dwFlagsAndAttributes, dwFlags, dwContext) => DllCall('Wininet\FtpGetFile', 'ptr', hConnect, 'str', lpszRemoteFile, 'str', lpszNewFile, 'int', fFailIfExists, 'uint', dwFlagsAndAttributes, 'uint', dwFlags, 'uptr', dwContext, 'int')
FtpGetFileSize(hFile, lpdwFileSizeHigh) => DllCall('Wininet\FtpGetFileSize', 'ptr', hFile, 'ptr', lpdwFileSizeHigh, 'uint')
FtpOpenFile(hConnect, lpszFileName, dwAccess, dwFlags, dwContext) => DllCall('Wininet\FtpOpenFile', 'ptr', hConnect, 'str', lpszFileName, 'uint', dwAccess, 'uint', dwFlags, 'uptr', dwContext, 'ptr')
FtpPutFile(hConnect, lpszLocalFile, lpszNewRemoteFile, dwFlags, dwContext) => DllCall('Wininet\FtpPutFile', 'ptr', hConnect, 'str', lpszLocalFile, 'str', lpszNewRemoteFile, 'uint', dwFlags, 'uptr', dwContext, 'int')
FtpRemoveDirectory(hConnect, lpszDirectory) => DllCall('Wininet\FtpRemoveDirectory', 'ptr', hConnect, 'str', lpszDirectory, 'int')
FtpRenameFile(hConnect, lpszExisting, lpszNew) => DllCall('Wininet\FtpRenameFile', 'ptr', hConnect, 'str', lpszExisting, 'str', lpszNew, 'int')
FtpSetCurrentDirectory(hConnect, lpszDirectory) => DllCall('Wininet\FtpSetCurrentDirectory', 'ptr', hConnect, 'str', lpszDirectory, 'int')
GetUrlCacheConfigInfo(lpCacheConfigInfo, lpcbCacheConfigInfo, dwFieldControl) => DllCall('Wininet\GetUrlCacheConfigInfo', 'ptr', lpCacheConfigInfo, 'ptr', lpcbCacheConfigInfo, 'uint', dwFieldControl, 'int')
GetUrlCacheEntryInfo(lpszUrlName, lpCacheEntryInfo, lpcbCacheEntryInfo) => DllCall('Wininet\GetUrlCacheEntryInfo', 'str', lpszUrlName, 'ptr', lpCacheEntryInfo, 'ptr', lpcbCacheEntryInfo, 'int')
GetUrlCacheEntryInfoEx(lpszUrl, lpCacheEntryInfo, lpcbCacheEntryInfo, lpszRedirectUrl, lpcbRedirectUrl, lpReserved, dwFlags) => DllCall('Wininet\GetUrlCacheEntryInfoEx', 'str', lpszUrl, 'ptr', lpCacheEntryInfo, 'ptr', lpcbCacheEntryInfo, 'str', lpszRedirectUrl, 'ptr', lpcbRedirectUrl, 'ptr', lpReserved, 'uint', dwFlags, 'int')
GetUrlCacheGroupAttribute(gid, dwFlags, dwAttributes, lpGroupInfo, lpdwGroupInfo, lpReserved) => DllCall('Wininet\GetUrlCacheGroupAttribute', 'int64', gid, 'uint', dwFlags, 'uint', dwAttributes, 'ptr', lpGroupInfo, 'ptr', lpdwGroupInfo, 'ptr', lpReserved, 'int')
GopherCreateLocator(lpszHost, nServerPort, lpszDisplayString, lpszSelectorString, dwGopherType, lpszLocator, lpdwBufferLength) => DllCall('Wininet\GopherCreateLocator', 'str', lpszHost, 'ushort', nServerPort, 'str', lpszDisplayString, 'str', lpszSelectorString, 'uint', dwGopherType, 'str', lpszLocator, 'ptr', lpdwBufferLength, 'int')
GopherFindFirstFile(hConnect, lpszLocator, lpszSearchString, lpFindData, dwFlags, dwContext) => DllCall('Wininet\GopherFindFirstFile', 'ptr', hConnect, 'str', lpszLocator, 'str', lpszSearchString, 'ptr', lpFindData, 'uint', dwFlags, 'uptr', dwContext, 'ptr')
GopherGetAttribute(hConnect, lpszLocator, lpszAttributeName, lpBuffer, dwBufferLength, lpdwCharactersReturned, lpfnEnumerator, dwContext) => DllCall('Wininet\GopherGetAttribute', 'ptr', hConnect, 'str', lpszLocator, 'str', lpszAttributeName, 'ptr', lpBuffer, 'uint', dwBufferLength, 'ptr', lpdwCharactersReturned, 'int', lpfnEnumerator, 'uptr', dwContext, 'int')
GopherGetLocatorType(lpszLocator, lpdwGopherType) => DllCall('Wininet\GopherGetLocatorType', 'str', lpszLocator, 'ptr', lpdwGopherType, 'int')
GopherOpenFile(hConnect, lpszLocator, lpszView, dwFlags, dwContext) => DllCall('Wininet\GopherOpenFile', 'ptr', hConnect, 'str', lpszLocator, 'str', lpszView, 'uint', dwFlags, 'uptr', dwContext, 'ptr')
HttpAddRequestHeaders(hRequest, lpszHeaders, dwHeadersLength, dwModifiers) => DllCall('Wininet\HttpAddRequestHeaders', 'ptr', hRequest, 'str', lpszHeaders, 'uint', dwHeadersLength, 'uint', dwModifiers, 'int')
HttpEndRequest(hRequest, lpBuffersOut, dwFlags, dwContext) => DllCall('Wininet\HttpEndRequest', 'ptr', hRequest, 'ptr', lpBuffersOut, 'uint', dwFlags, 'uptr', dwContext, 'int')
HttpOpenRequest(hConnect, lpszVerb, lpszObjectName, lpszVersion, lpszReferer, lplpszAcceptTypes, dwFlags, dwContext) => DllCall('Wininet\HttpOpenRequest', 'ptr', hConnect, 'str', lpszVerb, 'str', lpszObjectName, 'str', lpszVersion, 'str', lpszReferer, 'str', lplpszAcceptTypes, 'uint', dwFlags, 'uptr', dwContext, 'ptr')
HttpQueryInfo(hRequest, dwInfoLevel, lpvBuffer, lpdwBufferLength, lpdwIndex) => DllCall('Wininet\HttpQueryInfo', 'ptr', hRequest, 'uint', dwInfoLevel, 'ptr', lpvBuffer, 'ptr', lpdwBufferLength, 'ptr', lpdwIndex, 'int')
HttpSendRequest(hRequest, lpszHeaders, dwHeadersLength, lpOptional, dwOptionalLength) => DllCall('Wininet\HttpSendRequest', 'ptr', hRequest, 'str', lpszHeaders, 'uint', dwHeadersLength, 'ptr', lpOptional, 'uint', dwOptionalLength, 'int')
HttpSendRequestEx(hRequest, lpBuffersIn, lpBuffersOut, dwFlags, dwContext) => DllCall('Wininet\HttpSendRequestEx', 'ptr', hRequest, 'ptr', lpBuffersIn, 'ptr', lpBuffersOut, 'uint', dwFlags, 'uptr', dwContext, 'int')
InternetAttemptConnect(dwReserved) => DllCall('Wininet\InternetAttemptConnect', 'uint', dwReserved, 'uint')
InternetAutodial(dwFlags, hwndParent) => DllCall('Wininet\InternetAutodial', 'uint', dwFlags, 'ptr', hwndParent, 'int')
InternetAutodialHangup(dwReserved) => DllCall('Wininet\InternetAutodialHangup', 'uint', dwReserved, 'int')
InternetCanonicalizeUrl(lpszUrl, lpszBuffer, lpdwBufferLength, dwFlags) => DllCall('Wininet\InternetCanonicalizeUrl', 'str', lpszUrl, 'str', lpszBuffer, 'ptr', lpdwBufferLength, 'uint', dwFlags, 'int')
InternetCheckConnection(lpszUrl, dwFlags, dwReserved) => DllCall('Wininet\InternetCheckConnection', 'str', lpszUrl, 'uint', dwFlags, 'uint', dwReserved, 'int')
InternetClearAllPerSiteCookieDecisions() => DllCall('Wininet\InternetClearAllPerSiteCookieDecisions', 'int')
InternetCloseHandle(hInternet) => DllCall('Wininet\InternetCloseHandle', 'ptr', hInternet, 'int')
InternetCombineUrl(lpszBaseUrl, lpszRelativeUrl, lpszBuffer, lpdwBufferLength, dwFlags) => DllCall('Wininet\InternetCombineUrl', 'str', lpszBaseUrl, 'str', lpszRelativeUrl, 'str', lpszBuffer, 'ptr', lpdwBufferLength, 'uint', dwFlags, 'int')
InternetConfirmZoneCrossing(hWnd, szUrlPrev, szUrlNew, bPost) => DllCall('Wininet\InternetConfirmZoneCrossing', 'ptr', hWnd, 'str', szUrlPrev, 'str', szUrlNew, 'int', bPost, 'uint')
InternetConnect(hInternet, lpszServerName, nServerPort, lpszUsername, lpszPassword, dwService, dwFlags, dwContext) => DllCall('Wininet\InternetConnect', 'ptr', hInternet, 'str', lpszServerName, 'ushort', nServerPort, 'str', lpszUsername, 'str', lpszPassword, 'uint', dwService, 'uint', dwFlags, 'uptr', dwContext, 'ptr')
InternetCrackUrl(lpszUrl, dwUrlLength, dwFlags, lpUrlComponents) => DllCall('Wininet\InternetCrackUrl', 'str', lpszUrl, 'uint', dwUrlLength, 'uint', dwFlags, 'ptr', lpUrlComponents, 'int')
InternetCreateUrl(lpUrlComponents, dwFlags, lpszUrl, lpdwUrlLength) => DllCall('Wininet\InternetCreateUrl', 'ptr', lpUrlComponents, 'uint', dwFlags, 'str', lpszUrl, 'ptr', lpdwUrlLength, 'int')
InternetDial(hwndParent, pszEntryName, dwFlags, lpdwConnection, dwReserved) => DllCall('Wininet\InternetDial', 'ptr', hwndParent, 'str', pszEntryName, 'uint', dwFlags, 'uptr', lpdwConnection, 'uint', dwReserved, 'uint')
InternetEnumPerSiteCookieDecision(pszSiteName, &pcSiteNameSize, &pdwDecision, dwIndex) => DllCall('Wininet\InternetEnumPerSiteCookieDecision', 'str', pszSiteName, 'int*', &pcSiteNameSize, 'int*', &pdwDecision, 'uint', dwIndex, 'int')
InternetErrorDlg(hWnd, hRequest, dwError, dwFlags, lppvData) => DllCall('Wininet\InternetErrorDlg', 'ptr', hWnd, 'ptr', hRequest, 'uint', dwError, 'uint', dwFlags, 'ptr', lppvData, 'uint')
InternetFindNextFile(hFind, lpvFindData) => DllCall('Wininet\InternetFindNextFile', 'ptr', hFind, 'ptr', lpvFindData, 'int')
InternetGetConnectedState(lpdwFlags, dwReserved) => DllCall('Wininet\InternetGetConnectedState', 'ptr', lpdwFlags, 'uint', dwReserved, 'int')
InternetGetConnectedStateEx(lpdwFlags, lpszConnectionName, dwNameLen, dwReserved) => DllCall('Wininet\InternetGetConnectedStateEx', 'ptr', lpdwFlags, 'str', lpszConnectionName, 'uint', dwNameLen, 'uint', dwReserved, 'int')
InternetGetCookie(lpszUrl, lpszCookieName, lpszCookieData, lpdwSize) => DllCall('Wininet\InternetGetCookie', 'str', lpszUrl, 'str', lpszCookieName, 'str', lpszCookieData, 'ptr', lpdwSize, 'int')
InternetGetCookieEx(lpszURL, lpszCookieName, lpszCookieData, lpdwSize, dwFlags, lpReserved) => DllCall('Wininet\InternetGetCookieEx', 'str', lpszURL, 'str', lpszCookieName, 'str', lpszCookieData, 'ptr', lpdwSize, 'uint', dwFlags, 'ptr', lpReserved, 'int')
InternetGetLastResponseInfo(lpdwError, lpszBuffer, lpdwBufferLength) => DllCall('Wininet\InternetGetLastResponseInfo', 'ptr', lpdwError, 'str', lpszBuffer, 'ptr', lpdwBufferLength, 'int')
InternetGetPerSiteCookieDecision(pchHostName, &pResult) => DllCall('Wininet\InternetGetPerSiteCookieDecision', 'str', pchHostName, 'int*', &pResult, 'int')
InternetGoOnline(lpszURL, hwndParent, dwFlags) => DllCall('Wininet\InternetGoOnline', 'str', lpszURL, 'ptr', hwndParent, 'uint', dwFlags, 'int')
InternetHangUp(dwConnection, dwReserved) => DllCall('Wininet\InternetHangUp', 'uptr', dwConnection, 'uint', dwReserved, 'uint')
InternetLockRequestFile(hInternet, lphLockReqHandle) => DllCall('Wininet\InternetLockRequestFile', 'ptr', hInternet, 'ptr', lphLockReqHandle, 'int')
InternetOpen(lpszAgent, dwAccessType, lpszProxyName, lpszProxyBypass, dwFlags) => DllCall('Wininet\InternetOpen', 'str', lpszAgent, 'uint', dwAccessType, 'str', lpszProxyName, 'str', lpszProxyBypass, 'uint', dwFlags, 'ptr')
InternetOpenUrl(hInternet, lpszUrl, lpszHeaders, dwHeadersLength, dwFlags, dwContext) => DllCall('Wininet\InternetOpenUrl', 'ptr', hInternet, 'str', lpszUrl, 'str', lpszHeaders, 'uint', dwHeadersLength, 'uint', dwFlags, 'uptr', dwContext, 'ptr')
InternetQueryDataAvailable(hFile, lpdwNumberOfBytesAvailable, dwFlags, dwContext) => DllCall('Wininet\InternetQueryDataAvailable', 'ptr', hFile, 'ptr', lpdwNumberOfBytesAvailable, 'uint', dwFlags, 'uptr', dwContext, 'int')
InternetQueryOption(hInternet, dwOption, lpBuffer, lpdwBufferLength) => DllCall('Wininet\InternetQueryOption', 'ptr', hInternet, 'uint', dwOption, 'ptr', lpBuffer, 'ptr', lpdwBufferLength, 'int')
InternetReadFile(hFile, lpBuffer, dwNumberOfBytesToRead, lpdwNumberOfBytesRead) => DllCall('Wininet\InternetReadFile', 'ptr', hFile, 'ptr', lpBuffer, 'uint', dwNumberOfBytesToRead, 'ptr', lpdwNumberOfBytesRead, 'int')
InternetReadFileEx(hFile, lpBuffersOut, dwFlags, dwContext) => DllCall('Wininet\InternetReadFileEx', 'ptr', hFile, 'ptr', lpBuffersOut, 'uint', dwFlags, 'uptr', dwContext, 'int')
InternetSetCookie(lpszUrl, lpszCookieName, lpszCookieData) => DllCall('Wininet\InternetSetCookie', 'str', lpszUrl, 'str', lpszCookieName, 'str', lpszCookieData, 'int')
InternetSetCookieEx(lpszURL, lpszCookieName, lpszCookieData, dwFlags, dwReserved) => DllCall('Wininet\InternetSetCookieEx', 'str', lpszURL, 'str', lpszCookieName, 'str', lpszCookieData, 'uint', dwFlags, 'uptr', dwReserved, 'uint')
InternetSetFilePointer(hFile, lDistanceToMove, lpDistanceToMoveHigh, dwMoveMethod, dwContext) => DllCall('Wininet\InternetSetFilePointer', 'ptr', hFile, 'int', lDistanceToMove, 'ptr', lpDistanceToMoveHigh, 'uint', dwMoveMethod, 'uptr', dwContext, 'uint')
InternetSetOption(hInternet, dwOption, lpBuffer, dwBufferLength) => DllCall('Wininet\InternetSetOption', 'ptr', hInternet, 'uint', dwOption, 'ptr', lpBuffer, 'uint', dwBufferLength, 'int')
InternetSetPerSiteCookieDecision(pchHostName, dwDecision) => DllCall('Wininet\InternetSetPerSiteCookieDecision', 'str', pchHostName, 'uint', dwDecision, 'int')
InternetSetStatusCallback(hInternet, lpfnInternetCallback) => DllCall('Wininet\InternetSetStatusCallback', 'ptr', hInternet, 'ptr', lpfnInternetCallback, 'ptr')
InternetTimeFromSystemTime(pst, dwRFC, lpszTime, cbTime) => DllCall('Wininet\InternetTimeFromSystemTime', 'ptr', pst, 'uint', dwRFC, 'str', lpszTime, 'uint', cbTime, 'int')
InternetTimeToSystemTime(lpszTime, pst, dwReserved) => DllCall('Wininet\InternetTimeToSystemTime', 'str', lpszTime, 'ptr', pst, 'uint', dwReserved, 'int')
InternetUnlockRequestFile(hLockRequestInfo) => DllCall('Wininet\InternetUnlockRequestFile', 'ptr', hLockRequestInfo, 'int')
InternetWriteFile(hFile, lpBuffer, dwNumberOfBytesToWrite, lpdwNumberOfBytesWritten) => DllCall('Wininet\InternetWriteFile', 'ptr', hFile, 'ptr', lpBuffer, 'uint', dwNumberOfBytesToWrite, 'ptr', lpdwNumberOfBytesWritten, 'int')
PrivacyGetZonePreferenceW(dwZone, dwType, pdwTemplate, pszBuffer, pdwBufferLength) => DllCall('Wininet\PrivacyGetZonePreferenceW', 'uint', dwZone, 'uint', dwType, 'ptr', pdwTemplate, 'ptr', pszBuffer, 'ptr', pdwBufferLength, 'uint')
PrivacySetZonePreferenceW(dwZone, dwType, dwTemplate, pszPreference) => DllCall('Wininet\PrivacySetZonePreferenceW', 'uint', dwZone, 'uint', dwType, 'uint', dwTemplate, 'wstr', pszPreference, 'uint')
ReadUrlCacheEntryStream(hUrlCacheStream, dwLocation, lpBuffer, lpdwLen, dwReserved) => DllCall('Wininet\ReadUrlCacheEntryStream', 'ptr', hUrlCacheStream, 'uint', dwLocation, 'ptr', lpBuffer, 'ptr', lpdwLen, 'uint', dwReserved, 'int')
ResumeSuspendedDownload(hRequest, dwResultCode) => DllCall('Wininet\ResumeSuspendedDownload', 'ptr', hRequest, 'uint', dwResultCode, 'int')
RetrieveUrlCacheEntryFile(lpszUrlName, lpCacheEntryInfo, lpcbCacheEntryInfo, dwReserved) => DllCall('Wininet\RetrieveUrlCacheEntryFile', 'str', lpszUrlName, 'ptr', lpCacheEntryInfo, 'ptr', lpcbCacheEntryInfo, 'uint', dwReserved, 'int')
RetrieveUrlCacheEntryStream(lpszUrlName, lpCacheEntryInfo, lpcbCacheEntryInfo, fRandomRead, dwReserved) => DllCall('Wininet\RetrieveUrlCacheEntryStream', 'str', lpszUrlName, 'ptr', lpCacheEntryInfo, 'ptr', lpcbCacheEntryInfo, 'int', fRandomRead, 'uint', dwReserved, 'ptr')
SetUrlCacheEntryGroup(lpszUrlName, dwFlags, GroupId, pbGroupAttributes, cbGroupAttributes, lpReserved) => DllCall('Wininet\SetUrlCacheEntryGroup', 'str', lpszUrlName, 'uint', dwFlags, 'int64', GroupId, 'ptr', pbGroupAttributes, 'uint', cbGroupAttributes, 'ptr', lpReserved, 'int')
SetUrlCacheEntryInfo(lpszUrlName, lpCacheEntryInfo, dwFieldControl) => DllCall('Wininet\SetUrlCacheEntryInfo', 'str', lpszUrlName, 'ptr', lpCacheEntryInfo, 'uint', dwFieldControl, 'int')
SetUrlCacheGroupAttribute(gid, dwFlags, dwAttributes, lpGroupInfo, lpReserved) => DllCall('Wininet\SetUrlCacheGroupAttribute', 'int64', gid, 'uint', dwFlags, 'uint', dwAttributes, 'ptr', lpGroupInfo, 'ptr', lpReserved, 'int')
UnlockUrlCacheEntryFile(lpszUrlName, dwReserved) => DllCall('Wininet\UnlockUrlCacheEntryFile', 'str', lpszUrlName, 'uint', dwReserved, 'int')
UnlockUrlCacheEntryStream(hUrlCacheStream, dwReserved) => DllCall('Wininet\UnlockUrlCacheEntryStream', 'ptr', hUrlCacheStream, 'uint', dwReserved, 'int')
