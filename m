Return-Path: util-linux-owner@vger.kernel.org
Received: from edony.tuxfamily.net ([212.85.158.2]:46081 "EHLO
	edony.tuxfamily.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754305AbaHZLdJ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 26 Aug 2014 07:33:09 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Tue, 26 Aug 2014 13:33:07 +0200
From: tnut@nutyx.org
To: =?UTF-8?Q?Stephan_M=C3=BCller?= <fruktopus@gmail.com>
Cc: <util-linux@vger.kernel.org>
Subject: Re: cfdisk, wrong interpretation of yes in non-english language
In-Reply-To: <53FC645E.5090600@gmail.com>
References: <d8263f3bc98929c82bbd0962ca77a159@nutyx.org>
 <53FC645E.5090600@gmail.com>
Message-ID: <c68ad99b4a25dcb54d691841c1f049a0@nutyx.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Le 2014-08-26 12:41, Stephan Müller a écrit :
> Am 26.08.2014 11:18, schrieb tnut@nutyx.org:
>> I'm building a new installer for the NuTyX distribution.
>>
>> If another language then english is choose as native language, some 
>> answer are wrong interpreted
>>
>> I think you should check both cases are wrong instead of one of them 
>> or do the test in the opposite way
>>
>> Here is a proposal of patch:
>>
>>
>> --- util-linux-2.25/disk-utils/cfdisk.c 2014-07-21 
>> 13:36:21.000000000 +0000
>> +++ util-linux-2.25-new/disk-utils/cfdisk.c     2014-08-25 
>> 18:52:17.000000000 +0000
>> @@ -1834,8 +1834,8 @@
>>                           buf, sizeof(buf));
>>
>>                 ref = 1;
>> -               if (rc <= 0 || strcasecmp(buf, "yes") != 0
>> -                           || strcasecmp(buf, _("yes")) != 0) {
>> +               if (rc <= 0 ||  (strcasecmp(buf, "yes") != 0
>> +                           && strcasecmp(buf, _("yes")) != 0)) {
>>                         info = _("Did not write partition table to 
>> disk");
>>                         break;
>>                 }
>>
>
> Why are both tests necessary at all? If NLS is disabled, both tests
> agree. If it is enabled, we should test against the gettext 
> translated
> version only (2nd strcasecmp).
>
>  regards
>
>  stephan
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" 
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

I did this test before, unfortunatly if the translation is wrong done 
asking yes or no it's not working without double check

regards

Thierry



