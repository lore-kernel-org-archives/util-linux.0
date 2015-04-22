Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.18]:65474 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932460AbbDVOUM (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 22 Apr 2015 10:20:12 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: sfdisk, latest fixes break ppc64
Date: Wed, 22 Apr 2015 16:20:01 +0200
Cc: util-linux@vger.kernel.org
References: <201504211234.27649.sweet_f_a@gmx.de> <201504221242.18521.sweet_f_a@gmx.de> <20150422132827.GF27969@ws.net.home>
In-Reply-To: <20150422132827.GF27969@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201504221620.01771.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wednesday 22 April 2015, Karel Zak wrote:
> On Wed, Apr 22, 2015 at 12:42:18PM +0200, Ruediger Meier wrote:
> > On Wednesday 22 April 2015, Karel Zak wrote:
> > > On Tue, Apr 21, 2015 at 12:34:26PM +0200, Ruediger Meier wrote:
> > > > the latest sfdisk fixes 2928068a..a53e37f9 seem to break ppc64
> > >
> > > The latest changes in sfdisk only shows stupid LE/BE bugs we have
> > > in GPT code. The problem should be fixed now.
> >
> > Most issues are fixed now so I guess 2.26.2 will be a good one :)
>
>  I hope so:-) Next time it would be nice to detect and fix such bugs
>  in major release or in .1  ... we need a way how to motivate users
> to use -rc releases (t-shits, beers? ;-)

Hehe, maybe the only way is like we have it right now. 2.xx and 2.xx.1 
are the real rc1 and rc2. The distributors have to learn to use 2.xx.2 
only ;)

> > There are still some random failures sometimes like this:
> >              : resize                      ... FAILED
> >              : (sfdisk/gpt-resize)

> Yes, I know about it, but I'm able to reproduce this only on ppc, add
> "sleep 10" to the test fixes the problem, so I guess that "udevadm
> settle" is not so reliable on ppc.

Yes, I've also made many experiments about this.

For example currently I'am always using
  export BLKID_CONF="/dev/null"

to avoid arbitrary /etc/blkid.conf from build hosts. This makes sure 
that you always use "EVALUATE=scan" and it seems to fix 
random "blkdiscard" failures.

And I've also tried something like this partially succesful:

@@ -497,10 +497,14 @@ function ts_device_deinit {
 }
 
 function ts_uuid_by_devname {
+	echo change > /sys/block/$(basename $1)/uevent
+	udevadm settle
 	echo $($TS_CMD_BLKID -p -s UUID -o value $1)
 }
 
 function ts_label_by_devname {
+	echo change > /sys/block/$(basename $1)/uevent
+	udevadm settle
 	echo $($TS_CMD_BLKID -p -s LABEL -o value $1)
 }

cu,
Rudi
