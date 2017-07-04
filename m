Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:40330 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752163AbdGDIKd (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 4 Jul 2017 04:10:33 -0400
Date: Tue, 4 Jul 2017 10:10:29 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/6] path: use openat()
Message-ID: <20170704081029.22nagnlhl4bux4ql@ws.net.home>
References: <1499082781-16968-1-git-send-email-sweet_f_a@gmx.de>
 <20170703143949.pifm6ebon7dr3fww@ws.net.home>
 <20170703145228.exv6hbsqhwwd45w2@ws.net.home>
 <201707031811.56680.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201707031811.56680.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jul 03, 2017 at 06:11:56PM +0200, Ruediger Meier wrote:
> Yes I understand. This global way was just for first tests without 
> changing much code. To be honest, while I was very happy first about 
> quick results, I am now a bit unsure whether this sysroot feature will 
> be much useful at all.
> 
> See, even lscpu --sysroot does not work fully transparently. We have to 
> ignore "Architecture". So maybe we would also need a fake-syscall 
> interface for many cases!? Also we are sometimes writing to /sys and 
> probably expect some events.

well, zramctl writes to /sys, but another utils just read.

> I wonder if it wouldn't be easier to construct chroot or container 
> environments with whatever /sys, /proc, /etc. to test certain things.

Yes, chroot would be good enough for the tests.

The path functions are not only about --sysroot, but it also provides
interface for things like "read file content as utnt64, strdup(), etc.

> So I thought we could use my quick-and-dirty approach to implement some 
> more --sysroot tests just to see if we will get something useful at 
> all.

I do not see a problem to kill --sysroot and use chroot, but we still
need openat and another things.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
