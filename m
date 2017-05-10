Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:50696 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751507AbdEJJt2 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 10 May 2017 05:49:28 -0400
Date: Wed, 10 May 2017 11:49:22 +0200
From: Karel Zak <kzak@redhat.com>
To: L A Walsh <lkml@tlinx.org>
Cc: util-linux@vger.kernel.org
Subject: Re: util-linux-v2.25:mountpoint misnamed or bugged, and "-d" bugged
Message-ID: <20170510094922.kuebyztjs55szzxu@ws.net.home>
References: <58F2C401.5090001@tlinx.org>
 <20170510094746.zpkebvktie7iauzf@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170510094746.zpkebvktie7iauzf@ws.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, May 10, 2017 at 11:47:46AM +0200, Karel Zak wrote:
> On Sat, Apr 15, 2017 at 06:08:17PM -0700, L A Walsh wrote:
> > 
> > mountpoint doesn't detect file, device
> > or other inode mount points.
> > 
> > Also, the "-d" switch doesn't show the maj:min of the mounted
> > inode.  Of note: "-x" does show the maj:min of a remounted blockdev.
> 
> Version, distro, do you have classic mtab, etc, etc.... ?

Ah, now I see v2.25 in the subject. Sorry. My test is with v2.28 and
current git tree.

        Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
