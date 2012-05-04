Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:17720 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753515Ab2EDOZ5 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 4 May 2012 10:25:57 -0400
Date: Fri, 4 May 2012 16:25:31 +0200
From: Karel Zak <kzak@redhat.com>
To: Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 00/15] uuidd: refactoring & systemd support (take 2)
Message-ID: <20120504142531.GD11606@x2.net.home>
References: <1336071721-32492-1-git-send-email-petr.uzel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1336071721-32492-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, May 03, 2012 at 09:01:46PM +0200, Petr Uzel wrote:
> Regarding the last patch in the series, it addresses issue described in
> http://marc.info/?l=util-linux-ng&m=133405763330121&w=2 in the way recomended
> by Karel. However, after implementing it, I'm wondering: wouldn't it be cleaner
> to just test if /dev/u?random exists and is readable in uuid_generate() instead
> of calling random_get_fd() and passing the fd down the stack?

 random_get_fd() does much more than only open the file

>  Makefile.am                 |    3 +-
>  configure.ac                |   23 ++
>  fdisk/fdiskdoslabel.c       |    2 +-
>  include/randutils.h         |    2 +-
>  lib/randutils.c             |    8 +-
>  libuuid/src/Makefile.am     |    1 -
>  libuuid/src/gen_uuid.c      |   65 +-----
>  libuuid/src/uuidd.h         |    2 +-
>  misc-utils/.gitignore       |    1 +
>  misc-utils/Makefile.am      |   17 ++-
>  misc-utils/sd-daemon.c      |  530 +++++++++++++++++++++++++++++++++++++++++++
>  misc-utils/sd-daemon.h      |  282 +++++++++++++++++++++++
>  misc-utils/uuidd.8          |   12 +
>  misc-utils/uuidd.c          |  313 +++++++++++++++++---------
>  misc-utils/uuidd.service.in |    9 +
>  misc-utils/uuidd.socket     |    8 +
>  16 files changed, 1109 insertions(+), 169 deletions(-)
>  create mode 100644 misc-utils/sd-daemon.c
>  create mode 100644 misc-utils/sd-daemon.h
>  create mode 100644 misc-utils/uuidd.service.in
>  create mode 100644 misc-utils/uuidd.socket

 Applied, thanks a lot!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
