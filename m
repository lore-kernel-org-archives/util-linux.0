Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:21842 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752758AbaJGJRO (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 7 Oct 2014 05:17:14 -0400
Date: Tue, 7 Oct 2014 11:17:11 +0200
From: Karel Zak <kzak@redhat.com>
To: Francis Moreau <francis.moro@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: losetup: failed to setup loop device > 1
Message-ID: <20141007091711.GB8057@x2.net.home>
References: <5432C4C8.30101@gmail.com>
 <20141006174041.GA8057@x2.net.home>
 <54330294.1090908@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <54330294.1090908@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Oct 06, 2014 at 10:59:00PM +0200, Francis Moreau wrote:
> On 10/06/2014 07:40 PM, Karel Zak wrote:
> > On Mon, Oct 06, 2014 at 06:35:20PM +0200, Francis Moreau wrote:
> >> One last details is that the system uses pretty old stuff: kernel
> >> 3.4.50, util-linux 2.21.1.
> > 
> > $ git log --oneline v2.21.. -- lib/loopdev.c sys-utils/losetup.c | wc -l
> > 62
> > 
> >> Could anybody give me some help ?
> > 
> > update, this is upstream mailing list I have doubts anyone is ready
> > to help you with code released 2 years ago.
> 
> well it looks like more a kernel issue since the sequence of syscalls
> done by losetup looks correct. Maybe someone here already encountered
> this...
> 
> I just found that loop module was loaded with max_part=16 and
> CONFIG_BLK_DEV_LOOP_MIN_COUNT=8. If max_part is set to 0 then the issue
> is gone :-/

Well, if you have kernel that provides /dev/loop-control then you
don't have to set CONFIG_BLK_DEV_LOOP_MIN_COUNT at all. I guess 
"8" (kernel upstream default?) is mostly about backward compatibility.

For example fedora uses CONFIG_BLK_DEV_LOOP_MIN_COUNT=0. All is
dynamically allocated by kernel + udev.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
