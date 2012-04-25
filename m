Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:35868 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752394Ab2DYH4b (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 25 Apr 2012 03:56:31 -0400
Date: Wed, 25 Apr 2012 09:56:28 +0200
From: Karel Zak <kzak@redhat.com>
To: Marcin Szewczyk <Marcin.Szewczyk@wodny.org>
Cc: util-linux@vger.kernel.org
Subject: Re: Duplicate UUIDs, findmnt, /dev/disk/by-uuid
Message-ID: <20120425075628.GD17370@x2.net.home>
References: <20120423154106.GD2437@magazyn-ziarno.zbozowa>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120423154106.GD2437@magazyn-ziarno.zbozowa>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Apr 23, 2012 at 05:41:06PM +0200, Marcin Szewczyk wrote:
> As a workaround I use /proc/self/mountinfo as it gives me major and
> minor numbers.
> 
> My question is: is there a way to force findmnt to use major and minor
> numbers from /proc/self/mountinfo to identify disks/partitions?

 Implemented (in upstream tree).

 $ findmnt 8:1
 TARGET    SOURCE    FSTYPE OPTIONS
 /boot/efi /dev/sda1 vfat   rw,relatime,fmask=0077,dmask=0077,codepage=cp437,ioch


 (or with "--source 8:1" option to make it more explicit)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
