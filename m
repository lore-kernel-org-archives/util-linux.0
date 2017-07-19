Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:63696 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751560AbdGSB0A (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 18 Jul 2017 21:26:00 -0400
Subject: Re: [PATCH 2/2] hwclock: fix regression from c3ae785
To: Ruediger Meier <sweet_f_a@gmx.de>
References: <b8d24f10-1bea-aa80-0a28-9f573dd81d2a@gmx.com>
 <13448500-dbe1-b7f8-3514-651d448f00d1@gmx.com>
 <201707182233.42270.sweet_f_a@gmx.de> <201707182246.06679.sweet_f_a@gmx.de>
Cc: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <65e0a627-81ec-5cfa-fc2b-fd5946f4a5a9@gmx.com>
Date: Tue, 18 Jul 2017 21:25:44 -0400
MIME-Version: 1.0
In-Reply-To: <201707182246.06679.sweet_f_a@gmx.de>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



On 07/18/2017 04:46 PM, Ruediger Meier wrote:
> On Tuesday 18 July 2017, Ruediger Meier wrote:
>> On Tuesday 18 July 2017, J William Piggott wrote:
>>> hwclock --get foobar
>>> hwclock: 3 too many arguments given
>>>
>>> Fixed:
>>>
>>> hwclock --get foobar
>>> hwclock: 1 too many arguments given
>>>
>>> Signed-off-by: J William Piggott <elseifthen@gmx.com>
>>> ---
>>>  sys-utils/hwclock.c | 5 +++--
>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
>>> index 9745158..9b313cf 100644
>>> --- a/sys-utils/hwclock.c
>>> +++ b/sys-utils/hwclock.c
>>> @@ -1448,9 +1448,10 @@ int main(int argc, char **argv)
>>>  		}
>>>  	}
>>>
>>> -	if (argc > optind) {
>>> +	argc -= optind;
>>> +	if (argc > 0) {
>>>  		warnx(_("%d too many arguments given"), argc);
>>
>> Oops, sorry for this regression ;)
> 
> BTW I removed
> 
> -       argc -= optind;
> -       argv += optind;
> 
> only where I thought *both* are not used later. In this case I've made a 
> mistake. If you really want to keep "argc -= optind" then you could 
> also re-add the unused "argv += optind" to avoid confusing other 
> code-readers in future. Making the clang-analyzer happy is not the most 
> important thing.
>

Including it is confusing; it doesn't do anything.

>> Anyways, at least for me "1 too many arguments given" does not sound
>> really understandable.  Maybe we don't need that number at all!?
>>
>>> -		errtryhelp(EXIT_FAILURE);
>>> +		errtryhelp(EX_USAGE);
>>
>> What about changing also the last other errtryhelp(EXIT_FAILURE) to
>> EX_USAGE, 5 lines above?
>>
>>>  	}
>>>
>>>  	if (!ctl.adj_file_name)
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe
>>> util-linux" in the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe util-linux"
>> in the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
