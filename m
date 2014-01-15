Return-Path: util-linux-owner@vger.kernel.org
Received: from elasmtp-galgo.atl.sa.earthlink.net ([209.86.89.61]:55509 "EHLO
	elasmtp-galgo.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751735AbaAOOKV (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Wed, 15 Jan 2014 09:10:21 -0500
Received: from [24.144.107.66] (helo=[192.168.0.11])
	by elasmtp-galgo.atl.sa.earthlink.net with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.67)
	(envelope-from <mrmazda@earthlink.net>)
	id 1W3RAi-0003up-Cv
	for util-linux@vger.kernel.org; Wed, 15 Jan 2014 09:10:20 -0500
Message-ID: <52D696CB.5060606@earthlink.net>
Date: Wed, 15 Jan 2014 09:10:19 -0500
From: Felix Miata <mrmazda@earthlink.net>
MIME-Version: 1.0
CC: util-linux@vger.kernel.org
Subject: Re: global fdisk colors disable
References: <52D62F0C.9060308@earthlink.net> <20140115082708.GH12700@x2.net.home>
In-Reply-To: <20140115082708.GH12700@x2.net.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
To: unlisted-recipients:; (no To-header on input)@mail.corp.redhat.com
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 2014-01-15 09:27 (GMT+0100) Karel Zak composed:

> On Wed, Jan 15, 2014 at 01:47:40AM -0500, Felix Miata wrote:

>> Is there a way to do $SUBJECT? One really shouldn't have to resort to using
>> -L on every invocation to be able to see fdisk output.

>   Does it mean that fdisk output is broken or you just don't like
>   colors? You can use:

How about I defer answering that until you look at this image I should have 
included in my OP:

http://fm.no-ip.com/SS/colorsTTYbadFdisk.png

I hope you can understand the problem this way. It's much like web page 
designers have taken to doing the past few years, trying to be "helpful" by 
using gray text instead of black, ostensibly to compensate for harshness of 
maladjusted displays without considering impact on correctly adjusted displays.

Exactly what in that image is the non-default color supposed to be conveying?

>     alias fdisk=fdisk -L=never

>   in your shell profile or rc file.

That seems to have ignored a keyword in $SUBJECT: global

I have many logins on many installations. In what global config file (e.g. 
Debian, Fedora, Gentoo, Knoppix, Mageia, openSUSE, Slackware, etc.) can I 
make never the default for all users?

>> I see nothing in the
>> man page about any kind of config file. I don't think there's ever been a
>> reason to configure it before.

>   Well, I guess that more people prefer colorized output so this
>   feature is enabled by default.

Colors that have a standard meaning in a common context can make sense, but 
as likely colors confuse, besides reducing contrast. cf.:

http://en.wikipedia.org/wiki/Wikipedia:WikiProject_Usability/Color "Colors 
must be used carefully..."

http://www.webdesignref.com/chapters/13/ch13-16.htm "To avoid color contrast 
problems, white and black always make a good pairing..."

http://usabilitygeek.com/12-typography-guidelines-for-good-website-usability/ 
"Avoid colouring text in red or green..."

Orange on a 16 color display doesn't look much different than red. Both 
contrast poorly unless the background is white, detracting from any value as 
warning intended by those color choices.

>   I have already thought about it and it would be probably nice to have
>   a way how to globally configure colors for all command line utils
>   (e.g.  util-linux, coreutils, ...).

I'm pretty sure all other utils I commonly use have a way to turn off color 
globally. Some utils don't, so I don't use them unless no alternative exists. 
There really is no practical alternative to fdisk -l that I'm aware of.

>   It seems we have no standard and package  independent solution now,
>   so distributions use things like "alias" in shell profile files (for
>   example for ls(1), grep(1), ...). It would be nice to have at least
>   global variable (something like COLOR_MODE={auto,never,always}) to
>   avoid aliases with --color= option. (CC: Padraig ;-)

One reason I use the ttys is for comfort, a pleasant environment where 
legibility is maximized, in part by big bold text, in part by lack of 
distraction from other windows and widgets, in other part by using only the 
two colors of my choice. In that environment I don't want or need to be 
"warned" by colors I can barely see.

Maybe what I need is a way to prevent framebuffer ttys
  from using any but the two colors of my choice. Anyone know if that's possible?
-- 
"The wise are known for their understanding, and pleasant
words are persuasive." Proverbs 16:21 (New Living Translation)

  Team OS/2 ** Reg. Linux User #211409 ** a11y rocks!

Felix Miata  ***  http://fm.no-ip.com/
