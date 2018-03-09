Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:39839 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932520AbeCIW2t (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 9 Mar 2018 17:28:49 -0500
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: debug parallel root checks
Date: Fri, 9 Mar 2018 23:28:43 +0100
Cc: util-linux@vger.kernel.org
References: <201803091547.40271.sweet_f_a@gmx.de> <201803091606.08473.sweet_f_a@gmx.de> <20180309214829.xkdpoddrnhga7lsc@ws.net.home>
In-Reply-To: <20180309214829.xkdpoddrnhga7lsc@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201803092328.43500.sweet_f_a@gmx.de>
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
> And note that I do not use --parallel as test case before a release.
> It seems still too fragile to provide serious functional tests.

Of course, but it helped already somehow to understand our test-suite 
better and discovered some bugs which could also happen 
without --parallel.

I'm still sceptical about our multiple locks strategy (deadlocks!?). 
Also the speed improvement is not significant against just running two 
separate "xargs threads", one for root and one for non-root. Anyways 
it's interesting to play around with the locks and maybe we could even 
avoid the big scsi_debug lock one day by re-using the module instead of
modprobe/rmmod.

cu,
Rudi


