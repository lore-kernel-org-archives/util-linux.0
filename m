Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:46198 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751117AbaHDMP3 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 4 Aug 2014 08:15:29 -0400
Date: Mon, 4 Aug 2014 14:15:18 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 6/7] zramctl: fix mount point printout
Message-ID: <20140804121518.GC6923@x2.net.home>
References: <1407075463-19586-1-git-send-email-kerolasa@iki.fi>
 <1407075463-19586-6-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1407075463-19586-6-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Aug 03, 2014 at 03:17:42PM +0100, Sami Kerola wrote:
> See sample belo how a device mount point was printed without and with
> full <device> path.  This change adds the mount point markup to the short
> device name printout.
> 
> $ zramctl zram3
> NAME  ALGORITHM DISKSIZE DATA COMPR TOTAL STREAMS MOUNTPOINT
> zram3 lz4             1M   4K   62B    4K       1

 This is bug, it would be better improve zram_set_devname() to make it
 more robust and always convert the path to the full path. I don't think
 that any variability makes it more easy to use.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
