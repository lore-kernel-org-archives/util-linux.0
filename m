Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-gy0-f174.google.com ([209.85.160.174]:61807 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752155Ab1GZAGl (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 25 Jul 2011 20:06:41 -0400
Received: by gyh3 with SMTP id 3so2568707gyh.19
        for <util-linux@vger.kernel.org>; Mon, 25 Jul 2011 17:06:40 -0700 (PDT)
MIME-Version: 1.0
From: Tom Gundersen <teg@jklm.no>
Date: Tue, 26 Jul 2011 02:06:20 +0200
Message-ID: <CAG-2HqUu6BduqDkja7-T67CJNYRKZWBbOQA29O3HaR=092bKaA@mail.gmail.com>
Subject: hwclock's ADJPATH
To: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi guys,

Sami's latest hwclock patches reminded me of something I have long
been meaning to bring up:

I have been unable to figure out how to use hwclock in such a way that
we (Arch Linux) can set a reasonable ADJPATH.

These are the constraints we have:

/etc could possibly be mounted read-only.
/var might not be mounted at early boot.

This is the usage we have (in the cases where a machine does not use ntp):

1) At early boot we call "hwclock --systz", which require us to read
ADJPATH to determine if RTC is in UTC/LOCAL (so ADJTIME can not be in
/var).
2) From time to time (typically at shutdown), we call "hwclock
--adjust", which require us to write to ADJPATH (so ADJPATH can not be
in /etc).
3) The administrator should manually call "hwclock --set" and make
sure ADJPATH is writeable when this is done (for this, ADJPATH could
be either in /etc or /var).



Are these reasonable constraints and a reasonable usecase? If so, it
seems to me that the only way to make this work is to split ADJPATH
into two files, /etc/adjtime containing UTC/LOCAL and
/var/lib/hwclock/adjtime containing everything else. Or am I missing
something?

Cheers,

Tom
