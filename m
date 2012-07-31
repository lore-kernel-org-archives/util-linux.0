Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:8612 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754814Ab2GaI6f (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 31 Jul 2012 04:58:35 -0400
Date: Tue, 31 Jul 2012 10:58:31 +0200
From: Karel Zak <kzak@redhat.com>
To: "Mantas M." <grawity@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: vipw does not work with some editors
Message-ID: <20120731085831.GB15070@x2.net.home>
References: <20120730212010.GA56766@rain.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120730212010.GA56766@rain.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jul 31, 2012 at 12:20:10AM +0300, Mantas M. wrote:
> Some editors, such as Vim with 'writebackup' mode enabled, use "atomic
> save" in which the old file is deleted and a new one with the same name
> created in its place. When `vipw` is used with such an editor, it never
> detects changes, because it compares fstat() on a file descriptor
> pointing to the old file.
> 
> Can this be fixed in `vipw`, or should I just start configuring Vim to
> stop making backups for vipw's temporary files?

hmm.. vipw from shadow-utils uses stat() rather than fstat(), so it
depends on filename only. Maybe we can use the same solution.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
