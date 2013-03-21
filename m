Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:24119 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933034Ab3CUICQ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 21 Mar 2013 04:02:16 -0400
Date: Thu, 21 Mar 2013 09:02:13 +0100
From: Karel Zak <kzak@redhat.com>
To: Daniel Drake <dsd@laptop.org>
Cc: util-linux@vger.kernel.org
Subject: Re: "hwclock --systohc" and tick synchronization
Message-ID: <20130321080213.GA18657@x2.net.home>
References: <CAMLZHHSgh8rdidXyqcQy7SK3f4V+03LSLjX_EkpwcOO_hS0osQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAMLZHHSgh8rdidXyqcQy7SK3f4V+03LSLjX_EkpwcOO_hS0osQ@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Mar 20, 2013 at 02:53:55PM -0600, Daniel Drake wrote:
> However, this is proving quite confusing.
> 
> # hwclock --systohc
> hwclock: select() to /dev/rtc0 to wait for clock tick timed out: No
> such file or directory

 BTW, in util-linux 2.22.1 the timeout has been changed from 5 to 10
 seconds, I guess you have older version.

> So, can this message be silenced completely, or can we add a "RTC
> successfully set from system clock"  success message that appears
> afterwards?

 Fixed, now the message is printed only in --debug output.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
