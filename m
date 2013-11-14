Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:4588 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752801Ab3KNL5O (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 14 Nov 2013 06:57:14 -0500
Date: Thu, 14 Nov 2013 12:57:11 +0100
From: Karel Zak <kzak@redhat.com>
To: Phillip Susi <psusi@ubuntu.com>
Cc: util-linux@vger.kernel.org
Subject: Re: fdisk expert print lists wrong start sector for logical
 partitions
Message-ID: <20131114115711.GE13330@x2.net.home>
References: <5283A380.6020909@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5283A380.6020909@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Nov 13, 2013 at 11:06:24AM -0500, Phillip Susi wrote:
> The expert print function shows all logical partitions as having the
> same start sector as the extended partition that contains them.

Normal mode:

 Device    Boot     Start       End Blocks  Id System
 /dev/sdb1           2048     22527  10240  83 Linux
 /dev/sdb2          22528   1228799 603136   5 Extended
 /dev/sdb5          24576    229375 102400  83 Linux
 /dev/sdb6         231424   1228799 498688  83 Linux

Expert mode:

 Nr AF   Hd Sec Cyl   Hd Sec Cyl     Start      Size Id
  1 00   32  33   0  102  37   1      2048     20480 83
  2 00  102  38   1  124  48  76     22528   1206272 05
  3 00    0   0   0    0   0   0         0         0 00
  4 00    0   0   0    0   0   0         0         0 00
  5 00  135   7   1   70  56  14      2048    204800 83
  6 00  103  26  14  124  48  76      2048    997376 83

It's correct, although probably it seems strange at a first glance.

It dumps MBR and EBR tables, nothing else. It means that you can
see all the values as stored on the device without any calculation.

I agree that this info is not too useful. Maybe we can change this old
thing and describe the whole chain of the MBR->EBR->EBR... in more
readable and more precise way. Not sure, but I guess nobody cares
about this output backward compatibility.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
