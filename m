Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pa0-f66.google.com ([209.85.220.66]:36760 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753231AbcCHB2n (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 7 Mar 2016 20:28:43 -0500
Received: by mail-pa0-f66.google.com with SMTP id 1so79427pal.3
        for <util-linux@vger.kernel.org>; Mon, 07 Mar 2016 17:28:43 -0800 (PST)
Date: Mon, 7 Mar 2016 17:28:37 -0800
From: Isaac Dunham <ibid.ag@gmail.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 00/12] another BSD/OSX related patch-set
Message-ID: <20160308012836.GA26455@newbook>
References: <1457392322-4974-1-git-send-email-sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1457392322-4974-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Mar 08, 2016 at 12:11:50AM +0100, Ruediger Meier wrote:
> From: Ruediger Meier <ruediger.meier@ga-group.nl>
> 
> This is github pull request #299
> https://github.com/karelzak/util-linux/pull/299
> 
> Again some arbitrary BSD, OSX and musl related fixes and clean-up
<snip>
> For OSX one should additionally disable all utmp.h related programs.

FYI:
With musl, utmpx is stubbed out and utmp is wrappers for utmpx, so
users should disable utmp(x)-related programs and code.

(The point is to let things build, but not use utmp because the maintainer
considers it a fundamentally flawed idea.)

Additionally, systemd is working on allowing disabling of utmp(x).

This seems to imply that --disable-utmp/--disable-utmpx options would be
helpful.


> Almost no interesting compiler warnings left. Xcode/clang warnings are
> a bit over the top anyways.
> 
> 
> Ruediger Meier (12):
>   wipefs, sfdisk: include libgen.h for basename(3p)

I'm glad to see use of POSIX basename(), which is the only version that
musl implements.

The way musl implements basename, strdup() is not needed, but following
POSIX is better than relying on implementation-specific details.

Thanks,
Isaac Dunham
