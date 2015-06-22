Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:32898 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754532AbbFVIUK (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 22 Jun 2015 04:20:10 -0400
Date: Mon, 22 Jun 2015 10:20:08 +0200
From: Karel Zak <kzak@redhat.com>
To: Phillip Susi <psusi@ubuntu.com>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: mount existing tmpfs mounts a new tmpfs
Message-ID: <20150622082008.GH1992@ws.net.home>
References: <55876C53.7030505@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55876C53.7030505@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jun 21, 2015 at 10:00:51PM -0400, Phillip Susi wrote:
> Forwarding this from debian bug #772419: Run mount /run, and it mounts
> a new tmpfs over top of the existing one in /run ( even if /run isn't
> listed in /etc/fstab ), hiding the existing files.  It should say that
> it is already mounted.

We usually don't play any policy games in userspace (exception is
mount -a).  If it's supported by kernel then it's correct behaviour.
And IMHO it's really correct behaviour because it creates a *new*
filesystem.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
--
To unsubscribe from this list: send the line "unsubscribe util-linux" in
