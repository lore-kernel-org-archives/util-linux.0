Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:54698 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750744AbbAKTAE (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 11 Jan 2015 14:00:04 -0500
Message-ID: <54B2C82E.70607@gmx.com>
Date: Sun, 11 Jan 2015 13:59:58 -0500
From: JWP <elseifthen@gmx.com>
MIME-Version: 1.0
To: Benno Schulenberg <bensberg@justemail.net>
CC: Karel Zak <kzak@redhat.com>, Util-Linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 3/4] hwclock: update man page for v2.26 rc
References: <54AE031C.30907@gmx.com> <54AE052C.6050202@gmx.com> <1420893866.3537848.212162497.2B990B0E@webmail.messagingengine.com> <54B16A8A.3090605@gmx.com> <1420976675.3854707.212394769.57AD68B2@webmail.messagingengine.com>
In-Reply-To: <1420976675.3854707.212394769.57AD68B2@webmail.messagingengine.com>
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



On 01/11/2015 06:44 AM, Benno Schulenberg wrote:
> 
> On Sat, Jan 10, 2015, at 19:08, JWP wrote:
>> I agree we do not want full
>> changelogs in files. My thinking in this particular case was, that there
>> has not been a significant update to this man-page in a couple of decades
> 
> Hmm...  Looking at 'git log -p -w --follow sys-utils/hwclock.8.in', the
> first version of the man page dates from 1996.  Before 1998 there was a
> substantial addition (Alpha stuff) and again for version 2.9i (unfortunately
> undated).
Seriously? I use a generalized term of 'a couple of decades' and you say I'm 
wrong it has only been 17 to 19 years?

I do not consider adding options and other code changes a significant update.
I meant, updating the contextual information about what the command does, how
it is used, and how date-time in general operates under Linux... not how many
bytes the file contains. I my opinion, when Bryan rewrote clock(8) in 1996 was
the last time that was done.  Sorry, I was off by one year.

> 
> BTW, Karel, where are the older versions of util-linux stored
> (the ones before 2.13)?  I can't find them on kernel.org, but did find them
> on http://ftp.europeonline.com/pub/linux/utils/util-linux/ .

I am interested in this as well. Specifically the full history of (hw)clock
back to 1992.

> 
> (Also BTW, Karel, where has the homepage of util-linux gone?
> It is no longer http://userweb.kernel.org/~kzak/util-linux/ .)
> 
>> Also, since I authored some completely new content I was thinking of any
>> copyright/copyleft issues; although I did not actually claim any.
> 
> Ah!  Probably you should claim copyright.  Davidlohr Bueso did this,
> for example, for a substantial addition to partx.  So I would suggest
> that, instead of the changelog item, you add the following two lines
> to the man page header:
> 
> Copyright 1996 Bryan Henderson <bryanh@giraffe-data.com>
> Copyright 2015 J. William Piggott <elseifthen@gmx.com>
> 
> And if you find out who wrote the other substantial additions, you
> could add copyright lines for them too.
> 
> (No need to specify which part of the page your copyright applies to,
> that is what git is for.)

As previously stated, I was not thinking of developers. I was considering
users that do not wish to create a git repository, nor browse one online, 
just to see who authored some man-page text.  Again, it is not important
to me, if Karel wants it gone that is fine. 

> 
>> Before adding this I checked other utli-linux man-pages and some of them
>> have extensive top comments. Including some changelogs,
> 
> Well, the extensive top comments are for the most part just verbose
> licenses.  The only two changelogs I see are in fstab.5 and swapon.8,
> and those things are entirely obsolete.  The recent top comments are
> added because they are about recent commands or substantial additions,
> and they are just copyright lines, not changelogs.
> 
>> I did not think this new hwclock would be used in DEC
>> Alpha's either, but it is. Despite its name, I have read that util-
>> linux is used elsewhere. BSD comes to mind.
> 
> But if this modern hwclock is used, wouldn't the rest of the system
> be modern too?  That is: have up-to-date man macros?

I do not know, Benno. I was just trying to maximize portability. I have
also read that some newer html man-page browsers do not implement some of
the extended macros.

> 
>>> s/none are/none is/
>>> because at most one may be given.
>>
>> But there are multiple choices and 'none' is plural.
> 
> No, "none" isn't always plural.  :)
> http://www.quickanddirtytips.com/education/grammar/none-or-none-are

I was not make a general comment about 'none', it was specific to this
instance.

In general, it often encompasses both singular and plural. The only case
where a singular accompanying verb is required is when the noun is 
uncountable.

>From your own reference:

"You may be chided by the uninformed when you follow "none" with a plural verb, 
but don’t be afraid to do so if your sentence calls for it.

> 
>> So, what I do not understand is why translation
>> software would flag a text line for changes in whitespace, punctuation,
>> formatting structure like line-breaks, or non-printing characters.
> 
> Whitespace might be used to line things up neatly, and gettext has
> no way of knowing when this change is relevant or not, so it must
> flag each and every change.

I'm not talking about normal program output, I'm talking about message
strings.

> 
>> I 
>> understand punctuation can change the meaning, but it seems unlikely that
>> it would impact the translation, assuming the translator parsed out the 
>> intended meaning the first time.
> 
> Huh?  If the meaning of a string changes, surely the translation
> will be different too...  Aah!  You mean: the translator translated
> the string correctly even though it had faulty punctuation or tabbing
> or spelling or something similar.  Ah, but you can't be sure of that.
> So, the minutest change in a string must invalidate its translation.

Well, I suppose the folks doing this know better than I. It still seems 
unreasonable to me that if a programmer inadvertently makes a 160 character 
string (s)he is not allowed to fix it by adding a line break, because it
will trip a translation flag... that seems nuts to me. The same for line
ending periods, they are only delimiters and should not change the meaning. 
Arguably, all message strings should be conducive to logging. Meaning single
line output, in grammar terms, single line vertical lists, no delimiters 
required. The last thing anyone wants in log files are paragraphs of text,
which is the reason full stops exist.


> 
> Benno
> 
