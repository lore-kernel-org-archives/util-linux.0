Return-Path: util-linux-owner@vger.kernel.org
Received: from imap.thunk.org ([74.207.234.97]:54427 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751183AbaDOE1d (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 15 Apr 2014 00:27:33 -0400
Date: Tue, 15 Apr 2014 00:27:29 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Qu Wenruo <quwenruo@cn.fujitsu.com>
Cc: util-linux@vger.kernel.org
Subject: Re: libblkid: Idea to force given cached entry to be invalidated?
Message-ID: <20140415042729.GC3403@thunk.org>
References: <534C9625.8030906@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <534C9625.8030906@cn.fujitsu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Apr 15, 2014 at 10:15:01AM +0800, Qu Wenruo wrote:
> 
> Though the above patch try to avoid the whole cache, it's not good enough
> since it break the pricible not
> to probe the devices too frequently.
> 
> After some searching, it seems that libblkid does not provide such API, or
> am I missing something?

The blkid_verify() function is designed to make sure the information
in the cache corresponds with reality.  If it does not, it will update
the cache to match with reality, so it will do what you want.

Using blkid_verify() will involve accessing the disk involved, but
that's still better than the alternative of scanning all of the disks
in the system.

Cheers,

					- Ted
