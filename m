Return-Path: util-linux-owner@vger.kernel.org
Received: from elasmtp-curtail.atl.sa.earthlink.net ([209.86.89.64]:40626 "EHLO
	elasmtp-curtail.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751214AbaAPJGF (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Thu, 16 Jan 2014 04:06:05 -0500
Received: from [24.144.107.66] (helo=[192.168.0.11])
	by elasmtp-curtail.atl.sa.earthlink.net with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.67)
	(envelope-from <mrmazda@earthlink.net>)
	id 1W3itn-000560-PW
	for util-linux@vger.kernel.org; Thu, 16 Jan 2014 04:06:03 -0500
Message-ID: <52D7A0FA.8010303@earthlink.net>
Date: Thu, 16 Jan 2014 04:06:02 -0500
From: Felix Miata <mrmazda@earthlink.net>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: Re: global fdisk colors disable
References: <52D62F0C.9060308@earthlink.net> <20140115082708.GH12700@x2.net.home> <52D696CB.5060606@earthlink.net> <20140115171128.GM12700@x2.net.home>
In-Reply-To: <20140115171128.GM12700@x2.net.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 2014-01-15 18:11 (GMT+0100) Karel Zak composed:

> On Wed, Jan 15, 2014 at 09:10:19AM -0500, Felix Miata wrote:

>> Orange on a 16 color display doesn't look much different than red. Both
>> contrast poorly unless the background is white, detracting from any value as
>> warning intended by those color choices.

>   so your suggestion is to disable the colors at all for all Linux boxes by
>   default?

I've been using white on blue text modes for nearly 3 decades, ever since I 
learned to use ansi to set screen colors in DOS 3, as I find white on black 
rather unpleasant to need to use more than occasionally.

Probably better to have some option for a user or admin to force the ttys 
into 2 or 4 color mode regardless whether the system is capable of or 
happiest with 8, 15, 16, 24 or more.

>   I understand your point of view, but I'd like to use default that is
>   usable to majority of the Linux users.

That is a typical majority rule effect. The problem is those with poorer than 
average vision by definition are both a minority and handicapped. From that 
it apparently follows that making it more difficult for the minority already 
handicapped must be OK because the majority of average or better people might 
enjoy some colors that may or may not make sense or provide real enhancement.

>> One reason I use the ttys is for comfort, a pleasant environment where
>> legibility is maximized, in part by big bold text, in part by lack of
>> distraction from other windows and widgets, in other part by using only the
>> two colors of my choice. In that environment I don't want or need to be
>> "warned" by colors I can barely see.

>   I understand.. it would be nice to have a one place to disable/enable
>   colors for all terminal utils, maybe something like

>      /etc/terminal-colors.d/[<utilname>.]disable

>   I'm going to resolve the problem for the next v2.25. Thanks!

Thank you! This sounds like it should be a good option for many.
-- 
"The wise are known for their understanding, and pleasant
words are persuasive." Proverbs 16:21 (New Living Translation)

  Team OS/2 ** Reg. Linux User #211409 ** a11y rocks!

Felix Miata  ***  http://fm.no-ip.com/
