Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:59549 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751395AbaAGI6p (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 7 Jan 2014 03:58:45 -0500
Date: Tue, 7 Jan 2014 09:58:31 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] uuidd: use pkg-config to find systemd-deamon support
Message-ID: <20140107085831.GK31045@x2.net.home>
References: <1389051548-1268-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1389051548-1268-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jan 06, 2014 at 11:39:08PM +0000, Sami Kerola wrote:
>  configure.ac             |   3 +
>  misc-utils/Makemodule.am |   3 +-
>  misc-utils/sd-daemon.c   | 520 -----------------------------------------------
>  misc-utils/sd-daemon.h   | 282 -------------------------
>  misc-utils/uuidd.c       |   2 +-

 Seems like a good idea, unfortunately I'm not sure about it. 
 
 The systemd (udevd) depends on libblkid+libuuid, it would be 
 probably better to keep util-linux without dependencies on systemd
 libs otherwise we will introduce a cyclic dependence -- it could be
 too tricky for some build systems and users :-) I'll think about it...

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
