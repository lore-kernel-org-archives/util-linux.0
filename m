Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:55342 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752707AbcGGU1g (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 7 Jul 2016 16:27:36 -0400
Date: Thu, 7 Jul 2016 22:27:34 +0200
From: Karel Zak <kzak@redhat.com>
To: "Dale R. Worley" <worley@alum.mit.edu>
Cc: Ruediger Meier <sweet_f_a@gmx.de>, util-linux@vger.kernel.org
Subject: Re: question about raw(1)
Message-ID: <20160707202734.tuoshkpnoxlnr5w5@ws.net.home>
References: <201607041539.37149.sweet_f_a@gmx.de>
 <871t38djgn.fsf@hobgoblin.ariadne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <871t38djgn.fsf@hobgoblin.ariadne.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jul 05, 2016 at 02:32:24PM -0400, Dale R. Worley wrote:
> Ruediger Meier <sweet_f_a@gmx.de> writes:
> > I'm just curious, would this always work?: 
> >
> >   modprobe raw
> >   raw /dev/raw/raw1 /dev/xyz
> >
> > or should you wait for /dev/raw/rawctl after modprobe (udevadm settle or 
> > sleep)?

This is generic problem and I don't think for utils like raw(8) is
there any elegant way how to wait for rawctl node. 

IMHO the right solution is write robust scripts and expect "bad things" 
from your OS :-)

> Interesting -- the modprobe manual page doesn't state explicitly whether
> or not the module initialization actions will be completed before
> modprobe returns.

Well, module initialization may also trigger uevent and the rest is
userspace (udev) business. In this case things are completely out of
kernel+modprobe control, so "module initialization done" is irrelevant
information.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
