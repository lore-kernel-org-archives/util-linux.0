Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:21598 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751089Ab2ABOBI (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 2 Jan 2012 09:01:08 -0500
Date: Mon, 2 Jan 2012 15:01:03 +0100
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <dave@gnu.org>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 5/5] s/fdisk: use CDROM_GET_CAPABILITY ioctl
Message-ID: <20120102140103.GA32748@x2.net.home>
References: <1324388530.3316.11.camel@offbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1324388530.3316.11.camel@offbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Dec 20, 2011 at 02:42:10PM +0100, Davidlohr Bueso wrote:
>  fdisk/fdisk.c    |   35 +++++++----------------------------
>  fdisk/sfdisk.c   |   37 +++++++++----------------------------
>  include/blkdev.h |    9 +++++++++
>  lib/blkdev.c     |   13 +++++++++++++

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
