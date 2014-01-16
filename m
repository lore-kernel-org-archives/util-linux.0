Return-Path: util-linux-owner@vger.kernel.org
Received: from elasmtp-galgo.atl.sa.earthlink.net ([209.86.89.61]:49694 "EHLO
	elasmtp-galgo.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751435AbaAPJYU (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Thu, 16 Jan 2014 04:24:20 -0500
Received: from [24.144.107.66] (helo=[192.168.0.11])
	by elasmtp-galgo.atl.sa.earthlink.net with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.67)
	(envelope-from <mrmazda@earthlink.net>)
	id 1W3jBT-00053R-PM
	for util-linux@vger.kernel.org; Thu, 16 Jan 2014 04:24:19 -0500
Message-ID: <52D7A542.70805@earthlink.net>
Date: Thu, 16 Jan 2014 04:24:18 -0500
From: Felix Miata <mrmazda@earthlink.net>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: Re: global fdisk colors disable
References: <52D62F0C.9060308@earthlink.net> <20140115082708.GH12700@x2.net.home> <52D696CB.5060606@earthlink.net> <201401151021.22057.vapier@gentoo.org>
In-Reply-To: <201401151021.22057.vapier@gentoo.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 2014-01-15 10:21 (GMT-0500) Mike Frysinger composed:

> On Wednesday 15 January 2014 09:10:19 Felix Miata wrote:

>> I have many logins on many installations. In what global config file (e.g.
>> Debian, Fedora, Gentoo, Knoppix, Mageia, openSUSE, Slackware, etc.) can I
>> make never the default for all users?

> /etc/profile

That always seems to have a rather recent date, even though I never touch it. 
Are you sure you don't mean /etc/profile.local?

> or use ~/.bashrc and set up a system that syncs your ~/ files

Too complicated for me. I don't use identical .bashrc content for every login 
or every installation. Earlier in thread Karel Zak indicated he has a nice 
solution planned for next release.

> if there was an env var, you could configure ~/.ssh/config to forward specific
> env vars to the remote host automatically
-- 
"The wise are known for their understanding, and pleasant
words are persuasive." Proverbs 16:21 (New Living Translation)

  Team OS/2 ** Reg. Linux User #211409 ** a11y rocks!

Felix Miata  ***  http://fm.no-ip.com/
