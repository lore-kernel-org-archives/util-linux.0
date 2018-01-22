Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:34676 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750973AbeAVJJ0 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 22 Jan 2018 04:09:26 -0500
Date: Mon, 22 Jan 2018 10:09:23 +0100
From: Karel Zak <kzak@redhat.com>
To: Mike Frysinger <vapier@gentoo.org>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] mount(8): drop redundant filesystem-specific sections
Message-ID: <20180122090923.io62zeuwnv25iw7p@ws.net.home>
References: <20180119184520.13067-1-vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180119184520.13067-1-vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Jan 19, 2018 at 01:45:20PM -0500, Mike Frysinger wrote:
> Add a new section to the top of the filesystem-specific chapter to point
> people generally to the filesystem-specific man pages.  This way we can
> delete all the redundant subsections that say the same thing.

Well, the subsections also provides the name of the package where is FS
specific man page :-)

> -.SS "Mount options for xfs"
> -See the options section of the
> -.BR xfs (5)
> -man page (the xfsprogs package must be installed).

It's probably not so important (and I have no strong opinion about
it), but I can imagine that for end-users it's useful. Maybe we can
add to the man page a small table with FS name, man page and package
name:

      xfs   xfs(5)          xfsprogs
      ext4  ext4(5)         e2fsprogs
      cifs  mount.cifs(8)   cifs-utils
      ...

or is it overkill?

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
