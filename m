Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:43444 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755213AbeAHKWD (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 8 Jan 2018 05:22:03 -0500
Date: Mon, 8 Jan 2018 11:21:59 +0100
From: Karel Zak <kzak@redhat.com>
To: J William Piggott <elseifthen@gmx.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [v3 PATCH 00/11] Pull Request - changelog
Message-ID: <20180108102159.dyelg7kqp5tx3c3i@ws.net.home>
References: <4833b897-2192-86dc-f81b-e977d98b07b1@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4833b897-2192-86dc-f81b-e977d98b07b1@gmx.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jan 02, 2018 at 09:53:18AM -0500, J William Piggott wrote:
> Having not received any reply, I went ahead with the
> implementation, with one change involving Karel's original
> request for volunteers. Specifically, the first and last bullet
> points; which where:
> 
> * keep the current default "British Empire" behavior (Gregorian since
>   September 1752)
> 
> * later (after warning in release notes) we can make --gregorian as
>   the default
> 
> During implementation I considered these issues:
> 
> * to do that we'd be creating two new options --iso, and an
>   alias --gregorian; these would become non-functional once
>   they were made the default. Just like the current situation
>   with --one and --sunday.

It's not so unusual to have command line options for default behavior,
and it's good idea to use these options for example in scripts to be
independent on the current defaults.

> * this change is unlikely to affect downstream maintainers
> 
> * end users are the ones that may be caught out by it
> 
> * a release note warning that some future version of cal(1)
>   will change the default output is unlikely to reach the end
>   users.

I have no clue how many users care and read our ReleaseNotes, but
important is that they have opportunity to do that and they have
always time to adopt to changes. This is how I promised that this 
project will be maintained. 

> Indirectly, the current tests are broken. I think this
> supports some of the changes in this patch set:
> 
> The tests author seemed to believe that the -1 and -s options
> actually do something, despite the 'expected' output showing
> otherwise. While testing this patch set I thought the same
> thing; I tried to figure out what these two options do; which
> is nothing. I think this is good evidence to support removing
> them.

It's bug that -1/--one does nothing and this bug should be fixed. The
-s seems to set ctl->weekstart (and it would be probably more robust
to compare it with SUNDAY rather than with zero in code).

> The tests author also seems to believe that the -j option
> switches from the Gregorian calendar system to the Julian
> calendar system. Making comments to that affect and using it
> in tests involving the year 1752; a year which uses both
> calendar systems. I think this is good evidence to support
> renaming --julian to --ordinal.
> 
> If developers for the project are being confused by these
> options, than what chance do end users have? So that's my case
> for making these changes.

This is good point. I think the problem is that nowhere in the man
page has been described all the history and differences between
calendars.

> Also while pounding on cal(1), to see if these patches broke
> anything, I found a few other issues and fixed them as well.
> The man page was quite sparse, for example having no explanation
> for the -w argument, so rewrote much of it.

Thanks.

> v2 to v3 changelog
> * make proleptic Gregorian the default
> * extensive man page updates
> * rename --julian to --ordinal

Yes, this is mess...

> * add private (for now) --caesar option for exclusive Julian calendar

> * allow -w to accept its argument
> * update mutually exclusive options
> * add short versions for the new options
> * remove non-functional options
> * fix broken week calculations

Thanks!

> 
> v1 to v2 changelog
>  * fix typo in v1
>  * move REFORMATION_YEAR to the control struct
>  * add more about the --1752-reform option to man page
>  * add a second patch with minor style and wording changes

Thanks. I'll work on cal(1) in next days and use us much as possible
from your patches. 

Thanks for patience, I understand that you want to be a little bit
more aggressive with the changes and do it in the "best way" now, but
I'd like to be a little bit more conservative :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
