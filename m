Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:13184 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751142Ab1HQH4R (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 17 Aug 2011 03:56:17 -0400
Date: Wed, 17 Aug 2011 09:56:13 +0200
From: Karel Zak <kzak@redhat.com>
To: giulioo@pobox.com
Cc: util-linux@vger.kernel.org
Subject: Re: sfdisk: trying to create aligned partitions: fail
Message-ID: <20110817075613.GB28856@nb.net.home>
References: <20110817061256.BB29DF815@i3.golden.dom>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110817061256.BB29DF815@i3.golden.dom>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Aug 17, 2011 at 08:13:06AM +0200, Giulio wrote:
> Linux 2.6.18-238.12.1.el5
> sfdisk from util-linux 2.20-rc1
> fdisk (util-linux 2.20-rc1)
> 200GB VMware SCSI disk
> 
> It seems it's not immediately possible to create aligned partitions (ie:
> starting at 1MB/2048 sectors) with sfdisk.

 This is unsupported by sfdisk and cfdisk. You have to use fdisk or
 parted.

 I'll add a note about it to the man page...

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
