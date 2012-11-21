Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:58419 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755154Ab2KUP2G (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 21 Nov 2012 10:28:06 -0500
Date: Wed, 21 Nov 2012 16:00:05 +0100
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: Bernhard Voelker <mail@bernhard-voelker.de>,
        util-linux <util-linux@vger.kernel.org>, mp.lists@free.fr
Subject: Re: Accessibility of swap files
Message-ID: <20121121150005.GB2912@x2.net.home>
References: <1352214367.5099275f85792@imp.free.fr>
 <535592290.498944.1352219102253.JavaMail.open-xchange@email.1und1.de>
 <20121121100852.GC2006@x2.net.home>
 <CAG27Bk2L7p=pO3LJZTNMaS68vx2vfodG76K=1SicOvEExDQRFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk2L7p=pO3LJZTNMaS68vx2vfodG76K=1SicOvEExDQRFw@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Nov 21, 2012 at 01:46:59PM +0000, Sami Kerola wrote:
> On Wed, Nov 21, 2012 at 10:08 AM, Karel Zak <kzak@redhat.com> wrote:
> > On Tue, Nov 06, 2012 at 05:25:02PM +0100, Bernhard Voelker wrote:
> >> On November 6, 2012 at 4:06 PM mp.lists@free.fr wrote:
> >> > As a first idea, it looks, as if such may be implemented, eg. by
> >> >      letting swapon [and fstab-based "mounting"] by default not enable a swap
> >> > file, if it has non-root access permissions
> >>
> >> Did you know?
> >> The swapon utility issues a warning diagnostic with --verbose:
> >>
> >>   # ls -l /tmp/swapfile
> >>   -rw-r--r-- 1 berny users 134217728 Nov  6 17:03 /tmp/swapfile
> >>
> >>   # sbin/swapon -v  /tmp/swapfile
> >>   swapon /tmp/swapfile
> >>   swapon: /tmp/swapfile: insecure permissions 0644, 0600 suggested.
> >>   swapon: /tmp/swapfile: insecure file owner 1000, 0 (root) suggested.
> >>   swapon: /tmp/swapfile: found swap signature: version 1, page-size 4, same byte
> >> order
> >>   swapon: /tmp/swapfile: pagesize=4096, swapsize=134217728, devsize=134217728
> >
> >  this waring is there since year 1999.. so it's really nothing new.
> 
> I wonder would be be too noisy to make insecurity warnings enabled by
> default,  and add --quiet option to thous who do not want to hear
> system complaining about things they know.
> 

 since util-linux 2.9t:

    /* people generally dislike this warning - now it is printed
       only when `verbose' is set */

 :-)



-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
