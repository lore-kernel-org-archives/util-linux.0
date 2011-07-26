Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:28968 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751252Ab1GZKqw (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 26 Jul 2011 06:46:52 -0400
Date: Tue, 26 Jul 2011 12:46:48 +0200
From: Karel Zak <kzak@redhat.com>
To: Tom Gundersen <teg@jklm.no>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: hwclock's ADJPATH
Message-ID: <20110726104648.GA14764@nb.net.home>
References: <CAG-2HqUu6BduqDkja7-T67CJNYRKZWBbOQA29O3HaR=092bKaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG-2HqUu6BduqDkja7-T67CJNYRKZWBbOQA29O3HaR=092bKaA@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jul 26, 2011 at 02:06:20AM +0200, Tom Gundersen wrote:
> These are the constraints we have:
> 
> /etc could possibly be mounted read-only.
> /var might not be mounted at early boot.
> 
> This is the usage we have (in the cases where a machine does not use ntp):
> 
> 1) At early boot we call "hwclock --systz", which require us to read
> ADJPATH to determine if RTC is in UTC/LOCAL (so ADJTIME can not be in
> /var).
>
> 2) From time to time (typically at shutdown), we call "hwclock
> --adjust", which require us to write to ADJPATH (so ADJPATH can not be
> in /etc).
> 3) The administrator should manually call "hwclock --set" and make
> sure ADJPATH is writeable when this is done (for this, ADJPATH could
> be either in /etc or /var).
> 
> 
> 
> Are these reasonable constraints and a reasonable usecase? If so, it
> seems to me that the only way to make this work is to split ADJPATH
> into two files, /etc/adjtime containing UTC/LOCAL and
> /var/lib/hwclock/adjtime containing everything else. Or am I missing
> something?

 You're probably right. Note that you can use:

    hwclock --systz $(CLOCK_ZONE_OPTION)

 where the CLOCK_ZONE_OPTION will be --utc or --local from some extra
 file (e.g. /etc/sysconfig/hwclock), then /etc/adjtime will be
 unnecessary for --systz.

 And for hwclock --set or --adjust you can use
 --adjfile=/var/lib/hwclock/adjtime or so.


 Note that systemd will probably not call hwclock at all, it will read
 only /etc/adjtime to get UTC/LOCAL setting and call settimeofday().
 The --adjust is somehow unexpected on systems with systemd.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
