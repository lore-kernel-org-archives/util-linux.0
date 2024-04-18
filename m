Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2061.outbound.protection.outlook.com [40.107.105.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CFA75804
	for <util-linux@vger.kernel.org>; Thu, 18 Apr 2024 08:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713427965; cv=fail; b=XT0gD1z1if873hHkrNfRq8iS3V3+sAVGdjSr8VH9lFSWlG56YbWs7nbfEp8Smm9xfQpAaJTSKALSXVbUcDmiNrQIG0963cSSDy6GUNW0ujjjyTZbc13NMq1oRowkL0SAkKRthHsfB4Z7mJhWhsLWJ+HWZCRgpJI5RF3dYCxCSvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713427965; c=relaxed/simple;
	bh=rEwudUNqIoqyBGrafY39P5dZiNsIzvujHF1Q9IlmYj0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Tm1Yp1TH3wbmSnIXwhlHXVYRINBtPSAZJYiq+d+GsP366p1QroHFiDQCRqE69GKa1t+/ZgYboFaU8ZCSQeMPUZTuCiyM0DjBLiWp8z6rcUEjxoZh/Lt1h+RtVWbWmd2nf0FCkvUCSAytQv48bFRHyAJh/iBDij83eH7fM6v/aEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk; spf=pass smtp.mailfrom=prevas.dk; dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b=iGeoKFC+; arc=fail smtp.client-ip=40.107.105.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prevas.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="iGeoKFC+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mSCOEqVFy0wGIR91gsync43sDFogxIR70ac38ExJMFh1u+S2Ppd9+7XdueNHRGiwy1NUmW9DKD/8vXfDHFr7aLVtR0gcrlmt9080FitkqcY9dpEEJsDzkragRiMKtye1hHpQtVVntBKN8tucG4tl0LALgFLbmZIgLgfhENI//NIwiY38+E0FFpYopT7hJxHxWZb61S1aUn10YveNTZ67FONJuu8OJcoBNN2Ivh3Xx6RrKyMnNc86LK91QyCg9ObnwAaws8UtzeltIhqyMSWix7CZYh1hLMKkpgzAZ4UB8xBu8tpUXEDqBmpGmIV6NfKWLi/qZwNogMPGk3yMppuMFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AsjD3KpeRoRx/RvJ/sdk0XiOVjzilbu5zBlNctPBEzM=;
 b=HFx61G+VfACzHlP6OaC1u5N7ZF9wjcTlVz7/G+LVANvZkoVnHYSgAkg3dvQ3cxfm2Z3RO7W02H3JF+4UBFtwkQEuBhlyh2qBJrnnU3xL01WaVmmoLG6Sz+kfc8fbtP+jqO5p1XywCHmBgZpNzMYpJd/CqY30O/0Lui3mYeRdXMPEx5Bwf/LRZne2lmOKFJ84njM9+19FA7u9CWva/GLpBVD+iQv3bvuaNZk1tBmoPsY9ix+P5KkAYmwI8LHwCc1zu5O9MjgRxvjc4YwA6P3Ywq9hbC8JG9QdmxpzXUVlUSpydW0idbj9uag3eQx6k4pRz3mUe1JGGGXkTv78lcmAyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AsjD3KpeRoRx/RvJ/sdk0XiOVjzilbu5zBlNctPBEzM=;
 b=iGeoKFC+ycNqfKRES05nxxoBJNuORmYp4FCKin6Lr2xFd6f7JAjGTOG7s3kuZhkkcfCyY6ZXGLMsClweKsJT30yhQypbFi7a71jFBnOk96Nygd+jjOS3Xn/BKCeWA3/KSOX/1uy+rPl+mAhuadZuaBGaYf+K2xefZRAEeF0/rws=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AS8PR10MB6996.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5a7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Thu, 18 Apr
 2024 08:12:36 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3704:5975:fae0:7809]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3704:5975:fae0:7809%6]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 08:12:36 +0000
Message-ID: <dc0b3a4e-b52d-4dc4-95a7-8e841c0ad1d2@prevas.dk>
Date: Thu, 18 Apr 2024 10:12:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] flock: add support for using fcntl() with open file
 description locks
To: Masatake YAMATO <yamato@redhat.com>
Cc: util-linux@vger.kernel.org, kzak@redhat.com
References: <20240417100948.75817-1-rasmus.villemoes@prevas.dk>
 <20240418.023354.1867217317145795622.yamato@redhat.com>
