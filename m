Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:35944 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933030AbaEMKSc (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 13 May 2014 06:18:32 -0400
Date: Tue, 13 May 2014 11:20:16 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: losesetup -f, broken error handling
Message-ID: <20140513092016.GN8951@x2.net.home>
References: <201405121510.46066.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201405121510.46066.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, May 12, 2014 at 03:10:45PM +0200, Ruediger Meier wrote:
> Hi,
> 
> When having a kernel without loop device support
> $ losetup -f 
> returns 0 and no warning on stderr

 The return code is mistake, but there is:

     warn(_("cannot find an unused loop device"));
 
 in the code. Please, try

    # LOOPDEV_DEBUG=yes losetup -f

 or (and) strace would be also nice.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
