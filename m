Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:23471 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753580AbbFVImu (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 22 Jun 2015 04:42:50 -0400
Date: Mon, 22 Jun 2015 10:42:48 +0200
From: Karel Zak <kzak@redhat.com>
To: Phillip Susi <psusi@ubuntu.com>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: Manual sections vs. /bin or /sbin location
Message-ID: <20150622084248.GI1992@ws.net.home>
References: <558768CB.8090209@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <558768CB.8090209@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jun 21, 2015 at 09:45:47PM -0400, Phillip Susi wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA512
> 
> I came across a bug report in Debian noting that findmnt is in /bin,
> not /sbin, but its manual page is in section 8.  Should one or the
> other be moved so they line up?

Good point, although I don't think that everything in section 8 has to
be in /sbin.

findmnt, lsblk and lslocks have been originally designed as
administrator's tools so we have selected section 8, but now it's
pretty usable for non-root users and the tools are commonly used, so
maybe move it to the section 1 makes sense.

I don't have any strong opinion about it, if you want to move the man
pages to the section 1 then send a patch. The paths should be
unchanged.


    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
--
To unsubscribe from this list: send the line "unsubscribe util-linux" in
