Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:60123 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750744AbbAKSnd (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 11 Jan 2015 13:43:33 -0500
Message-ID: <54B2C449.8010206@gmx.com>
Date: Sun, 11 Jan 2015 13:43:21 -0500
From: JWP <elseifthen@gmx.com>
MIME-Version: 1.0
To: Benno Schulenberg <bensberg@justemail.net>
CC: Util-Linux <util-linux@vger.kernel.org>, karel Zak <kzak@redhat.com>
Subject: Re: [PATCH 2/4] docs: mention that setarch may not be able to set
 all listed architectures
References: <1420897295-17573-1-git-send-email-bensberg@justemail.net> <1420897295-17573-2-git-send-email-bensberg@justemail.net> <54B2A27A.50401@gmx.com> <1420996041.3944497.212461717.015CE843@webmail.messagingengine.com>
In-Reply-To: <1420996041.3944497.212461717.015CE843@webmail.messagingengine.com>
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 01/11/2015 12:07 PM, Benno Schulenberg wrote:
> 
> On Sun, Jan 11, 2015, at 17:19, JWP wrote:
>> On 01/10/2015 08:41 AM, Benno Schulenberg wrote:
>>> -\fB\-\-uname\-2.6\fR
>>> -Causes the program to see a kernel version number beginning with 2.6.
>>> +.B \-\-uname-2.6
>>
>> This is incorrect. Options are always constructed with minus signs never a hyphens.
>> The only time a hyphen should be used in man-pages is for normally hyphenated 
>> dictionary words. Commands, options, variables, paths, urls, etc. all use the
>> minus sign character.
> 
> You are right.  However, on a terminal both hyphen and minus sign render
> to 0x2d.  When printed, the characters are rendered differently, and then
> I prefer to see a tiny hyphen instead of a minus sign in hyphenated options.
> And since you cannot copy and paste from a printed document, it doesn't
> matter that the more readable hyphen is used instead of the correct minus
> sign.

The world is going paperless, favoring print manuals over online is going the
wrong direction. Just because it uses the same glyph on your terminal does not
mean the same will be true for every application that renders a man-page.

However, the more important point is not what glyph is printed, but how troff 
formats a hyphen vs a minus sign. We do not want line breaks made mid: command,
command string, option, variable, url, etc. It could be argued that when
they are located near the left margin, such as in TP context, it would not
cause formatting issues, but they need to be kept consistent through out the
document and are often later used mid-paragraph.

If one of them is split with a hyphen at line end, how does one know if the
hyphen was added for formatting, or if it is part of the name?

I ran into that exact problem with persistent_clock_is_local in the hwclock 
man-page. That is why I added the \% you asked about.

> 
> See also 'git log -p --author=bjarniig' and search for "to '-'", and also
> http://www.spinics.net/lists/util-linux-ng/msg09260.html near the end.

      Change '\-' (minus) to '-' (code "hyphen-minus", rendered with the
      glyph 'hyphen' in troff), if it is a part of a compound word.

Yes, I said that compound words are the only place to use the hyphen. Dictionary
compound words. Most options do not form legitimate compound words, and even if
they did you should not hyphenate them. They need to be presented as they are used,
on paper or otherwise.

Then later in commit 2ad6d4f Mr. Gislason says:

      Change '-' to '\-', if it indicates an option
      Change '--' to '\-\-', if it indicates an option

I hope he did not then make a minus in the 'word' of the option a hyphen.


> 
> If you maintain that the correct \- should be used, there will be a
> large patch to make.
> 
> Benno
> 
