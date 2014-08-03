Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pa0-f42.google.com ([209.85.220.42]:64410 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751603AbaHCUue (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 3 Aug 2014 16:50:34 -0400
Received: by mail-pa0-f42.google.com with SMTP id lf10so8842209pab.1
        for <util-linux@vger.kernel.org>; Sun, 03 Aug 2014 13:50:33 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <2423860.9OdLEsNW7s@vapier>
References: <1407075463-19586-1-git-send-email-kerolasa@iki.fi>
	<2423860.9OdLEsNW7s@vapier>
Date: Sun, 3 Aug 2014 21:50:33 +0100
Message-ID: <CAG27Bk2OosZoo=XAGy+2Ld-pxAbTzivhr=cXE4S8FJtVzPnwAA@mail.gmail.com>
Subject: Re: [PATCH 1/7] zramctl: print all devices as a default action
From: Sami Kerola <kerolasa@iki.fi>
To: Mike Frysinger <vapier@gentoo.org>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 3 August 2014 15:50, Mike Frysinger <vapier@gentoo.org> wrote:
> On Sun 03 Aug 2014 15:17:37 Sami Kerola wrote:
>> -static int zram_used(struct zram *z)
>> +static int zram_used(struct zram *z, int find_unused)
>
> s/int/bool/ ?

There's only handful of boolean types in use in util-linux

util-linux> git grep -l 'bool '
lib/mbsalign.c
login-utils/su-common.c
sys-utils/hwclock-cmos.c
sys-utils/hwclock.c
sys-utils/nsenter.c
tests/ts/login/logindefs

And question about bool is asked before.

http://marc.info/?l=util-linux-ng&m=135817763904699&w=2

The question was never answered, but if I should guess the idea in
util-linux is same as what Linus said should be done in kernel.

https://lkml.org/lkml/2013/8/31/138

Please read the whole thread. It's full of good stuff.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
