Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:1666 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750758Ab3EMMnr (ORCPT <rfc822;util-linux-ng@vger.kernel.org>);
	Mon, 13 May 2013 08:43:47 -0400
Date: Mon, 13 May 2013 14:43:45 +0200
From: Karel Zak <kzak@redhat.com>
To: Mike Frysinger <vapier@gentoo.org>
Cc: util-linux-ng@vger.kernel.org
Subject: Re: [PATCH] standard SEE ALSO section of man pages
Message-ID: <20130513124345.GA5580@x2.net.home>
References: <1368051124-11407-1-git-send-email-vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1368051124-11407-1-git-send-email-vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, May 08, 2013 at 06:12:04PM -0400, Mike Frysinger wrote:
>  disk-utils/mkfs.bfs.8   | 2 +-
>  libblkid/libblkid.3     | 2 +-
>  misc-utils/blkid.8      | 4 ++--
>  misc-utils/findfs.8     | 3 +--
>  misc-utils/lslocks.8    | 4 ++--
>  misc-utils/wipefs.8     | 3 +--
>  sys-utils/setpriv.1     | 2 +-
>  sys-utils/switch_root.8 | 6 +++---
>  text-utils/tailf.1      | 3 ++-
>  9 files changed, 14 insertions(+), 15 deletions(-)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
