Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:38978 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933888AbdGTIOx (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 20 Jul 2017 04:14:53 -0400
Date: Thu, 20 Jul 2017 10:14:49 +0200
From: Karel Zak <kzak@redhat.com>
To: Mark Tinguely <mark.tinguely@hpe.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] libblkid: add HPE extended-XFS to known filesystems
Message-ID: <20170720081449.gpckhfylkuwg6xlf@ws.net.home>
References: <012d19cf-cf77-fe9a-29c5-98ca42c3d377@hpe.com>
 <20170718083514.alsfyb4k2ntxmtzd@ws.net.home>
 <56b0e75c-1317-2f82-8cd4-626f394409ef@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56b0e75c-1317-2f82-8cd4-626f394409ef@hpe.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jul 18, 2017 at 07:56:05AM -0500, Mark Tinguely wrote:
> On 07/18/2017 03:35 AM, Karel Zak wrote:
> > On Fri, Jun 30, 2017 at 09:30:39AM -0500, Mark Tinguely wrote:
> > > From: Mark Tinguely <mark.tinguely@hpe.com>
> > > The HPE (formerly SGI) enhanced XFS has changed its magic
> > Is it already supported by Linux kernel? I have problem google
> > anything about EXFS.
> XFS was written by SGI and SGI open sourced a version of it. EXFS is the SGI
> version of XFS.
> HPE bought SGI in Nov 2016. With the purchase of SGI, HPE now owns the the
> XFS trademark.
> This patch renames the EXFS magic so our customers can have a XFS root
> filesystem and EXFS filesystems.
> > 
> > > version number to allow the use of EXFS and community XFS
> > > filesystems at the same time.
> > Unfortunately the patch uses the same magic string for EXFS log
> > (0xFEEDbabe) as XFS log. The result is that libblkid detects EXFS log
> > on all XFS images.  (try "cd tests; ./run.sh blkid")
> 
> We know that the log has the same numbers.

OK; merged, but without the log prober. It's impossible to have one
superblocks with two different names.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
