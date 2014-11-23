Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f176.google.com ([209.85.212.176]:65530 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751014AbaKWNbF (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 23 Nov 2014 08:31:05 -0500
Received: by mail-wi0-f176.google.com with SMTP id ex7so3315930wid.3
        for <util-linux@vger.kernel.org>; Sun, 23 Nov 2014 05:31:03 -0800 (PST)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <5470FE32.9030805@gmx.com>
References: <5470FE32.9030805@gmx.com>
Date: Sun, 23 Nov 2014 13:31:03 +0000
Message-ID: <CAG27Bk3zu-8Qar_k44uM3_8_kOddJkqvb1be1_KmjkBGfBGcYA@mail.gmail.com>
Subject: Re: RFC hwclock: refactoring
From: Sami Kerola <kerolasa@iki.fi>
To: JWP <elseifthen@gmx.com>
Cc: Karel Zak <kzak@redhat.com>, util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 22 November 2014 at 21:20, JWP <elseifthen@gmx.com> wrote:
> So, I noticed when *fdisk were rewritten that some antiquated
> code was dropped.  I would like some opinions on whether this
> should be done when refactoring hwclock.
>
> For example, do we need a workaround for the 1994 Award BIOS
> bug?

I agree with Benno, it is time to say goodbye to that code.

> Do we need Alpha code?  Is there a Linux distro that
> still officially supports Alpha machines?

I'm not sure if there is any up to date distribution for Alpha. Kernel
crew seems to still care alpha, so it is not completely dead.

http://marc.info/?t=140518903000002&r=1&w=2

Maybe the question should be rephrased. How about dropping the Alpha
cmos support? It looks like Alpha has rtc support.

http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/alpha/kernel/rtc.c

> Any other ideas regarding this topic are welcome.

Removal of i386 references should be safe.

http://news.softpedia.com/news/Linux-Kernel-3-8-Says-Goodbye-to-i386-314293.shtml

Since there is no other than Alpha & i386 references to cmos code, all
of it is subject for removal.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
