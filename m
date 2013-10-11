Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:44704 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750971Ab3JKRRz (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 11 Oct 2013 13:17:55 -0400
Date: Fri, 11 Oct 2013 19:17:47 +0200
From: Karel Zak <kzak@redhat.com>
To: Phillip Susi <psusi@ubuntu.com>
Cc: Matthias Schniedermeyer <ms@citd.de>, util-linux@vger.kernel.org
Subject: Re: Filesystem specific mount options mixed with auto fs type
Message-ID: <20131011171747.GA15392@x2.net.home>
References: <5256B7CF.7010103@ubuntu.com>
 <20131010170330.GA19031@citd.de>
 <5256E3EA.4000304@ubuntu.com>
 <20131011083742.GA14457@x2.net.home>
 <525800EB.9060208@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <525800EB.9060208@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Oct 11, 2013 at 09:45:15AM -0400, Phillip Susi wrote:
> Maybe something like:
> 
> /dev/fd0 /mnt/floppy auto,vfat utf8
                       ^^^^^^^^
 Note that I wasn't right in the previous email, the list of the
 fs-types in fstab is also supported by mount(8), but it's very rarely
 used (in last 10 years a remember only one report with this setup).
 It works like "-t fs1,fs2" on mount(8) command line.

 I have doubts that anything else than mount(8) support this syntax.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
