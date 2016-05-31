Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:55813 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753194AbcEaLWV (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 31 May 2016 07:22:21 -0400
Date: Tue, 31 May 2016 13:22:14 +0200
From: Karel Zak <kzak@redhat.com>
To: Mike Frysinger <vapier@gentoo.org>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] man pages: fix spacing between man page name & section
 number
Message-ID: <20160531112214.a3i4kls277r5v2lj@ws.net.home>
References: <1462908414-11449-1-git-send-email-vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1462908414-11449-1-git-send-email-vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, May 10, 2016 at 03:26:54PM -0400, Mike Frysinger wrote:
>  disk-utils/cfdisk.8 | 2 +-
>  disk-utils/sfdisk.8 | 4 ++--
>  misc-utils/kill.1   | 2 +-
>  misc-utils/logger.1 | 2 +-
>  sys-utils/losetup.8 | 2 +-
>  5 files changed, 6 insertions(+), 6 deletions(-)

 Applied, thanks.

>  .SH ENCRYPTION
>  .B Cryptoloop is no longer supported in favor of dm-crypt.
> -.B For more details see cryptsetup (8).
> +.B For more details see cryptsetup(8).

 I think "big fat warning" is fine here.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
