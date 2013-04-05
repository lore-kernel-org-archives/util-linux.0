Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:37204 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751506Ab3DEMKh (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 5 Apr 2013 08:10:37 -0400
Date: Fri, 5 Apr 2013 14:10:27 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 00/13] pull: fixes in preparation to v2.23 release
Message-ID: <20130405121027.GE14350@x2.net.home>
References: <1364931777-2645-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1364931777-2645-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Apr 02, 2013 at 08:42:44PM +0100, Sami Kerola wrote:
>       docs: fix type in mkfs.8

 already fixed

>       newgrp: use xstrdup to check allocation succeeded
>       agetty: add -h and -V options
>       dmesg: fix usage() output consistancy
>       fsfreeze: tell user when mandatory option is not specified
>       losetup: allow -j option argument to be relative path
>       lscpu: fix error message
>       partx: remove deprecated option from usage()
>       setarch: add option to list settable architectures
>       setterm: fix various color option argument lists
>       vipw: add usage() function
>       chrt: make command syntax easier to understand in usage()
>       logger: make local sockets to try both stream and datagram

 all applied, thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
