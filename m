Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ob0-f171.google.com ([209.85.214.171]:52998 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751317AbbASUmE (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 19 Jan 2015 15:42:04 -0500
Received: by mail-ob0-f171.google.com with SMTP id va2so20837409obc.2
        for <util-linux@vger.kernel.org>; Mon, 19 Jan 2015 12:42:03 -0800 (PST)
Message-ID: <54BD6C18.1080308@gmail.com>
Date: Mon, 19 Jan 2015 14:42:00 -0600
From: Bruce Dubbs <bruce.dubbs@gmail.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.26-rc1
References: <20150114194608.GF28019@x2.net.home>
In-Reply-To: <20150114194608.GF28019@x2.net.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Karel Zak wrote:
>
> The util-linux release v2.26-rc1 is available at
>
>     ftp://ftp.kernel.org/pub/linux/utils/util-linux/v2.26/
>
> Feedback and bug reports, as always, are welcomed.

Just wanted to give feedback on the build in an LFS environment:

./configure ADJTIME_PATH=/var/lib/hwclock \
    --disable-chfn-chsh  \
    --disable-login      \
    --disable-su         \
    --disable-setpriv    \
    --disable-runuser    \
    --disable-pylibmount \
    --without-python     \
    --without-systemd    \
    --without-systemdsystemunitdir

make

chown -Rv nobody .
su nobody -s /bin/bash -c "PATH=$PATH make -k check"

----------

The build process is excellent.  No errors or warnings during build.  No 
failures during 'make check'.

All 155 tests PASSED
One KNOWN FAILED (ipcs/limits2)
66 IGNORE due to non-root permissions or missing/omitted programs in the 
limited LFS environment.

   -- Bruce Dubbs
      linuxfromscratch.org
