Return-Path: util-linux-owner@vger.kernel.org
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:59257 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750872AbbAKRHW (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 11 Jan 2015 12:07:22 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 36329204B3
	for <util-linux@vger.kernel.org>; Sun, 11 Jan 2015 12:07:22 -0500 (EST)
Message-Id: <1420996041.3944497.212461717.015CE843@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: JWP <elseifthen@gmx.com>
Cc: "Util-Linux" <util-linux@vger.kernel.org>, karel Zak <kzak@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
In-Reply-To: <54B2A27A.50401@gmx.com>
References: <1420897295-17573-1-git-send-email-bensberg@justemail.net>
 <1420897295-17573-2-git-send-email-bensberg@justemail.net>
 <54B2A27A.50401@gmx.com>
Subject: Re: [PATCH 2/4] docs: mention that setarch may not be able to set all
 listed architectures
Date: Sun, 11 Jan 2015 18:07:21 +0100
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Sun, Jan 11, 2015, at 17:19, JWP wrote:
> On 01/10/2015 08:41 AM, Benno Schulenberg wrote:
> > -\fB\-\-uname\-2.6\fR
> > -Causes the program to see a kernel version number beginning with 2.6.
> > +.B \-\-uname-2.6
> 
> This is incorrect. Options are always constructed with minus signs never a hyphens.
> The only time a hyphen should be used in man-pages is for normally hyphenated 
> dictionary words. Commands, options, variables, paths, urls, etc. all use the
> minus sign character.

You are right.  However, on a terminal both hyphen and minus sign render
to 0x2d.  When printed, the characters are rendered differently, and then
I prefer to see a tiny hyphen instead of a minus sign in hyphenated options.
And since you cannot copy and paste from a printed document, it doesn't
matter that the more readable hyphen is used instead of the correct minus
sign.

See also 'git log -p --author=bjarniig' and search for "to '-'", and also
http://www.spinics.net/lists/util-linux-ng/msg09260.html near the end.

If you maintain that the correct \- should be used, there will be a
large patch to make.

Benno

-- 
http://www.fastmail.com - Same, same, but different...

