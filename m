Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:48198 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756160Ab3BNIX2 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 14 Feb 2013 03:23:28 -0500
Date: Thu, 14 Feb 2013 09:23:21 +0100
From: Karel Zak <kzak@redhat.com>
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Cc: util-linux@vger.kernel.org
Subject: Re: build problem: MNT_ERR_AMBIFS
Message-ID: <20130214082321.GB30987@x2.net.home>
References: <20130214015742.GR4278@in.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20130214015742.GR4278@in.waw.pl>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Feb 14, 2013 at 02:57:42AM +0100, Zbigniew Jędrzejewski-Szmek wrote:
> ../libmount/src/context.c: In function 'mnt_context_guess_fstype':
> ../libmount/src/context.c:1525:10: error: 'MNT_ERR_AMBIFS' undeclared (first use in this function)
> 
> ../sys-utils/mount.c: In function ‘mk_exit_code’:
> ../sys-utils/mount.c:388:9: error: ‘MNT_ERR_AMBIFS’ undeclared (first use in this function)
> 
> Incomplete git commit?

 Yep, I have modified libmount.h, but in git tree we have libmount.h.in :-)

 Fixed, Thanks!

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
