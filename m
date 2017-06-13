Return-Path: sweet_f_a@gmx.de
Subject: Re: [PATCH 01/11] misc: fallthrough fixes
To: Karel Zak <kzak@redhat.com>
Cc: kerolasa@gmail.com, util-linux <util-linux@vger.kernel.org>
References: <201706091314.08008.sweet_f_a@gmx.de>
 <968790d0-c49c-538b-d034-ffcda9c20efc@gmx.de>
 <CAG27Bk3OEBrnGbrD+2tuxu-UGUjQXLB+TrsFLiQRvOtcns8FsQ@mail.gmail.com>
 <55d88bf2-3c67-4d79-984e-b16d6b835702@gmx.de>
 <CAG27Bk03PW7GWHdm5G0Xcu1LXbAXwebQyyvk3HoHx7hP8e-Bgg@mail.gmail.com>
 <4ae98acb-325d-39dd-faa9-2cdf8ce62c3e@gmx.de>
 <20170613125115.yq7a63ngzpk2hiod@ws.net.home>
 <b8cf693f-a1d9-ba25-642a-056ed6fc717b@gmx.de>
 <20170613134115.2bko6uejkrna65j6@ws.net.home>
 <35f6001e-ab3e-e96d-c872-67869ec8c3d6@gmx.de>
 <20170613200000.ravhgjs7kvqnhihq@ws.net.home>
From: =?UTF-8?Q?R=c3=bcdiger_Meier?= <sweet_f_a@gmx.de>
Message-ID: <3f62e452-cbd6-bbf1-6aa1-9ecd5ae66ff7@gmx.de>
Date: Tue, 13 Jun 2017 22:11:29 +0200
MIME-Version: 1.0
In-Reply-To: <20170613200000.ravhgjs7kvqnhihq@ws.net.home>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <util-linux.vger.kernel.org>

On 06/13/2017 10:00 PM, Karel Zak wrote:
> On Tue, Jun 13, 2017 at 04:52:20PM +0200, Rüdiger Meier wrote:
>>> sounds all we need is to add  -Wimplicit-fallthrough=3 to ./configur
>> No, -Wimplicit-fallthrough=3 is what we have already now by default.
>> Just tested. Without doing anything "/* fallthrough */" disables the
>> warning. But Sami fixed also other comments and places without comments.
>>
>> So we could simply use "/* fallthrough */" everythere.
> 
> Yes, that's what I mean (don't use the macro at all).
> 
> Sami, can you update the patch and replace __ul_fallthrough with
> /* fallthrough */ ?
> 
>      Karel
> 

I've used one sed command on Sami's patch and submitted via github
https://github.com/karelzak/util-linux/pull/456

cu,
Rudi
