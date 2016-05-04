Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:45792 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757656AbcEDIoF (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 4 May 2016 04:44:05 -0400
Date: Wed, 4 May 2016 10:44:03 +0200
From: Karel Zak <kzak@redhat.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Linux Containers <containers@lists.linux-foundation.org>,
        util-linux@vger.kernel.org
Subject: Re: bind mounting namespace inodes for unprivileged users
Message-ID: <20160504084403.7z67paycj663lkbt@ws.net.home>
References: <1462299656.16133.51.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1462299656.16133.51.camel@HansenPartnership.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, May 03, 2016 at 02:20:56PM -0400, James Bottomley wrote:
> Right at the moment, unprivileged users cannot call mount --bind to
> create a permanent copy of any of their namespaces.  This is annoying
> because it means that for entry to long running containers you have to
> spawn an undying process and use nsenter via the /proc/<pid>/ns files.

Well, unshare is able to create permanent namespaces and the bind
mounts and nsenter is able to follow these files, but you need root
permissions to create this stuff.

 touch /home/kzak/ns
 sudo unshare --uts=/home/kzak/ns
 <exit namespace>

 sudo nsenter --uts=/home/kzak/ns

it means you really do not need any process in the namespace.


Not sure about unprivileged users, it always sounds like a game with
Pandora's box ;-)

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
