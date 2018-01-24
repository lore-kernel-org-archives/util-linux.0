Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.18]:56767 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933688AbeAXOsD (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 24 Jan 2018 09:48:03 -0500
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH 0/7] fixes for fsck.cramfs and other things
Date: Wed, 24 Jan 2018 15:47:57 +0100
Cc: util-linux@vger.kernel.org
References: <20180123155928.7629-1-sweet_f_a@gmx.de> <20180124121655.v5pr5wetsezlsa77@ws.net.home>
In-Reply-To: <20180124121655.v5pr5wetsezlsa77@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201801241547.57246.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wednesday 24 January 2018, Karel Zak wrote:
> On Tue, Jan 23, 2018 at 04:59:21PM +0100, Ruediger Meier wrote:
> > From: Ruediger Meier <ruediger.meier@ga-group.nl>
> >
> > Ruediger Meier (6):
> >   Revert "fsck.cramfs: Fix bus error on broken file system."
> >   fsck.cramfs: fix crash when superblock size is too small
> >   tests: rewrite fsck-bad-header
>
> Nice.
>
> >   fsck.cramfs: fix error message

BTW while we are at this. I wonder why we have 3 different ways 
(fallbacks) in fsck.cramfs.c test_crc() how to read the image.

1. mmap
2. read into anonymous mmap
3. read blockwise

Does anybody knows why is this and whether we still need all these 
fallbacks?

cu,
Rudi
