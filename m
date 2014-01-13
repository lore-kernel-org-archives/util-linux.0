Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:20621 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751328AbaAMIsz (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 13 Jan 2014 03:48:55 -0500
Date: Mon, 13 Jan 2014 09:48:52 +0100
From: Karel Zak <kzak@redhat.com>
To: Phillip Susi <psusi@ubuntu.com>
Cc: util-linux@vger.kernel.org
Subject: Re: Another question on bind mounts without mtab
Message-ID: <20140113084852.GA14364@x2.net.home>
References: <52D005DC.1000809@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <52D005DC.1000809@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Jan 10, 2014 at 09:38:20AM -0500, Phillip Susi wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> I've had another question come up about bind mounts and the lack of
> mtab and I'm not sure how to answer it because it does seem a more
> important use case that has been lost than those previously discussed.
> 
> If /dev/sda1 is mounted in /, and you bind mount /home/foo to /mnt,
> then there is no way to tell from the output of mount that it is in
> fact, the /home/foo directory of /dev/sda1 that is in /mnt.  It looks
> like you just bind mounted the whole drive there, and the subdirectory
> path is lost.

 See findmnt output, the /proc/self/mountinfo contains info about the
 mounted filesystem directory (usually '/', but /home/foo in your
 example).

 Note that I'd like to learn people to use findmnt(8) rather mount
 output. The mount(8) output is there mostly for backward
 compatibility.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
