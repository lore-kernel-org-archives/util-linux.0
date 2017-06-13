Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:53376 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752078AbdFMND0 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 13 Jun 2017 09:03:26 -0400
Subject: Re: [PATCH 01/11] misc: fallthrough fixes
To: Karel Zak <kzak@redhat.com>
Cc: kerolasa@gmail.com, util-linux <util-linux@vger.kernel.org>
References: <20170608195215.1702-1-kerolasa@iki.fi>
 <20170608195215.1702-2-kerolasa@iki.fi> <201706091314.08008.sweet_f_a@gmx.de>
 <968790d0-c49c-538b-d034-ffcda9c20efc@gmx.de>
 <CAG27Bk3OEBrnGbrD+2tuxu-UGUjQXLB+TrsFLiQRvOtcns8FsQ@mail.gmail.com>
 <55d88bf2-3c67-4d79-984e-b16d6b835702@gmx.de>
 <CAG27Bk03PW7GWHdm5G0Xcu1LXbAXwebQyyvk3HoHx7hP8e-Bgg@mail.gmail.com>
 <4ae98acb-325d-39dd-faa9-2cdf8ce62c3e@gmx.de>
 <20170613125115.yq7a63ngzpk2hiod@ws.net.home>
From: =?UTF-8?Q?R=c3=bcdiger_Meier?= <sweet_f_a@gmx.de>
Message-ID: <b8cf693f-a1d9-ba25-642a-056ed6fc717b@gmx.de>
Date: Tue, 13 Jun 2017 15:03:12 +0200
MIME-Version: 1.0
In-Reply-To: <20170613125115.yq7a63ngzpk2hiod@ws.net.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



On 06/13/2017 02:51 PM, Karel Zak wrote:
> On Tue, Jun 13, 2017 at 01:16:57AM +0200, Rüdiger Meier wrote:
>>>> BTW just for cosmetics. Maybe we should rename UL_FALLTHROUGH to
>>>> __ul_fallthrough
>>>> like we have already __ul_calloc_size. IMO it would look more obvious to the
>>>> reader.
>>>
>>> I don't have strong opinion about that, changed to one you proposed.
>>
>> Thanks, let's see whether Karel likes this attribute at all ;)
> 
> Hmm...
> 
>   I don't like "meta-programming" where language keywords are
>   replaced by local macros, for example we have fallback (in c.h) for all
>   __attribute__ rather than define local macro for all attributes.
> 
>     __attribute__((fallthrough))
> 
>   should be fine on non-__GNUC__ as in this case __attribute__ is empty
>   macro (see c.h).
> 
>   Yes, __ul_fallthrough seems better, and __attribute__((fallthrough))
>   would be the best :-)
> 
>   It's strange if clang will use a different syntax for the same
>   things. IMHO it would be better to ignore clang for this attribute.

Yes, Sami's last version just ignores clang. Seems that the different syntax
was for C++ only.

So branch 2017wk23 from git@github.com:kerolasa/lelux-utiliteetit.git is the
last version for merging.

>   And I'm not sure if the change is compatible with coverity-scan where
>   comment line /* fallthrough */ is required, but this not so important
>   (coverity is maintained, so attribute will be supported one day...).
> 
>      Karel
> 
