Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:55441 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752708AbdIGUuN (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 7 Sep 2017 16:50:13 -0400
Subject: Re: [PATCH 0/1] Two changes before we go to rc
To: Karel Zak <kzak@redhat.com>
References: <e5219e08-60f7-d35d-c81c-64cb598c7e84@gmx.com>
 <20170905110005.jjcfq3rvch7jtqhi@ws>
From: J William Piggott <elseifthen@gmx.com>
Cc: util-linux@vger.kernel.org
Message-ID: <2072373a-a369-863d-40d7-ebf4abb3fe78@gmx.com>
Date: Thu, 7 Sep 2017 16:50:00 -0400
MIME-Version: 1.0
In-Reply-To: <20170905110005.jjcfq3rvch7jtqhi@ws>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



On 09/05/2017 07:00 AM, Karel Zak wrote:
> On Sun, Sep 03, 2017 at 09:14:25PM -0400, J William Piggott wrote:
>>
>> With the recent comment regarding the pending rc, I'd like to make
>> two small string changes before we send them off for translation.
>>
>> During this cycle all of hwclock usage strings have been changed, but
>> I still do not like the debug description.
>>
>> I looked at what the other utils are using; there are only two others
>> with a debug option and their strings are no better for hwclock, IMO.
>> So I looked at usage strings for the verbose option. In 27
>> occurrences there are 15 different descriptions. The most recent one,
>> written by Karel, I think is good for both debug (except uuidd) and
>> verbose (it could be made a usage constant to reduce 17 strings to
>> 1). It is: "display more details"
> 
> OK, merged.
> 
> Frankly, I don't like --debug option. It's better to use --verbose for
> this purpose for new tools.
> 
> From my point of view debugging is something extremely talkative with
> many additional information and should be implemented with some
> instrument to control what and how to debug. This is reason why I
> prefer *_DEBUG= env. variables. For example LIBMOUNT_DEBUG=<what>.

True, one exception may be when it is a debug 'mode'; like uuidd's which
prevents daemonizing. Although that is probably a bad choice too. I
think most use nodetach, nofork, or daemon options for that. hwclock has
a debug mode at level 10, but neither debug levels nor its debug mode
are documented. IMO, they should not be documented.

> 
> Anyway, already supported command line options should be supported
> "forever" (if possible); hwclock --debug is nice example. It's used by
> many many users.

Other unfortunate options for hwclock are epoch and date. So instead of:
hwclock --set --date DATE
hwclock --predict --date DATE
hwclock --setepoch --epoch YEAR

It should have been:
hwclock --set DATE
hwclock --predict DATE
hwclock --setepoch YEAR

As you say, we are stuck with these options. They could be depreciated
and eventually removed, but it's probably not worth the hassle.

When refactoring is complete, and we likely have an entirely new code
base, we could rename the command again and use whatever options we
like. That's probably not worth the hassle either.

 8< ...
 
> 
> Note that the missing thing for the next release is Rudi's
> coreutils-like options arguments:
> 
>  https://www.spinics.net/lists/util-linux-ng/msg14396.html
> 
> We have 14 days (to 19th) to implement it,

My thoughts were:

 It was Rudi's idea, so I assumed he wanted to implement it.

 It doesn't look to me like this can be done with sed alone. It seems
 like it would take too long to finish for this cycle?

 I didn't think all of the details had been hammered out yet, like:

 * ul currently uses the same argument notation for usage and docs.
   coreutils usages and docs both use their notation style.
   So won't this switch mean changing all of the docs as well?

 * Your final example was:

> after change:
>    -e, --exclude MAJOR     exclude specified devices (see below)
>    -I, --include MAJOR     show only specified devices (see below)
>    -o, --output COLUMNS    output columns (see below)
>    -x, --sort COLUMN       sort output by column
> 
>  The MAJOR command separated list of the device major numbers. The
>  ramdisk devices are excluded by default.
> 
>  Available COLUMNS:
>    NAME  device name
>    KNAME  internal kernel device name
>    ...

Coreutils starts the details sections with the magic argument. See
'split --help' and 'date --help'. I think that is better because they
align and you don't have to look for them.

IMO, coreutils usage is too verbose and busy; it should be a quick
reference for users that already understand the command and should be as
terse as possible. Otherwise they probably need to read the manual.

Perhaps the magic argument name should not be too abstract(MAJOR) and
its details should be a simple example list? Something like:

   -e, --exclude DEV       exclude specified devices (see below)
   -I, --include DEV       show only specified devices (see below)
   -o, --output COLUMNS    output columns (see below)
   -x, --sort COLUMN       sort output by column

DEV: 1,2,3 ... major_dev_number

COLUMNS: NAME,KNAME, ...

The linkage between the magic argument and its details section should be
strong enough to not require any more explanation.

I think mixed case for section headers is fine:
Usage:
Options:
SIZE:
...


> the original plan is:
> 
>    - Sep 12 -- feature freeze, no invasive changes allowed (aka rc1)
>    - Sep 19 -- strings freeze, translations (aka rc2)
>    - Sep 26 -- v2.31
> 
> 
> but I'm going to sailing in France next week, so rc1 will be later.

Have a great time! Redhat has generous vacation packages:)

> 
>     Karel
> 
