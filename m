Return-Path: util-linux-owner@vger.kernel.org
Received: from 173-166-109-252-newengland.hfc.comcastbusiness.net ([173.166.109.252]:60783
	"EHLO bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964900Ab2LGMoU (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 7 Dec 2012 07:44:20 -0500
Date: Fri, 7 Dec 2012 07:44:15 -0500
From: Christoph Hellwig <hch@infradead.org>
To: Alun <alun.linux@ty-penguin.org.uk>
Cc: kzak@redhat.com, util-linux@vger.kernel.org
Subject: Re: [PATCH] Add option to fsfreeze to call syncfs() prior to
 freezing.
Message-ID: <20121207124415.GA28504@infradead.org>
References: <20121207101400.5e46ba48@pcebbj.staff.aber.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20121207101400.5e46ba48@pcebbj.staff.aber.ac.uk>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Dec 07, 2012 at 10:14:00AM +0000, Alun wrote:
> Hi,
> 
> I've recently been looking into a problem on a heavily loaded fileserver.
> Running fsfreeze on the filesystem causes the load average to go sky high.
> Looking at the kernel sources, I discovered that the FIFREEZE ioctl suspends
> writes, then syncs the filesystem. With a large amount of dirty data, this
> can leave writes suspended for a significant time, even if your intent is to
> have the filesystem frozen for a short time. I raised this on the kernel
> list, suggesting an extra call to sync the filesystem prior to suspending
> writes, but it was pointed out to me that this would change the semantics
> of the ioctl.

It might be better to send a kernel patch to do a first async sync
attempt instead of band aiding this in one of the consumers.

