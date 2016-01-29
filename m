Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:47433 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755330AbcA2Lw7 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 29 Jan 2016 06:52:59 -0500
Date: Fri, 29 Jan 2016 12:52:57 +0100
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: test sfdisk, optimal_iosize
Message-ID: <20160129115257.rx4pjzyglhi46get@ws.net.home>
References: <201601291131.29201.sweet_f_a@gmx.de>
 <20160129113110.o76pvon3wormblgd@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20160129113110.o76pvon3wormblgd@ws.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Jan 29, 2016 at 12:31:10PM +0100, Karel Zak wrote:
> > Where does this optimal iosize come from, scsi_debug module?
> > Is there a commandline tool to get this iosize, maybe blkid?
> 
>  cat /sys/block/sda/queue/{optimal,minimum}_io_size
>  cat /sys/block/sda/queue/{physical,logical}_block_size

 And also by ioctl:

   blockdev --getiomin --getioopt /dev/sdc

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
