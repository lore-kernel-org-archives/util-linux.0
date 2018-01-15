Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:52066 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966644AbeAONg1 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 15 Jan 2018 08:36:27 -0500
Date: Mon, 15 Jan 2018 14:36:22 +0100
From: Karel Zak <kzak@redhat.com>
To: J William Piggott <elseifthen@gmx.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [v3 PATCH 00/11] Pull Request - changelog
Message-ID: <20180115133622.v4wbionunsjj7bmy@ws.net.home>
References: <4833b897-2192-86dc-f81b-e977d98b07b1@gmx.com>
 <20180108102159.dyelg7kqp5tx3c3i@ws.net.home>
 <6635776f-9787-f05c-704f-e326808daa1d@gmx.com>
 <20180111090120.k6h5q2juw6gqemlc@ws.net.home>
 <95eb163b-218b-42ab-1b4b-4018cedd040e@gmx.com>
 <20180112105706.plx4c5puj6uxdofw@ws.net.home>
 <6ad5a25b-6095-38f7-65b3-bd2711a05ba3@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6ad5a25b-6095-38f7-65b3-bd2711a05ba3@gmx.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jan 14, 2018 at 09:02:26PM -0500, J William Piggott wrote:
> On 01/12/2018 05:57 AM, Karel Zak wrote:

> > Well, my mistake. I have thought about "rename --julian to --ordinal"
> > and errx(EXIT_FAILURE, ("use --ordinal, --julian has been deprecated."));
> > 
> > This change is too aggressive without ReleaseNotes warning.
> > 
>  
> I agree, it is aggressive.
> 
> Having considered your comments, I realize that my submissions are
> likely the wrong solutions. The reality is, the practice of calling
> 'ordinal Gregorian calendars' 'Julian calendars' is deeply entrenched;
> it's even in the POSIX standard. 
> 
> So, if we leave the --julian option as it is, what is the solution for
> the name collision. Use some made-up name for a Julian calendar system
> like --caesar. Sometimes Roman is used as an umbrella term for Roman and
> Julian calendars combined. I don't think that's a good choice though,
> because someone may get ambitious and implement output earlier than year
> 1; then it would be necessary to distinguish between Roman and Julian
> calendars. Besides, to muddy the waters further by starting yet another
> practice of using an incorrect name involving Julian just seems wrong.
> 
> I think the new option needs to be called Julian; so the only solution
> left is to use a different name space. I propose the following:
> 
> * leave the current --julian option as is

Unfortunately, this is necessary.

> * add one new option for setting the reform year:
>    --reform-year=<gregorian|iso|julian|1752>

Yes, I think about something like this. It seems like a way how to
keep it extendable.

  * leave the current --julian option as is

  * --reform=<gregorian,1752,greek,...>

  * add --iso (as alias to --reform=gregorian)

> I think this approach would also be better if the other 20 Gregorian
> reform adoption dates are ever added. 24 arguments would be cleaner then
> having an equal number of separate options.

Yes.

> Then to address whether to set the proleptic Gregorian calendar system
> as the default: I think just stay with your original plan, only forget
> the last bullet point with regard to implementing the code; I tried
> including preparations for the switch in the files, but it's too messy. So:
> 
> * leave the current default using 1752 reform
> 
> * create the proleptic Gregorian option
> 
> * let Karel decide if/when/how/politics of changing the default
>   Maybe comments from closing the RedHat bug will help with that choice.
> 
> I mentioned before that I have more bug fixes queued, but didn't want to
> make this patch set to large. Well, some of them influence handling of
> the multiple calendar systems so I may add them to the next version of
> this patch set.

I hope I'll work on cal(1) this week. If you see any bug in the
current code, then fix it again the current master branch. I'll rebase
and merge it to the new code later... or wait ;-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
