Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:55200 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751985Ab1LPNSv (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 16 Dec 2011 08:18:51 -0500
Date: Fri, 16 Dec 2011 14:18:48 +0100
From: Karel Zak <kzak@redhat.com>
To: Francesco Cosoleto <cosoleto@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 04/13] fdisk: drop one parameter from try() function
Message-ID: <20111216131848.GH25486@nb.net.home>
References: <1323975769-21929-1-git-send-email-cosoleto@gmail.com> <1323975769-21929-4-git-send-email-cosoleto@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1323975769-21929-4-git-send-email-cosoleto@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Dec 15, 2011 at 08:02:40PM +0100, Francesco Cosoleto wrote:
> +				if (!is_ide_cdrom_or_tape(argv[k]))

 This function is pretty archaic, we use CDROM_GET_CAPABILITY ioctl to
 detect cdroms in libblkid/src/probe.c. 
 
 It would be nice to add 

    blkdev_is_cdrom(char *)
    blkdev_is_cdrom_fd(int fd) 

 to lkib/blkdev.c and use it for fdisk and libblkid. Volunteer? :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