Content-Language: en-US, da
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <20240418.023354.1867217317145795622.yamato@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0055.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::18) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AS8PR10MB6996:EE_
X-MS-Office365-Filtering-Correlation-Id: cfcfb67b-13a2-4671-bc11-08dc5f7f4e3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	byzBJg8sJuP5nw8jv8fClgn0H7u4lpE12nfq1cDMC+pRvEpGmWWfX2Zje2G9HDubVSzdAylpAEUsHvRj9IHyzSdC3e+olrkvVPdf6oJ4eqGA/K/GnYRaCm8r3mesMuDS5vCI/dAHHAdmtaHQqXMvY6Lhl0zafy+2gig8R7ZAAuVfev58Mp6O1YO5jBlyrIsUWjbhth4gAgVDcYMqo1X+Uti5h6pooPlBIS0qfdd4brVyvLkeeavHEFQWTYW3rdEw0mrr6DyRRxXD54kNiJ7UcXWUCHPRUpZO79Zg4Tsdz/wYataQZFCfssmMYXlOnPDY13RLuIikT1kke8RhnDY8CRN+oiIZZz7lzuZ38mrTsRaq8h/ogzrVLISoHCB/RuUmCpA8lI54IKFG+vffZsRVUt+9eb9PmZ2OgjcAa6zmyb60zBzBBJDHQPxTUjxEpplwTZX54u67S1yf0fji+kyNiZOZn/s0hkKKQmWbzHh2cZBEzmxlOkjEJ6BEQGDAcBhiHc7ZAnToX0NzswQjwGS3UMvecsVPjrq9Eq5voGsOQMH93XbMyp5IfUjQHAWRrQh7ZZ/Q+aCE7FAm9neaGj76VUnErpXQ0UyrZaZlhNYebB3WTZ7VKyNCGhc/ExI7cj1OOGXTL0GwRO2cQdtrLIfq+3I6R3o9h3Kfnid1YpFDHxs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Nmc1T0VzRStYbnhkeURuNS9ta1ZCZkJ5YmIzRUc4V1IrQmIzYUxuc2FkRXZS?=
 =?utf-8?B?SE1yK0ZucHdRSjliRjE0TTJRb3RwSzBOZ0ZTQ3lyYmtjNnN3U2tRWUhObFRu?=
 =?utf-8?B?b2YrVmJGMVhpdUNKWGlrTVNsRzJoTzZKZTlNMS9MTXhreFJrbThXZDMxNUNi?=
 =?utf-8?B?Wlc5T0FYSGFSL3o4UUVaWU00MTNKdk9hcXN2cjBpNUw3Tmo3UE1QUmhSL1VI?=
 =?utf-8?B?RVZVZVpXWUVpQklCUitTUEhQT3NYd1RvN0FMNWZwTTVFTmNwNG5uS2dCcXNP?=
 =?utf-8?B?YmNLRnhqWnhocEpIeHVLWmVlRVBSdjEzTVRTbU1QNVg1b095MS9zRDJ2TGl6?=
 =?utf-8?B?VVFmRzQ2S1J6T1NyNEd4d0JEb0tLN1FZQU5TSTNwUWhRNm1vMjluTmpTT29z?=
 =?utf-8?B?cjJVVDlHVnNPN2V6TnF4c0s1d0hMWi9lR0RqUHVWNXdFU01JME4vNWF0bGlv?=
 =?utf-8?B?YzNYWmpCK0c3S2FXVUMrQlppZW15cEMxck1YR3l3dzljOXVZUXUySVFNZXZE?=
 =?utf-8?B?eVJpaHR5Tm15SDlYeUhRVjEzMHFYMXU0UTNSaEJ6aGFlVnVETW5HR0drODlx?=
 =?utf-8?B?SmxncDdZK0E0NmpVWE5OdE5xZmxiK2M0R0JGcTZ1MXU4SGlZblREb1pKdCtO?=
 =?utf-8?B?TVF0Wm0rUktUdDNPd0dvK1daakpZREpPVzk0MGZEMDVEWmloYW0xdmtpSnFn?=
 =?utf-8?B?K1Z5Sk9FQUk2VUQvRHc1SUpINTcvUGZEMW5uS2VsbmprZ2MwUVdrUVJSL0pN?=
 =?utf-8?B?M3pZY1RhT0YwcVNaVHdmcE1MYzNKTUJqTWkzRHRFZjU3ZE5ubHFFN0ZEYnpL?=
 =?utf-8?B?dzdNRTN0THZrWHV3WXpBUEN6WEkxWHJTYVNGTjhDZnFNTmgwbnZnZHdwV0dq?=
 =?utf-8?B?dmN2SjhYQllzUm1DWDVBTHl2SlFhUkhWVGFuc1VNYno1c3d1VmMxUzVoNmRT?=
 =?utf-8?B?cDJZWDVmazJ1UVpJeEhlMEZPZWhJUWZLblc0M1c0dEdqd2w3VmdSZldBU3pi?=
 =?utf-8?B?RzZXMEtGbjdobEV1UE1UbkFyb25XZ0czRkNBRHd0RHhqeVJZeFVwdW1rS3Y5?=
 =?utf-8?B?WFRwSFFIUzlOdWMzRVFWMzhCSlE3NnBiUFdQQkxXUWxpeGQ5d0hTMTE1MGt5?=
 =?utf-8?B?dDlnWW9nVmJxVkZDUjJpUERwRVlPZm9JajJJcG5aZmZRSDlGM3pTMTNVcWpV?=
 =?utf-8?B?RzhiMmpzODNSL0xIYW1PbjJQYXFHb3FSYnAzWGU2M0d6MkQxaE9rZ0g4cHFM?=
 =?utf-8?B?Vk5PaUlibmk3bE96QlkzTFJkWTNVbTIyNzFsZmE4VGdJdERXZkNvWDg3RVdu?=
 =?utf-8?B?Mnk5ZGh2UzJYRU5yOS94Q1R4ZHhzRFJCSTgvNmxpQzdubFlKNVZTVURWVTFX?=
 =?utf-8?B?RGdHVWRTT05DYXZDaXE2cnllZmdDUlFMZ1gyUlZmV0JLa1lLZ0ZyUDRLN3Ur?=
 =?utf-8?B?YWxoOXVwUjBzK3ZhcENQUklDaFp2QmU3UFVVenIzTkpnVkFNWkpHVjZnMUNr?=
 =?utf-8?B?dUFtRGRJSTAyclpkVXpwbTJiNUpvMFNNSWtFK0hoUXhodWwvTitXTGJpbG5Z?=
 =?utf-8?B?UkgyYU5FekJXTjNOcVlhVFNDQnBuSDFJdU1rd3FyTjdFb3hxY012Q0t6M0U0?=
 =?utf-8?B?bmhqNEU2dEZCVFFySHVZbkdvTFk3U2dLKzR4K3ExbDhnNllFeEJCaEEzYXpa?=
 =?utf-8?B?ZG12S0crUXVtQVphcVhFSC8vNXZJUFFHWlM1Mm9iVVllNjgvb0dXMnljZTNR?=
 =?utf-8?B?OWdmVW9WSk94N0lFZmthdWowVjJONVJMYUFOSjJWNS85ajRvajdqRmRKb3VJ?=
 =?utf-8?B?Y2FqcURzOHdmVk83K25yU005VjV3dXBNaHhKQVdTZEFweDB3c3ZiSVlNK1hV?=
 =?utf-8?B?U3AyVisxQkxYRkJWbDNPY2Q1eDE3dVVva2xYNStwaFg4T1FLT0E4Zm90bnJl?=
 =?utf-8?B?S0orcCtDWU9ZYjcySmY4REYvbW9sLzE1cjdUY0Zab1JJbTZET2RmUjlGTGsx?=
 =?utf-8?B?MGpMKzJuSUMrUlAwWDFSUWF6a2ljc010SUM2L2tSV0pRaDU4YU5ObERDWnhi?=
 =?utf-8?B?RjhFSDFJSGdxRG5wb21TRllQQTI1LzZOb3l5Q1dQQ1dSKzBkeFdCQURHMFdZ?=
 =?utf-8?B?aEJHQmN0SS94NXNIVENSTDh2ekdOQ0V1RzBDZXM1WjdhZGU1MllxL0ViczEw?=
 =?utf-8?B?eWc9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: cfcfb67b-13a2-4671-bc11-08dc5f7f4e3e
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 08:12:35.9628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 94WNYJh+Dna4jl6oEG+QyHzHX4qcSXfh0ZSvzx9sBOezBc0ztEPUeW8cZU8Y2tikYEaVDaOZByDusySllaNaf/IlFH/viPU8w6sZxPnDBkY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6996

