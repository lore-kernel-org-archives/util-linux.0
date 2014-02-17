Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:44601 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751851AbaBQMTr (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 17 Feb 2014 07:19:47 -0500
Date: Mon, 17 Feb 2014 13:19:43 +0100
From: Karel Zak <kzak@redhat.com>
To: Phillip Susi <psusi@ubuntu.com>
Cc: util-linux@vger.kernel.org
Subject: Re: Can't unmount broken nfs mount
Message-ID: <20140217121943.GE2254@x2.net.home>
References: <52F95FD1.5090305@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <52F95FD1.5090305@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Feb 10, 2014 at 06:25:05PM -0500, Phillip Susi wrote:
> Forwarding from debian bug #711183:
> 
> User reports that a broken nfs mount has its mounted directory in
> /proc/mounts renamed from /foo to /foo\040(deleted) when an nfs mount
> is broken due to an unreachable server, and this prevents unmounting
> it since umount can not find "/foo" in /proc/mounts.  Is this a kernel
> bug, or something that umount needs to work around?

I have improved the mountinfo libmount parser, now it removes the
"\040(deleted)" from the target path. You can try it with NFS.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
