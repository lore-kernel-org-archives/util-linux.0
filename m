Return-Path: util-linux-owner@vger.kernel.org
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50778 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751211AbeCIVq0 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 9 Mar 2018 16:46:26 -0500
Date: Fri, 9 Mar 2018 22:46:22 +0100
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: debug parallel root checks
Message-ID: <20180309214622.fys7a24fkiiyvrxa@ws.net.home>
References: <201803091547.40271.sweet_f_a@gmx.de>
 <201803091606.08473.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201803091606.08473.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Mar 09, 2018 at 04:06:08PM +0100, Ruediger Meier wrote:
> On Friday 09 March 2018, Ruediger Meier wrote:
> > Hi,
> >
> > Our parallel root checks look already nice on the first view.
> > On the second view they fail the stress test, at least on my
> > system.
> 
> Just an arbitrary example. Sometimes I get this failure
> 
> $ cat  tests/diff/mount/uuid
> --- /tmp/ul2/tests/expected/mount/uuid  2018-03-09 11:04:54.992654305 +0100
> +++ /tmp/ul2/tests/output/mount/uuid    2018-03-09 15:55:00.168028810 +0100
> @@ -1 +1,2 @@
> -Success
> +mount: /tmp/ul2/tests/output/mount/uuid-mnt: can't find UUID="f102445a-f6f3-4657-bc58-81ff164fc0d9".
> +A) Cannot find /dev/loop10 in /proc/mounts
> 
> 
> So mount can't find that UUID although it was found before by
> ts_uuid_by_devname, i.e. by blkid(1).
> 
> What could be the problem:
>    - another test thread removed the UUID
>    - invalid blkid cache
>    - a bug?

We do not use blkid cache, it should be based on udev symmlinks. The
symlinks are not ready yet. I guess sleep() or so fixed the problem.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
