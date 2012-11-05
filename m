Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:33374 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751416Ab2KEQnC (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 5 Nov 2012 11:43:02 -0500
Date: Mon, 5 Nov 2012 17:42:51 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 00/13] make ipcs to use proc
Message-ID: <20121105164251.GA3799@x2.net.home>
References: <1350246145-10600-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1350246145-10600-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Oct 14, 2012 at 09:22:12PM +0100, Sami Kerola wrote:
> Sami Kerola (13):

 I have created ipc branch at hithub and applied some of the patches
 (unfortunately with many changes).

 Unfortunately I have no more time to play with this stuff this week,
 but I guess that it's pretty obvious from already applied patches how
 should be implemented the rest.

 Changes:

    - created sys-utils/ipcutils.{c,h}
    - renamed functions
    - replaced all 'unsigned long' and 'size_t' with uint64_t

     The reason why we want to read from /proc is to be robust on
     systems where kernel is 64bit and userspace is 32bit. You cannot
     use long or size_t for data from /sys or /proc...

>       ipcs: add data structures to read state from /proc & /sys

  applied

>       ipcs: add /proc and /sys path definitions

  applied (btw, where was nice typo)

>       ipcs: determine ipc limits from /proc

  applied

>       ipcs: add new permissions printing function

  applied

>       ipcs: read shared memory values from /proc

  applied

>       ipcs: read message queue values from /proc
>       ipsc: read semaphore values from /proc
>       ipcs: clean up permissions printing

 not applied

>       ipcs: make individual shared memory id printing to use /proc

  applied

>       ipcs: make individual message queue id printing to use /proc
>       ipcs: make individual semaphore id printing to use /proc
>       ipcs: validate numeric user input
>       docs: update TODO

 not applied

 ... so, all around share memory should be applied/fixed. Now we need
 to do the same for sem and msg stuff.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
