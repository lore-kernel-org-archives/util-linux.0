Return-Path: util-linux-owner@vger.kernel.org
Received: from imap.thunk.org ([74.207.234.97]:38812 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752054AbbLDPTb (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 4 Dec 2015 10:19:31 -0500
Date: Fri, 4 Dec 2015 10:19:27 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: "U.Mutlu" <for-gmane@mutluit.com>
Cc: util-linux@vger.kernel.org
Subject: Re: fsck memory leak
Message-ID: <20151204151927.GA3548@thunk.org>
References: <n3rei3$8l3$1@ger.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <n3rei3$8l3$1@ger.gmane.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Dec 04, 2015 at 08:15:14AM +0100, U.Mutlu wrote:
> Hi,
> when I as root do "touch /forcefsck" and reboot, then fsck will be done.
> But afterwards one has less free memory available than normal.
> Example:
> used mem immediately after login:
>  without fsck during boot:  98 MB (this the normal level here)
>  with fsck during boot   : 139 MB
> So, there is a memory leak of about 41 MB.

Please send the output of cat /proc/meminfo (a) before running fsck,
(b) after running fsck, and then (c) after running "echo 3 >
/proc/sys/vm/drop_caches".

Regards,

						- Ted
