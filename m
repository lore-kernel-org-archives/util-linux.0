Return-Path: util-linux-owner@vger.kernel.org
Received: from mta02.eastlink.ca ([24.224.136.13]:60932 "EHLO
        mta02.eastlink.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbeHFCPV (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 5 Aug 2018 22:15:21 -0400
MIME-version: 1.0
Content-type: text/plain; CHARSET=US-ASCII
Received: from emgw02.eastlink.ca ([71.7.199.174])
 by mta02.eastlink.ca (Oracle Communications Messaging Server 8.0.2.2.20180130
 64bit (built Jan 30 2018)) with ESMTP id <0PD000CF5HNTW9M0@mta02.eastlink.ca>
 for util-linux@vger.kernel.org; Sun, 05 Aug 2018 20:38:55 -0300 (ADT)
Date: Sun, 5 Aug 2018 20:41:17 -0300
To: Sami Kerola <kerolasa@iki.fi>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Dmitry V. Levin" <ldv@altlinux.org>, util-linux@vger.kernel.org
Subject: Re: [PATCH] libuuid: use kernel crypto api
Message-id: <20180805234117.GR865@cordes.ca>
References: <20180804191706.10641-1-kerolasa@iki.fi>
 <20180804194655.GD4461@thunk.org> <alpine.LNX.2.21.99.1808051124370.868@imuri>
In-reply-to: <alpine.LNX.2.21.99.1808051124370.868@imuri>
From: Peter Cordes <peter@cordes.ca>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Aug 05, 2018 at 11:42:09AM +0100, Sami Kerola wrote:
> 
> I should have told in that commit message part of the motivation was to 
> deprecate util-linux local md5 implementation. But since both of you 
> raised concern about performance I decided to test kernel api and 
> util-linux implementations as close the same way as they are used in 
> libuuid.
> 
> Executive summary: kernel api is surprisingly slow.

 You're probably testing on an x86-64 system with kernel mitigation
for Spectre and Meltdown.

Both of those add *significant* overhead to every system call (or
other kernel entry/exit, like interrupts).

e.g. in comments on Stack Overflow, @BeeOnRope found that a `syscall`
instruction with an invalid call number takes about 1800 cycles on a
Skylake CPU running Linux (in late February 2018).
https://stackoverflow.com/questions/48913091/fastest-linux-system-call#comment84843442_48914200

(Unfortunately IDK if there's a better / more details analysis of
system call costs anywhere.)

Most of that cost is in the WRMSR that flushes branch predictors,
using Intel's newly-introduced (and *not* fast) microcode assistance
for Spectre.  Possibly future hardware will make this cheaper, but on
current hardware it just sucks to make system calls.

Thanks to Meltdown mitigation, you get extra TLB misses in the kernel
and after returning to user-space.  (This may be less bad than in
early patches, thanks to using hardware PCIDs).  But even just the MOV
to CR3 to change the top level page table takes some time.

I'm not surprised that you found a 10x slowdown for short messages.  
Amortizing the kernel entry/exit over a larger buffer is the only way
for it not to be horrible.

If you're curious, you could try booting with the workarounds disabled
(or an old kernel) to see how much perf difference that makes.  The
SYSCALL / SYSRET instructions themselves only take something in the
ballpark of 50 cycles on Skylake or Ryzen, IIRC, and Linux's
system-call dispatch code is pretty efficient for the fast path.  Even
that might still be measurable overhead for MD5 on a short message,
though.

-- 
#define X(x,y) x##y
Peter Cordes ;  e-mail: X(peter@cor , des.ca)

"The gods confound the man who first found out how to distinguish the hours!
 Confound him, too, who in this place set up a sundial, to cut and hack
 my day so wretchedly into small pieces!" -- Plautus, 200 BC
