Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:50923 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752211Ab1GKJqY (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 11 Jul 2011 05:46:24 -0400
Date: Mon, 11 Jul 2011 11:46:20 +0200
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [git pull] blockdev fixes
Message-ID: <20110711094620.GE5214@nb.net.home>
References: <BANLkTikQsgSXBs4kybTvF0QvDDvbMub5hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BANLkTikQsgSXBs4kybTvF0QvDDvbMub5hg@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jun 30, 2011 at 11:38:31AM +0200, Sami Kerola wrote:
> The following changes since commit 37b94458bd0f4a178233ad0366a727bf5bde879f:
> 
>   sfdisk: fix coding style. (2011-06-29 12:47:38 +0200)
> 
> are available in the git repository at:
>   https://github.com/kerolasa/lelux-utiliteetit blockdev
> 
> Sami Kerola (8):
>       blockdev: set options read only
>       blockdev: remove progname
>       blockdev: add --help option
>       blockdev: use libc error facilities
>       blockdev: use pathnames.h to find partitions
>       blockdev: broken compiler warning circumvention removed
>       blockdev: type mismatch fix
>       blockdev: coding style fix
> 
>  disk-utils/blockdev.c |  158 +++++++++++++++++++++---------------------------
>  1 files changed, 69 insertions(+), 89 deletions(-)

 Merged, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