On 17/04/2024 19.33, Masatake YAMATO wrote:
>> Currently, there is no way for shell scripts to safely access
>> resources protected by POSIX locking (fcntl with the F_SETLK/F_SETLKW
>> commands). For example, the glibc function lckpwdf(), used to
>> protect access to the /etc/shadow database, works by taking a
>> F_SETLKW on /etc/.pwd.lock .
>>
>> Due to the odd semantics of POSIX locking (e.g. released when any file
>> descriptor associated to the inode is closed), we cannot usefully
>> directly expose the POSIX F_SETLK/F_SETLKW commands. However, linux
>> 3.15 introduced F_OFD_SETLK[W], with semantics wrt. ownership and
>> release better matching those of flock(2), and crucially they do
>> conflict with locks obtained via F_SETLK[W]. With this, a shell script
>> can do
>>
>>   exec 4> /etc/.pwd.lock
>>   flock --fcntl-ofd 4
>>   <access/modify /etc/shadow ...>
>>   flock --fcntl-ofd --unlock 4 # or just exit
>>
>> without conflicting with passwd(1) or other utilities that
>> access/modify /etc/shadow.
>>
>> The option name is a bit verbose, and no single-letter shorthand is
>> defined, because this is somewhat low-level and the user really needs
>> to know what he is doing.
>>
>> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
>>
>> ---
>>
>> Both my autotools and meson fu are weak to non-existing, so I don't
>> know if I've written the "test if the header exposes this macro"
>> correctly.
>>
>> I'm not at all married to the option name. I also considered just
>> making it --fcntl, with the possiblity of making that grow an optional
>> argument (for example --fcntl=posix with plain --fcntl being an alias
>> for --fcntl=ofd) should anyone ever figure out a use for the plain
>> F_SETLK, perhaps just for testing.
>>
>>
>>  configure.ac      |  6 +++++
>>  meson.build       |  3 +++
>>  sys-utils/flock.c | 60 +++++++++++++++++++++++++++++++++++++++++++++--
>>  3 files changed, 67 insertions(+), 2 deletions(-)
> 
> You may have to update sys-utils/flock.1.adoc and the completion rule bash-completion/flock
> when adding a new optoin.

