Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:46024 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751378AbaLRJw1 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 18 Dec 2014 04:52:27 -0500
Date: Thu, 18 Dec 2014 10:52:22 +0100
From: Karel Zak <kzak@redhat.com>
To: Phillip Susi <psusi@ubuntu.com>
Cc: util-linux@vger.kernel.org
Subject: Re: Remount failure without fstab or mtab
Message-ID: <20141218095222.GD19904@x2.net.home>
References: <5491A048.3070103@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5491A048.3070103@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Dec 17, 2014 at 10:24:56AM -0500, Phillip Susi wrote:
> I have a bug report in debian about "mount -o remount,rw /" failing
> because /etc/fstab does not contain an entry for the root fs, and
> /proc is not mounted ( booting with init=/bin/bash for recovery ).
> I'm not sure whether this is really a bug or not so I thought I'd ask.

This is bug, kernel does not require <source> for MS_REMOUNT, so the 
current mount(8) behavior is too restrictive.

For standard use-case we want to read mtab (/proc/self/mountinfo) to
gather all mount options for the mount syscall, but this behavior 
should be optional. 

Fixed by commit 01966ce852ac6c46e7e35a8e4f981dea88620ff8,

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
