Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:50486 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751349AbdFYVj7 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sun, 25 Jun 2017 17:39:59 -0400
Subject: Re: [PATCH 3/5] misc: fix more strutils related exit codes
To: =?UTF-8?Q?R=c3=bcdiger_Meier?= <sweet_f_a@gmx.de>,
        util-linux@vger.kernel.org
References: <1498164224-13549-1-git-send-email-sweet_f_a@gmx.de>
 <1498164224-13549-4-git-send-email-sweet_f_a@gmx.de>
 <e50780b9-ba85-5e7e-11cb-2db12c4c5bef@gmx.com>
 <a76d9de4-253f-0d0a-914c-32caeedba330@gmx.de>
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <6ceeab78-c19e-9b48-0abd-80b0a6c6624d@gmx.com>
Date: Sun, 25 Jun 2017 17:39:51 -0400
MIME-Version: 1.0
In-Reply-To: <a76d9de4-253f-0d0a-914c-32caeedba330@gmx.de>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



On 06/24/2017 07:42 AM, Rüdiger Meier wrote:
> 
> On 06/23/2017 07:28 PM, J William Piggott wrote:
>>
>> On 06/22/2017 04:43 PM, Ruediger Meier wrote:
>>> From: Ruediger Meier <ruediger.meier@ga-group.nl>
>>>

>>   --- >8
>>
>>
>>>   diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
>>> index 5433cd0..325106a 100644 --- a/sys-utils/hwclock.c
>>> +++ b/sys-utils/hwclock.c
>>> @@ -1326,6 +1326,8 @@ int main(int argc, char **argv)
>>>      
>>> };
>>>      
>>> int excl_st[ARRAY_SIZE(excl)] = UL_EXCL_STATUS_INIT;
>>>   +   strutils_set_exitcode(EX_USAGE);
>>> +
>>> /* Remember what time we were invoked */
>>> gettimeofday(&startup_time, NULL);
>>>
>>
>> If we keep this it needs to be: #if defined(__linux__) &&
>> defined(__alpha__)
>>
> 
> I think the non-needed strutils_set_exitcode() call on non-alpha
> doesn't hurt but would ensure that it stays correct if someone would
> use more *_or_err functions in future.  Otherwise we should also have
> 
> #if defined(__linux__) && defined(__alpha__)
> # include "strutils.h"
> #endif
> 
> In general I don't really like that we have soo many exiting functions
> at all.

It seems over engineered to me.

I don't want to block your work, so I withdraw my comments. After this
set is committed I'll submit a patch to remove strutils from hwclock.

> They all should take an exit_code argument at least.  Like
> errx() or errtryhelp().  On average this would look less ugly than all
> these hacky exit code re-defines.
> 
> 
>> I think the default EXIT_FAILURE is fine for this case.
>>
> 
> 
> -- To unsubscribe from this list: send the line "unsubscribe
> util-linux" in
> 
> the body of a message to majordomo@vger.kernel.org
> 
> More majordomo info at http://vger.kernel.org/majordomo-info.html
> 
> 
