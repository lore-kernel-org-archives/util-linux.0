Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.18]:63194 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751281AbdFXLmK (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sat, 24 Jun 2017 07:42:10 -0400
Subject: Re: [PATCH 3/5] misc: fix more strutils related exit codes
To: J William Piggott <elseifthen@gmx.com>, util-linux@vger.kernel.org
References: <1498164224-13549-1-git-send-email-sweet_f_a@gmx.de>
 <1498164224-13549-4-git-send-email-sweet_f_a@gmx.de>
 <e50780b9-ba85-5e7e-11cb-2db12c4c5bef@gmx.com>
From: =?UTF-8?Q?R=c3=bcdiger_Meier?= <sweet_f_a@gmx.de>
Message-ID: <a76d9de4-253f-0d0a-914c-32caeedba330@gmx.de>
Date: Sat, 24 Jun 2017 13:42:07 +0200
MIME-Version: 1.0
In-Reply-To: <e50780b9-ba85-5e7e-11cb-2db12c4c5bef@gmx.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



On 06/23/2017 07:28 PM, J William Piggott wrote:
> 
> 
> On 06/22/2017 04:43 PM, Ruediger Meier wrote:
>> From: Ruediger Meier <ruediger.meier@ga-group.nl>
>>
>> Found by grep:
>>
>> grep -l "\bEXIT_\|exit *( *[0-9][0-9] *)\|strutils\.h" $(grep -L \
>>      strutils_set_exitcode  $(git grep -l "_EX_\|FINDFS_\|BLKID_EXIT\|EX_USAGE" -- "*.c"))
>>
>> The Command shows also some false positives (fstrim.c,
>> context_mount.c, ...)
>>
>> Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
>> ---
>>   disk-utils/fsck.cramfs.c | 2 ++
>>   disk-utils/fsck.minix.c  | 2 ++
>>   disk-utils/mkfs.cramfs.c | 2 ++
>>   disk-utils/mkfs.minix.c  | 2 ++
>>   sys-utils/flock.c        | 2 ++
>>   sys-utils/hwclock.c      | 2 ++
>>   sys-utils/mount.c        | 2 ++
>>   7 files changed, 14 insertions(+)
>>
> 
>   --- >8
> 
>>   
>> diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
>> index 5433cd0..325106a 100644
>> --- a/sys-utils/hwclock.c
>> +++ b/sys-utils/hwclock.c
>> @@ -1326,6 +1326,8 @@ int main(int argc, char **argv)
>>   	};
>>   	int excl_st[ARRAY_SIZE(excl)] = UL_EXCL_STATUS_INIT;
>>   
>> +	strutils_set_exitcode(EX_USAGE);
>> +
>>   	/* Remember what time we were invoked */
>>   	gettimeofday(&startup_time, NULL);
>>
> 
> If we keep this it needs to be: #if defined(__linux__) && defined(__alpha__)

I think the non-needed strutils_set_exitcode() call on non-alpha doesn't hurt
but would ensure that it stays correct if someone would use more *_or_err
functions in future. Otherwise we should also have

#if defined(__linux__) && defined(__alpha__)
# include "strutils.h"
#endif

In general I don't really like that we have soo many exiting functions at all.
They all should take an exit_code argument at least. Like errx() or
errtryhelp(). On average this would look less ugly than all these hacky
exit code re-defines.


> I think the default EXIT_FAILURE is fine for this case.
> 


