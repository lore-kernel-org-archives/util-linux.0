Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:56599 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752052AbcGGXBq (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 7 Jul 2016 19:01:46 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: question about raw(1)
Date: Fri, 8 Jul 2016 01:01:34 +0200
Cc: "Dale R. Worley" <worley@alum.mit.edu>, util-linux@vger.kernel.org
References: <201607041539.37149.sweet_f_a@gmx.de> <871t38djgn.fsf@hobgoblin.ariadne.com> <20160707202734.tuoshkpnoxlnr5w5@ws.net.home>
In-Reply-To: <20160707202734.tuoshkpnoxlnr5w5@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201607080101.35139.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thursday 07 July 2016, Karel Zak wrote:
> On Tue, Jul 05, 2016 at 02:32:24PM -0400, Dale R. Worley wrote:
> > Ruediger Meier <sweet_f_a@gmx.de> writes:
> > > I'm just curious, would this always work?:
> > >
> > >   modprobe raw
> > >   raw /dev/raw/raw1 /dev/xyz
> > >
> > > or should you wait for /dev/raw/rawctl after modprobe (udevadm
> > > settle or sleep)?
>
> This is generic problem and I don't think for utils like raw(8) is
> there any elegant way how to wait for rawctl node.
>
> IMHO the right solution is write robust scripts and expect "bad
> things" from your OS :-)

Yep, this was not a bug report. Just want to know how to write the 
script right.

It's about this openSUSE init script pull request
https://build.opensuse.org/request/show/405725

He removed the existing "sleep 2" after modprobe but I guess somebody 
had added that sleep for a good reason in past. Of course sleep is 
ugly, maybe "udevadm settle" would work too!? I simply don't know if 
udev or sleep would have any affect here at all. When testing locally 
the thing always works without any sleep. But this may not mean 
anything (as I've learned from ul test suite issues).

> > Interesting -- the modprobe manual page doesn't state explicitly
> > whether or not the module initialization actions will be completed
> > before modprobe returns.
>
> Well, module initialization may also trigger uevent and the rest is
> userspace (udev) business. In this case things are completely out of
> kernel+modprobe control, so "module initialization done" is
> irrelevant information.
>
>     Karel


