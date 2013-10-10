Return-Path: util-linux-owner@vger.kernel.org
Received: from awesome.dsw2k3.info ([217.188.63.246]:34564 "EHLO
	awesome.dsw2k3.info" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755574Ab3JJRDg (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 10 Oct 2013 13:03:36 -0400
Date: Thu, 10 Oct 2013 19:03:30 +0200
From: Matthias Schniedermeyer <ms@citd.de>
To: Phillip Susi <psusi@ubuntu.com>
Cc: util-linux@vger.kernel.org
Subject: Re: Filesystem specific mount options mixed with auto fs type
Message-ID: <20131010170330.GA19031@citd.de>
References: <5256B7CF.7010103@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5256B7CF.7010103@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 10.10.2013 10:21, Phillip Susi wrote:
> 
> I came across an old bug report where the user had set the utf8 mount
> option in /etc/fstab on a floppy, presumably to apply to a fat
> filesystem, but when a disk formatted with ext2 was used, the mount
> failed sine ext2 doesn't support this option.
> 
> That got me wondering, how are you supposed to specify mount options
> with the auto fs type?  Certainly you don't just have to limit the
> options to ones that are universal to all filesystems?  But how to
> specify that these options are for fs A, and these for fs B?

AFAIK "mount -s" is just for that case:

- man mount -
      -s Tolerate sloppy mount options rather than failing. This will 
ignore mount options not supported by a filesystem type. Not all 
filesystems support this option. This option exists for support of the 
Linux autofs-based automounter.
- man mount -




-- 

Matthias
