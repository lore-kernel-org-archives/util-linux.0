Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qe0-f50.google.com ([209.85.128.50]:49990 "EHLO
	mail-qe0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750850Ab3CTUx4 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 20 Mar 2013 16:53:56 -0400
Received: by mail-qe0-f50.google.com with SMTP id k5so1370253qej.23
        for <util-linux@vger.kernel.org>; Wed, 20 Mar 2013 13:53:55 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 20 Mar 2013 14:53:55 -0600
Message-ID: <CAMLZHHSgh8rdidXyqcQy7SK3f4V+03LSLjX_EkpwcOO_hS0osQ@mail.gmail.com>
Subject: "hwclock --systohc" and tick synchronization
From: Daniel Drake <dsd@laptop.org>
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

We are looking at situations with OLPC XO laptops where all RTC power
has been lost and hence the system has lost its time/date and RTC
contents are invalid.

The usual thing to do in this case is to reset the system time to the
current moment and then use hwclock to save it to the RTC.

However, this is proving quite confusing.

# hwclock --systohc
hwclock: select() to /dev/rtc0 to wait for clock tick timed out: No
such file or directory

Firstly, the corresponding warn() in hwclock-rtc.c should be warnx()
so that it does not print the errno message. When select returns 0
(timeout), interpreting errno does not make sense.

Secondly, did that hwclock command fail or succeed? Our users and a
developer saw that output and concluded "hwclock is broken" and filed
a bug. Having seen the bug report, I drew the same conclusion. Only
upon testing further I realised that this is only a warning and
hwclock did go on and set the RTC time appropriately.

So, can this message be silenced completely, or can we add a "RTC
successfully set from system clock"  success message that appears
afterwards?

Let me know if there is a preference, then I'll go and send a patch.

Thanks
Daniel
