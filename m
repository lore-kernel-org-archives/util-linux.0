Return-Path: util-linux-owner@vger.kernel.org
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:57769 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750922AbbAKLog (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 11 Jan 2015 06:44:36 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id ADB0D20572
	for <util-linux@vger.kernel.org>; Sun, 11 Jan 2015 06:44:35 -0500 (EST)
Message-Id: <1420976675.3854707.212394769.57AD68B2@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: JWP <elseifthen@gmx.com>
Cc: Karel Zak <kzak@redhat.com>, "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
In-Reply-To: <54B16A8A.3090605@gmx.com>
References: <54AE031C.30907@gmx.com> <54AE052C.6050202@gmx.com>
 <1420893866.3537848.212162497.2B990B0E@webmail.messagingengine.com>
 <54B16A8A.3090605@gmx.com>
Subject: Re: [PATCH 3/4] hwclock: update man page for v2.26 rc
Date: Sun, 11 Jan 2015 12:44:35 +0100
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Sat, Jan 10, 2015, at 19:08, JWP wrote:
> I agree we do not want full
> changelogs in files. My thinking in this particular case was, that there
> has not been a significant update to this man-page in a couple of decades

Hmm...  Looking at 'git log -p -w --follow sys-utils/hwclock.8.in', the
first version of the man page dates from 1996.  Before 1998 there was a
substantial addition (Alpha stuff) and again for version 2.9i (unfortunately
undated).

BTW, Karel, where are the older versions of util-linux stored
(the ones before 2.13)?  I can't find them on kernel.org, but did find them
on http://ftp.europeonline.com/pub/linux/utils/util-linux/ .

(Also BTW, Karel, where has the homepage of util-linux gone?
It is no longer http://userweb.kernel.org/~kzak/util-linux/ .)

> Also, since I authored some completely new content I was thinking of any
> copyright/copyleft issues; although I did not actually claim any.

Ah!  Probably you should claim copyright.  Davidlohr Bueso did this,
for example, for a substantial addition to partx.  So I would suggest
that, instead of the changelog item, you add the following two lines
to the man page header:

Copyright 1996 Bryan Henderson <bryanh@giraffe-data.com>
Copyright 2015 J. William Piggott <elseifthen@gmx.com>

And if you find out who wrote the other substantial additions, you
could add copyright lines for them too.

(No need to specify which part of the page your copyright applies to,
that is what git is for.)

> Before adding this I checked other utli-linux man-pages and some of them
> have extensive top comments. Including some changelogs,

Well, the extensive top comments are for the most part just verbose
licenses.  The only two changelogs I see are in fstab.5 and swapon.8,
and those things are entirely obsolete.  The recent top comments are
added because they are about recent commands or substantial additions,
and they are just copyright lines, not changelogs.

> I did not think this new hwclock would be used in DEC
> Alpha's either, but it is. Despite its name, I have read that util-
> linux is used elsewhere. BSD comes to mind.

But if this modern hwclock is used, wouldn't the rest of the system
be modern too?  That is: have up-to-date man macros?

> > s/none are/none is/
> > because at most one may be given.
> 
> But there are multiple choices and 'none' is plural.

No, "none" isn't always plural.  :)
http://www.quickanddirtytips.com/education/grammar/none-or-none-are

> So, what I do not understand is why translation
> software would flag a text line for changes in whitespace, punctuation,
> formatting structure like line-breaks, or non-printing characters.

Whitespace might be used to line things up neatly, and gettext has
no way of knowing when this change is relevant or not, so it must
flag each and every change.

> I 
> understand punctuation can change the meaning, but it seems unlikely that
> it would impact the translation, assuming the translator parsed out the 
> intended meaning the first time.

Huh?  If the meaning of a string changes, surely the translation
will be different too...  Aah!  You mean: the translator translated
the string correctly even though it had faulty punctuation or tabbing
or spelling or something similar.  Ah, but you can't be sure of that.
So, the minutest change in a string must invalidate its translation.

Benno

-- 
http://www.fastmail.com - The way an email service should be

