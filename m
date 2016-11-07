Return-Path: util-linux-owner@vger.kernel.org
Received: from mail.magicbluesmoke.com ([82.195.144.49]:40372 "EHLO
        mail.magicbluesmoke.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932119AbcKGPPl (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 7 Nov 2016 10:15:41 -0500
Subject: Re: [PATCH 1/1] fallocate: add insert range support
To: Fabian Frederick <fabf@skynet.be>, util-linux@vger.kernel.org
References: <1478461110-3423-1-git-send-email-fabf@skynet.be>
 <5ecce16e-669d-3023-3850-ebefeb2a183b@draigBrady.com>
 <356978831.44120.1478501460117.open-xchange@webmail.nmp.proximus.be>
Cc: Dongsu Park <dongsu.park@profitbricks.com>,
        Namjae Jeon <namjae.jeon@samsung.com>, Karel Zak <kzak@redhat.com>
From: =?UTF-8?Q?P=c3=a1draig_Brady?= <P@draigBrady.com>
Message-ID: <af26a23d-af69-66ea-c1c2-38e59cda9c64@draigBrady.com>
Date: Mon, 7 Nov 2016 15:15:38 +0000
MIME-Version: 1.0
In-Reply-To: <356978831.44120.1478501460117.open-xchange@webmail.nmp.proximus.be>
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 07/11/16 06:51, Fabian Frederick wrote:
> 
> 
>> On 06 November 2016 at 22:43 Pádraig Brady <P@draigBrady.com> wrote:
>>
>>
>> On 06/11/16 19:38, Fabian Frederick wrote:
>>> @@ -83,6 +88,7 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
>>>      fputs(USAGE_OPTIONS, out);
>>>      fputs(_(" -c, --collapse-range remove a range from the file\n"), out);
>>>      fputs(_(" -d, --dig-holes      detect zeroes and replace with holes\n"),
>>> out);
>>> +   fputs(_(" -i, --insert-range   insert a range in the file\n"), out);
>>
>> The description just repeats the option name.
>> What does insert a range mean exactly?
>> For example how does it compare to the clearly explained:
>>
>>   -z, --zero-range     zero and ensure allocation of a range
> 
> Maybe we could add a reference to "man 2 fallocate" for more details ?

We already do. We should provide some details though. How about:

  +   fputs(_(" -i, --insert-range   insert a hole at range, shifting existing data\n"), out);

thanks,
Pádraig
