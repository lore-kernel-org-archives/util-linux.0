Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-vb0-f46.google.com ([209.85.212.46]:36946 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752084Ab2IHD4E (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 7 Sep 2012 23:56:04 -0400
Received: by vbbff1 with SMTP id ff1so207329vbb.19
        for <util-linux@vger.kernel.org>; Fri, 07 Sep 2012 20:56:02 -0700 (PDT)
Date: Fri, 7 Sep 2012 23:56:00 -0400
From: Dave Reisner <d@falconindy.com>
To: util-linux@vger.kernel.org
Subject: hwclock fail with 2.22
Message-ID: <20120908035600.GM1899@rampage>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

I'm trying to figure out a bug report that I received the other day with
hwclock, and I'm curious if anyone else has seen the behavior. I'm not
able to reproduce reliably as the user is:

https://bugs.archlinux.org/task/31416

The bits about fsck can be ignored, they're merely a symptom. I was able
to trace this behavior with an educated guess back to 839be2ba6.

I suppose part of the issue is that I'm fairly oblivious about how the
hwclock works, and the interaction with the timezone, particularly when
the clock is set to UTC. The reporter is using sysvinit with Arch
Linux's initscripts. hwclock's involvement in his case boils down to the
following call on bootup:

hwclock --systz --utc --noadjfile

Of course, the --systz flag in there won't work as it used to anymore,
but the commit message I've picked out doesn't seem to match the
behavior it changes.

Any insight would be appreciated.

Cheers,
Dave
