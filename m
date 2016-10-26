Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:53613 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753331AbcJZK2D (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 26 Oct 2016 06:28:03 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: libfdisk show stopper on i586?
Date: Wed, 26 Oct 2016 12:27:55 +0200
Cc: util-linux@vger.kernel.org
References: <201610260000.12844.sweet_f_a@gmx.de> <201610261153.51698.sweet_f_a@gmx.de> <20161026101916.4f3d2u3xwmekfpjs@ws.net.home>
In-Reply-To: <20161026101916.4f3d2u3xwmekfpjs@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201610261227.55777.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wednesday 26 October 2016, Karel Zak wrote:
> On Wed, Oct 26, 2016 at 11:53:51AM +0200, Ruediger Meier wrote:
> > commit 8430b9b88426eb3c273b02a2d9505d839913317c
> > Author: Karel Zak <kzak@redhat.com>
> > Date:   Tue Oct 25 13:41:10 2016 +0200
> >
> >     libfdisk: make script token parser more robust
>
> Strange, don't see relation between the script parser and fdisk -l.
> Do you have LIBFDISK_DEBUG output?
>
>     Karel


[   65s] +14318: libfdisk:     INIT: library debug mask: 0xffff
[   65s] +Available "LIBFDISK_DEBUG=<name>[,...]|<mask>" debug masks:
[   65s] +   all      [0xffff] : info about all subsystems
[   65s] +   ask      [0x0010] : fdisk dialogs
[   65s] +   help     [0x0001] : this help
[   65s] +   cxt      [0x0004] : library context (handler)
[   65s] +   label    [0x0008] : disk label utils
[   65s] +   part     [0x0040] : partition utils
[   65s] +   parttype [0x0080] : partition type utils
[   65s] +   script   [0x0200] : sfdisk-like scripts
[   65s] +   tab      [0x0100] : table utils
[   65s] +   wipe     [0x0400] : wipe area utils
[   65s] +   item     [0x0400] : disklabel items
[   65s] +14318: libfdisk:      CXT: [0x882d048]: alloc
[   65s] +14318: libfdisk:      CXT: [0x882d048]: assigning device <removed>
[   65s] +14318: libfdisk:      CXT: [0x882d048]: *** resetting context
[   65s] +14318: libfdisk:      CXT: [0x882d048]: <removed>: discovering topology...
[   65s] +14318: libfdisk:      CXT: [0x882d048]: initialize libblkid prober
[   65s] +14318: libfdisk:      CXT: [0x882d048]: result: log/phy sector size: 512/512
[   65s] +14318: libfdisk:      CXT: [0x882d048]: result: fdisk/optimal/minimal io: 512/0/512
[   65s] +14318: libfdisk:      CXT: [0x882d048]: <removed>: discovering geometry...
[   65s] +14318: libfdisk:      CXT: [0x882d048]: total sectors: 20480 (ioctl=20480)
[   65s] +14318: libfdisk:      CXT: [0x882d048]: result: C/H/S: 1/255/63
[   65s] +14318: libfdisk:      CXT: [0x882d048]: initialize in-memory first sector buffer [sector_size=512]
[   65s] +14318: libfdisk:      CXT: [0x882d048]: reading: offset=0, size=512
[   65s] +14318: libfdisk:      CXT: [0x882d048]: probing for gpt
[   65s] +14318: libfdisk:    LABEL: found a protective MBR
[   65s] +14318: libfdisk:    LABEL: GPT last LBA: 20479
[   65s] +14318: libfdisk:    LABEL: found valid GPT Header on LBA 1
[   65s] +14318: libfdisk:    LABEL: GPT last LBA: 20479
[   65s] +14318: libfdisk:    LABEL: found valid GPT Header on LBA 20479
[   65s] +14318: libfdisk:      CXT: [0x882d048]: --> switching context to gpt!
[   65s] +14318: libfdisk:      CXT: [0x882d048]: applying user device properties
[   65s] +14318: libfdisk:      CXT: [0x882d048]: resetting alignment...
[   65s] +14318: libfdisk:      CXT: [0x882d048]: alignment reset to: first LBA=2048, last LBA=20446, grain=1048576 [rc=0]
[   65s] +14318: libfdisk:      CXT: [0x882d048]: new C/H/S: 1/255/63
[   65s] +14318: libfdisk:      CXT: [0x882d048]: new log/phy sector size: 512/512
[   65s] +14318: libfdisk:      CXT: [0x882d048]: initialized for <removed> [READ-ONLY]
[   65s] +14318: libfdisk:      ASK: [0x8834068]: alloc
[   65s] +14318: libfdisk:      ASK: [0x8834068]: do_ask for 'info'
[   65s] +14318: libfdisk:      ASK: [0x8834068]: do_ask done [rc=0]
[   65s] +14318: libfdisk:      ASK: [0x8834068]: reset
[   65s] +14318: libfdisk:      ASK: [0x8834068]: free
[   65s] +14318: libfdisk:      ASK: [0x8834068]: alloc
[   65s] +14318: libfdisk:      ASK: [0x8834068]: do_ask for 'info'
[   65s] +14318: libfdisk:      ASK: [0x8834068]: do_ask done [rc=0]
[   65s] +14318: libfdisk:      ASK: [0x8834068]: reset
[   65s] +14318: libfdisk:      ASK: [0x8834068]: free
[   65s] +14318: libfdisk:      ASK: [0x8834100]: alloc
[   65s] +14318: libfdisk:      ASK: [0x8834100]: do_ask for 'info'
[   65s] +14318: libfdisk:      ASK: [0x8834100]: do_ask done [rc=0]
[   65s] +14318: libfdisk:      ASK: [0x8834100]: reset
[   65s] +14318: libfdisk:      ASK: [0x8834100]: free
[   65s] +14318: libfdisk:      ASK: [0x8834110]: alloc
[   65s] +14318: libfdisk:      ASK: [0x8834110]: do_ask for 'info'
[   65s] +14318: libfdisk:      ASK: [0x8834110]: do_ask done [rc=0]
[   65s] +14318: libfdisk:      ASK: [0x8834110]: reset
[   65s] +14318: libfdisk:      ASK: [0x8834110]: free
[   65s] +14318: libfdisk:      ASK: [0x8834080]: alloc
[   65s] +14318: libfdisk:      ASK: [0x8834080]: do_ask for 'info'
[   65s] +14318: libfdisk:      ASK: [0x8834080]: do_ask done [rc=0]
[   65s] +14318: libfdisk:      ASK: [0x8834080]: reset
[   65s] +14318: libfdisk:      ASK: [0x8834080]: free
[   65s] +14318: libfdisk:      CXT: [0x882d048]: asking for disk gpt ID
[   65s] +*** Error in `/home/abuild/rpmbuild/BUILD/util-linux-2.29.rc2-22-82e8d/.libs/fdisk': munmap_chunk(): invalid pointer: 0xf7790a73 ***
