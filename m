Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-oa0-f52.google.com ([209.85.219.52]:50371 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752818AbaGBV2A (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 2 Jul 2014 17:28:00 -0400
Received: by mail-oa0-f52.google.com with SMTP id j17so12847320oag.39
        for <util-linux@vger.kernel.org>; Wed, 02 Jul 2014 14:28:00 -0700 (PDT)
Message-ID: <53B4795D.5030300@gmail.com>
Date: Wed, 02 Jul 2014 16:27:57 -0500
From: Bruce Dubbs <bruce.dubbs@gmail.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.25-rc2
References: <20140702101057.GB31066@x2.net.home>
In-Reply-To: <20140702101057.GB31066@x2.net.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Karel Zak wrote:
>
> The util-linux release v2.25-rc2 is available at
>
>     ftp://ftp.kernel.org/pub/linux/utils/util-linux/v2.25-rc2
>
> Feedback and bug reports, as always, are welcomed.

Nicely done.  In an LFS environment, there are no errors or warnings:

All the non-root tests passed, but I did not check the tests as root.

mkdir -pv /var/lib/hwclock

./configure ADJTIME_PATH=/var/lib/hwclock
make

chown -Rv nobody .
su nobody -s /bin/bash -c "PATH=$PATH make -k check"

make install

   -- Bruce
