Return-Path: util-linux-owner@vger.kernel.org
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:33249 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751434AbaGZQFK (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sat, 26 Jul 2014 12:05:10 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by gateway1.nyi.internal (Postfix) with ESMTP id 22C2921488
	for <util-linux@vger.kernel.org>; Sat, 26 Jul 2014 12:05:10 -0400 (EDT)
Message-Id: <1406390709.8686.145937949.0F0BF57C@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: kerolasa@gmail.com
Cc: "Util-Linux" <util-linux@vger.kernel.org>,
        Ondrej Oprala <ooprala@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: hwclock --compare segfaults when run as normal user
Date: Sat, 26 Jul 2014 18:05:09 +0200
In-Reply-To: <CAG27Bk2SkstBkDGR9EiP0UENK1qag0VZ31tLZsjvgCxRss2bpw@mail.gmail.com>
References: <1406378420.29449.145898149.3B1EDA38@webmail.messagingengine.com>
 <CAG27Bk2SkstBkDGR9EiP0UENK1qag0VZ31tLZsjvgCxRss2bpw@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Sat, Jul 26, 2014, at 16:48, Sami Kerola wrote:
> On 26 July 2014 13:40, Benno Schulenberg <bensberg@justemail.net> wrote:
> > On my system there is no /etc/adjtime file, and then:
> >
> > $ ./hwclock --compare
> > Segmentation fault
> 
> I tried to reproduce the issue without success. If you have core file
> could you try to gdb backtrace it?

(gdb) run --compare
Starting program: /home/ben/util-linux-2.25/hwclock --compare

Program received signal SIGSEGV, Segmentation fault.
0x0804cf71 in outb () at /usr/include/sys/io.h:99
99	  __asm__ __volatile__ ("outb %b0,%w1": :"a" (__value), "Nd" (__port));

(gdb) bt
#0  0x0804cf71 in outb () at /usr/include/sys/io.h:99
#1  cmos_read () at sys-utils/hwclock-cmos.c:348
#2  atomic () at sys-utils/hwclock-cmos.c:307
#3  hclock_read () at sys-utils/hwclock-cmos.c:456
#4  cmos_clock_busy () at sys-utils/hwclock-cmos.c:472
#5  synchronize_to_clock_tick_cmos () at sys-utils/hwclock-cmos.c:484
#6  0x08049919 in synchronize_to_clock_tick () at sys-utils/hwclock.c:348
#7  0x0804c578 in compare_clock (argc=<value optimized out>, argv=0xbffff414) at sys-utils/hwclock.c:1502
#8  main (argc=<value optimized out>, argv=0xbffff414) at sys-utils/hwclock.c:1941

Benno

-- 
http://www.fastmail.fm - Choose from over 50 domains or use your own

