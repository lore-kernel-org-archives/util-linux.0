Return-Path: sweet_f_a@gmx.de
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
 <b8cf693f-a1d9-ba25-642a-056ed6fc717b@gmx.de>
 <20170613134115.2bko6uejkrna65j6@ws.net.home>
From: =?UTF-8?Q?R=c3=bcdiger_Meier?= <sweet_f_a@gmx.de>
Message-ID: <35f6001e-ab3e-e96d-c872-67869ec8c3d6@gmx.de>
Date: Tue, 13 Jun 2017 16:52:20 +0200
MIME-Version: 1.0
In-Reply-To: <20170613134115.2bko6uejkrna65j6@ws.net.home>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <util-linux.vger.kernel.org>

On 06/13/2017 03:41 PM, Karel Zak wrote:
> On Tue, Jun 13, 2017 at 03:03:12PM +0200, Rüdiger Meier wrote:
>>
>>
>> On 06/13/2017 02:51 PM, Karel Zak wrote:
>>> On Tue, Jun 13, 2017 at 01:16:57AM +0200, Rüdiger Meier wrote:
>>>>>> BTW just for cosmetics. Maybe we should rename UL_FALLTHROUGH to
>>>>>> __ul_fallthrough
>>>>>> like we have already __ul_calloc_size. IMO it would look more obvious to the
>>>>>> reader.
>>>>>
>>>>> I don't have strong opinion about that, changed to one you proposed.
>>>>
>>>> Thanks, let's see whether Karel likes this attribute at all ;)
>>>
>>> Hmm...
>>>
>>>    I don't like "meta-programming" where language keywords are
>>>    replaced by local macros, for example we have fallback (in c.h) for all
>>>    __attribute__ rather than define local macro for all attributes.
>>>
>>>      __attribute__((fallthrough))
>>>
>>>    should be fine on non-__GNUC__ as in this case __attribute__ is empty
>>>    macro (see c.h).
>>>
>>>    Yes, __ul_fallthrough seems better, and __attribute__((fallthrough))
>>>    would be the best :-)
>>>
>>>    It's strange if clang will use a different syntax for the same
>>>    things. IMHO it would be better to ignore clang for this attribute.
>>
>> Yes, Sami's last version just ignores clang. Seems that the different syntax
>> was for C++ only.
>>
>> So branch 2017wk23 from git@github.com:kerolasa/lelux-utiliteetit.git is the
>> last version for merging.
> 
> Cool, I see.
> 
> Now I read something about gcc and it seem it's able to recognize and
> use comments, so  __attribute__((fallthrough)) is unnecessary.
> 
> The default -Wimplicit-fallthrough setting is '3' and it means "parse
> comments"
> So, do we really need this patch? ;-)
> 
>      https://developers.redhat.com/blog/2017/03/10/wimplicit-fallthrough-in-gcc-7/
> 
> and man gcc man page:
> 
>      -Wimplicit-fallthrough=0 disables the warning altogether.
>      -Wimplicit-fallthrough=1 matches .* regular expression, any comment is used as fallthrough comment.
>      -Wimplicit-fallthrough=2 case insensitively matches .*falls?[ \t-]*thr(ough|u).* regular expression.
>      -Wimplicit-fallthrough=3 case sensitively matches one of the following regular expressions:
>          -fallthrough
>          @fallthrough@
>          lint -fallthrough[ \t]*
>          [ \t.!]*(ELSE,? |INTENTIONAL(LY)? )?
>          FALL(S | |-)?THR(OUGH|U)[ \t.!]*(-[^\n\r]*)?
>          [ \t.!]*(Else,? |Intentional(ly)? )?
>          Fall((s | |-)[Tt]|t)hr(ough|u)[ \t.!]*(-[^\n\r]*)?
>          [ \t.!]*([Ee]lse,? |[Ii]ntentional(ly)? )?
>          fall(s | |-)?thr(ough|u)[ \t.!]*(-[^\n\r]*)?
>      -Wimplicit-fallthrough=4 case sensitively matches one of the following regular expressions:
>          -fallthrough
>          @fallthrough@
>          lint -fallthrough[ \t]*
>          [ \t]*FALLTHR(OUGH|U)[ \t]*
>      -Wimplicit-fallthrough=5 doesn’t recognize any comments as fallthrough comments, only attributes disable the warning.
> 
> sounds all we need is to add  -Wimplicit-fallthrough=3 to ./configur
No, -Wimplicit-fallthrough=3 is what we have already now by default.
Just tested. Without doing anything "/* fallthrough */" disables the
warning. But Sami fixed also other comments and places without comments.

So we could simply use "/* fallthrough */" everythere.

Note, -Wimplicit-fallthrough=2 would be even more relaxed, e.g.
   /* Fallthrough because bla. */  would work too.

cu,
Rudi
