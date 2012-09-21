Return-Path: ludwig.nussel@suse.de
Message-ID: <505C1D38.2090005@suse.de>
Date: Fri, 21 Sep 2012 09:54:32 +0200
From: Ludwig Nussel <ludwig.nussel@suse.de>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
Cc: =?ISO-8859-1?Q?P=E1draig_Brady?= <P@draigBrady.com>,
        Werner Fink <werner@suse.de>,
        =?ISO-8859-1?Q?Thomas_B=E4chler?= <thomas@archlinux.org>,
        util-linux@vger.kernel.org, Dave Reisner <d@falconindy.com>,
        Tobias Powalowski <tpowa@archlinux.org>
Subject: Re: [su] New su utility messes with my PATH
References: <50547FE7.204@archlinux.org> <50549411.9000302@draigBrady.com> <20120920094330.GC16499@x2.net.home>
In-Reply-To: <20120920094330.GC16499@x2.net.home>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

Karel Zak wrote:
> On Sat, Sep 15, 2012 at 03:43:29PM +0100, Pádraig Brady wrote:
>> On 09/15/2012 02:17 PM, Thomas Bächler wrote:
>>> I found what I think is absolutely unexpected behaviour in the new su
>>> utility. It seems to have been introduced by commit a6fdd3f8.
>>>
>>> It is about /sbin and /usr/sbin being in the path: Whenever you switch
>>> to a non-root user, they are removed from the path, and when you switch
>>> to root, they are added. I find it completely unexpected that su (when
>>> not running with -l) messes with my environment at all.
>>>
>>> Commands like
>>>  PATH=... su -c "cmd" user
>>> do not work as expected.
>>>
>>> In my opinion, when you wish your path (or anything in the environment)
>>> to change you should a) use -l to start a login shell or b) configure
>>> your scripts to take care of it.
>>>
>>> I propose to revert the mentioned patch. Opinions?
>>
>> Ouch, I agree.
>> su shouldn't be messing with PATH at all IMHO.

Well, su is such a mess that you better not make any assumptions about
it. Avoid su if you can.

> It's Suse patch, I guess there is/was any reason for the patch
> 
>         commit a6fdd3f8125be23930d955c2bc6b7a46cdaf8a12
>         Author: Werner Fink <werner@suse.de>
>         Date:   Tue Aug 17 09:09:55 2010 +0200
> 
>         make sure /sbin resp /usr/sbin are in PATH
> 
> 
> Werner, Ludwig? What about to revert the patch?

Personally I don't really mind. I don't know the background of the patch
though. IMO using 'su' instead of 'su -' is broken anyways so making the
former less convenient may help teaching people to use 'su -' instead.

cu
Ludwig

-- 
 (o_   Ludwig Nussel
 //\
 V_/_  http://www.suse.de/
SUSE LINUX Products GmbH, GF: Jeff Hawn, Jennifer Guild, Felix Imendörffer, HRB 16746 (AG Nürnberg) 
