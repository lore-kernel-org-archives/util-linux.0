Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:23723 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755111AbaBRPYW (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 18 Feb 2014 10:24:22 -0500
Date: Tue, 18 Feb 2014 16:16:50 +0100
From: Karel Zak <kzak@redhat.com>
To: Phillip Susi <psusi@ubuntu.com>
Cc: util-linux@vger.kernel.org
Subject: Re: Option to create missing mount point
Message-ID: <20140218151650.GA32225@x2.net.home>
References: <53037325.3090808@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <53037325.3090808@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Feb 18, 2014 at 09:50:13AM -0500, Phillip Susi wrote:
> A debian bug has requested that mount create the mount point if it
> does not exist yet.  My initial reaction was no, but one use case does
> seem to be a good reason.  That would be if you want to set up a tmpfs
> mount with several sub mounts in /etc/fstab.  You currently can't do
> that since when the tmpfs is mounted, it is empty.  Is this something
> that might be a good idea?

Yes, v2.23 release notes:

mount(8):
  - supports new userspace mount option x-mount.mkdir[=<mode>] to
    create mountpoints on demand

it's also in man page :)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
