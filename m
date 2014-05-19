Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.18]:65454 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753803AbaESTvp (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 19 May 2014 15:51:45 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: feature-freeze for v2.25
Date: Mon, 19 May 2014 21:51:39 +0200
Cc: util-linux@vger.kernel.org
References: <20140519101605.GL26357@x2.net.home>
In-Reply-To: <20140519101605.GL26357@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201405192151.40129.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Monday 19 May 2014, Karel Zak wrote:
>  Hi,
>
>  note that I'd like to release v2.25 next month. I'm going to merge
>  new features to completely new things (like libsmartcols or
> lslogins) and to regression tests only. All another non-bugfix or
> invasive refactoring patches will be postponed. (well, in progress
> setterm stuff will be merged.)

I'd like to have two more minor features in v2.25:

1. squashfs3 detection in superblocks.h
2. improved hypervisor detection in lscpu

Would it have a chance if I commit soon? Both patches are used and 
tested already in SLE since v2.16 or v2.19 and in openSUSE devel since 
v2.24.

cu,
Rudi
