Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:34206 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752922AbbALKlV (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 12 Jan 2015 05:41:21 -0500
Date: Mon, 12 Jan 2015 11:41:11 +0100
From: karel Zak <kzak@redhat.com>
To: JWP <elseifthen@gmx.com>
Cc: Benno Schulenberg <bensberg@justemail.net>,
        Util-Linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 2/4] docs: mention that setarch may not be able to set
 all listed architectures
Message-ID: <20150112104111.GE20899@x2.net.home>
References: <1420897295-17573-1-git-send-email-bensberg@justemail.net>
 <1420897295-17573-2-git-send-email-bensberg@justemail.net>
 <54B2A27A.50401@gmx.com>
 <1420996041.3944497.212461717.015CE843@webmail.messagingengine.com>
 <54B2C449.8010206@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <54B2C449.8010206@gmx.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jan 11, 2015 at 01:43:21PM -0500, JWP wrote:
> On 01/11/2015 12:07 PM, Benno Schulenberg wrote:
> > 
> > On Sun, Jan 11, 2015, at 17:19, JWP wrote:
> >> On 01/10/2015 08:41 AM, Benno Schulenberg wrote:
> >>> -\fB\-\-uname\-2.6\fR
> >>> -Causes the program to see a kernel version number beginning with 2.6.
> >>> +.B \-\-uname-2.6
> >>
> >> This is incorrect. Options are always constructed with minus signs never a hyphens.
> >> The only time a hyphen should be used in man-pages is for normally hyphenated 
> >> dictionary words. Commands, options, variables, paths, urls, etc. all use the
> >> minus sign character.
> > 
> > You are right.  However, on a terminal both hyphen and minus sign render
> > to 0x2d.  When printed, the characters are rendered differently, and then
> > I prefer to see a tiny hyphen instead of a minus sign in hyphenated options.
> > And since you cannot copy and paste from a printed document, it doesn't
> > matter that the more readable hyphen is used instead of the correct minus
> > sign.
> 
> The world is going paperless, favoring print manuals over online is going the
> wrong direction. Just because it uses the same glyph on your terminal does not
> mean the same will be true for every application that renders a man-page.
> 
> However, the more important point is not what glyph is printed, but how troff 
> formats a hyphen vs a minus sign. We do not want line breaks made mid: command,

 For me is important to use in man pages the same option names (same
 chars) like we have in source code where I see 0x2d, and I'd like
 like to minimize variability in the man pages, it's better to be
 consistent than be perfect.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