I will send a separate patch with that once the option naming is settled
and the concept itself is accepted (not necessarily applied to master).

>>  code = '''
>>  #include <time.h>
>>  #if !@0@
>> diff --git a/sys-utils/flock.c b/sys-utils/flock.c
>> index 7d878ff81..40751517d 100644
>> --- a/sys-utils/flock.c
>> +++ b/sys-utils/flock.c
>> @@ -70,6 +70,9 @@ static void __attribute__((__noreturn__)) usage(void)
>>  	fputs(_(  " -o, --close              close file descriptor before running command\n"), stdout);
>>  	fputs(_(  " -c, --command <command>  run a single command string through the shell\n"), stdout);
>>  	fputs(_(  " -F, --no-fork            execute command without forking\n"), stdout);
>> +#ifdef HAVE_FCNTL_OFD_LOCKS
>> +	fputs(_(  "     --fcntl-ofd          use fcntl(F_OFD_SETLK) rather than flock()\n"), stdout);
>> +#endif
>>  	fputs(_(  "     --verbose            increase verbosity\n"), stdout);
>>  	fputs(USAGE_SEPARATOR, stdout);
>>  	fprintf(stdout, USAGE_HELP_OPTIONS(26));
>> @@ -126,6 +129,38 @@ static void __attribute__((__noreturn__)) run_program(char **cmd_argv)
>>  	_exit((errno == ENOMEM) ? EX_OSERR : EX_UNAVAILABLE);
>>  }
>>  
>> +static int flock_to_fcntl_type(int op)
>> +{
>> +        switch (op) {
>> +                case LOCK_EX:
>> +                        return F_WRLCK;
>> +                case LOCK_SH:
>> +                        return F_RDLCK;
>> +                case LOCK_UN:
>> +                        return F_UNLCK;
>> +                default:
>> +			errx(EX_SOFTWARE, _("internal error, unknown operation %d"), op);
>> +        }
>> +}
> 
> Don't you need wrap flock_to_fcntl_type with #ifdef HAVE_FCNTL_OFD_LOCKS/#endif?

Well, the constants mentioned here are the same as used with posix
locking, and have been in glibc and kernel headers since forever. Only
the F_OFD_* ones are "newish". So I don't think this needs guarding due
to non-existence of the symbols. But I might need to guard the whole
function (or mark it maybe-unused) to avoid a defined-but-not-used warning.

I wasn't even sure if I actually needed a configure check and HAVE_*
guard at all; 3.15 is 10 years old by now, but I couldn't find any
mention of the oldest glibc/kernel that util-linux is supposed to build
against. Karel?

Rasmus

