Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:13943 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753907Ab1F2PAD (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 29 Jun 2011 11:00:03 -0400
Date: Wed, 29 Jun 2011 16:59:57 +0200
From: Karel Zak <kzak@redhat.com>
To: "corentin.labbe" <corentin.labbe@geomatys.fr>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] dmesg.c: print human readable timestamp
Message-ID: <20110629145957.GM6418@nb.net.home>
References: <4DD6593D.2090202@geomatys.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4DD6593D.2090202@geomatys.fr>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, May 20, 2011 at 02:06:21PM +0200, corentin.labbe wrote:
> 
> This patch add the -H option to dmesg which allow to print human
> readable time instead of the number of seconds since boot.

 Nice idea, but it's not so simple :-(

 The time stamp used for printk() is not based on normal system time
 (as you know from gettimeofday()). It uses cpu_clock() (IMHO to
 keep printk() robust and without xtime_lock).

 The problem is that the cpu_clock is not updated after system resume,
 so if you suspend (e.g. pm-suspend(8)) and resume than the dmesg -H
 command prints nonsenses...

 For example (copy & past from /var/log/messages):

  Jun 27 23:39:53 nb kernel: [50065.238635] PM: Syncing filesystems  ... done.
  Jun 28 20:23:29 nb kernel: [50065.284226] Freezing user space  processes ... (elapsed 0.09 seconds) done.
                              ^^^^^
 The first line is before suspend and second is after resume. The time
 stamp [50065.xxxxxx] is still the same although the system was
 suspended for almost whole day.
 
 The same system, the latest kernel message:

    # date
    Wed Jun 29 16:29:28 CEST 2011

    # mount /dev/sdb1 /mnt/test

    # ./sys-utils/dmesg -H | tail -1 
    [Tue Jun 28 11:10:41 2011] EXT4-fs (sdb1): mounted filesystem with ordered data mode. Opts: (null)


  Karel

