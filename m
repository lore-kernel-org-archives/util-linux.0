Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:29247 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932258AbaDBPwd (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 2 Apr 2014 11:52:33 -0400
Date: Wed, 2 Apr 2014 17:52:27 +0200 (CEST)
From: =?ISO-8859-15?Q?Luk=E1=A8_Czerner?= <lczerner@redhat.com>
To: =?ISO-8859-15?Q?P=E1draig_Brady?= <P@draigbrady.com>
cc: util-linux@vger.kernel.org, kzak@redhat.com
Subject: Re: [PATCH] fallocate: add FALLOC_FL_ZERO_RANGE support
In-Reply-To: <533C021C.4060106@draigBrady.com>
Message-ID: <alpine.LFD.2.00.1404021742410.2169@localhost.localdomain>
References: <1396438265-21535-1-git-send-email-lczerner@redhat.com> <533C021C.4060106@draigBrady.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-884720301-1396453950=:2169"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-884720301-1396453950=:2169
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

On Wed, 2 Apr 2014, Pádraig Brady wrote:

> Date: Wed, 02 Apr 2014 13:27:08 +0100
> From: Pádraig Brady <P@draigbrady.com>
> To: Lukas Czerner <lczerner@redhat.com>
> Cc: util-linux@vger.kernel.org, kzak@redhat.com
> Subject: Re: [PATCH] fallocate: add FALLOC_FL_ZERO_RANGE support
> 
> On 04/02/2014 12:31 PM, Lukas Czerner wrote:
> > Recent Linux kernel supports FALLOC_FL_ZERO_RANGE in fallocate(2).
> > This patch adds FALLOC_FL_ZERO_RANGE support to fallocate utility,
> > by introducing a new option -z|--zero-range.
> > 
> > Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> 
> Looks good thanks.
> 
> I was wondering how this interacts with the --dig-holes option.
> That looks for ranges of zeros as efficiently as possible to turn them into holes.
> It uses SEEK_DATA for that, so I was wondering if these preallocated
> ranges of zeroes are treated specially in that regard?
> Note one could use fiemap to distinguish these ranges,
> but it's buggy as one needs to sync the file before using it.

It's currently implemented by ext4 and xfs and what it does is that
it converts initialized extents to initialized and preallocates
holes within that range.

Preallocated (unwritten) extents are indeed treated differently at
least in ext4 (not sure about other fs). If we encounter unwritten
extent we would check the page cache whether there are any data for
a given extent and treat it as DATA, or HOLE respectively.

Btw, you can create unwritten extent just with fallocate itself as
well.

Thanks!
-Lukas

> 
> thanks,
> Pádraig.
> 
> 
--8323328-884720301-1396453950=:2169--
