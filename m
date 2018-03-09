Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:58961 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932108AbeCIWQb (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 9 Mar 2018 17:16:31 -0500
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: debug parallel root checks
Date: Fri, 9 Mar 2018 23:16:24 +0100
Cc: util-linux@vger.kernel.org
References: <201803091547.40271.sweet_f_a@gmx.de> <201803091606.08473.sweet_f_a@gmx.de> <20180309214622.fys7a24fkiiyvrxa@ws.net.home>
In-Reply-To: <20180309214622.fys7a24fkiiyvrxa@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201803092316.24853.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Friday 09 March 2018, Karel Zak wrote:
> On Fri, Mar 09, 2018 at 04:06:08PM +0100, Ruediger Meier wrote:
> > On Friday 09 March 2018, Ruediger Meier wrote:
> > > Hi,
> > >
> > > Our parallel root checks look already nice on the first view.
> > > On the second view they fail the stress test, at least on my
> > > system.
> >
> > Just an arbitrary example. Sometimes I get this failure
> >
> > $ cat  tests/diff/mount/uuid
> > --- /tmp/ul2/tests/expected/mount/uuid  2018-03-09
> > 11:04:54.992654305 +0100 +++ /tmp/ul2/tests/output/mount/uuid   
> > 2018-03-09 15:55:00.168028810 +0100 @@ -1 +1,2 @@
> > -Success
> > +mount: /tmp/ul2/tests/output/mount/uuid-mnt: can't find
> > UUID="f102445a-f6f3-4657-bc58-81ff164fc0d9". +A) Cannot find
> > /dev/loop10 in /proc/mounts
> >
> >
> > So mount can't find that UUID although it was found before by
> > ts_uuid_by_devname, i.e. by blkid(1).
> >
> > What could be the problem:
> >    - another test thread removed the UUID
> >    - invalid blkid cache
> >    - a bug?
>
> We do not use blkid cache, it should be based on udev symmlinks. The
> symlinks are not ready yet. I guess sleep() or so fixed the problem.

I've found now a really stpuid bug which fixes already a lot.

-----------
 tests: fix grep expressions for devices

ts_is_mounted "/dev/loop1" returned true if /dev/loop17 was
mounted. A very annoying source of sporadic failures since
many years. This issue became more visible since running the
checks in parallel, which increases the probability to get
bigger loop device numbers.

https://github.com/karelzak/util-linux/pull/594/commits/5a33a0cdb069b3e86c044eb4f80d0c2104c558b2
-----------

Can't believe that I haven't noticed this bug a few years
earlier ... Now I'm able to run that test loop endless and
collect all tests which still have instabilities.

cu,
Rudi
