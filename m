Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:57607 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752892AbbKSLEN (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 19 Nov 2015 06:04:13 -0500
Date: Thu, 19 Nov 2015 12:04:11 +0100
From: Karel Zak <kzak@redhat.com>
To: Ming Lei <tom.leiming@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH v1 0/2] losetup: support direct-IO to backing file
Message-ID: <20151119110411.GA4955@ws.net.home>
References: <1447770768-15358-1-git-send-email-tom.leiming@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1447770768-15358-1-git-send-email-tom.leiming@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Nov 17, 2015 at 10:32:46PM +0800, Ming Lei wrote:
>  include/loopdev.h   |  4 ++++
>  lib/loopdev.c       | 40 ++++++++++++++++++++++++++++++++++++++++
>  sys-utils/losetup.c | 33 +++++++++++++++++++++++++++++++--
>  3 files changed, 75 insertions(+), 2 deletions(-)
> 
> 
> [1] https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=bc07c10a3603a5ab3ef01ba42b3d41f9ac63d1b6
> 
> V1:
> 	- support to set direct IO for 'new' device, such as 
> 		loseutp --direct-io 1 -f test.img

Applied, thanks!

I have a little bit changed the command line option to:

    --direct-io[=on|off]

where the default is "on", so you can use:

    losetup -f --direct-io file.img

to enable direct-io, to disable you have to use:

    losetup --direct-io=off /dev/loop0

I guess the most common usage will be to enable direct I/O :-)


https://github.com/karelzak/util-linux/commit/f98d9641a371421640a8f1cfe497030758f86dca

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
