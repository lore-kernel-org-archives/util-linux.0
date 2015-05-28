Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:36425 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752744AbbE1KkH (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 28 May 2015 06:40:07 -0400
Date: Thu, 28 May 2015 12:40:05 +0200
From: Karel Zak <kzak@redhat.com>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] Fix /dev to /sys node name translation
Message-ID: <20150528104005.GB7285@ws.net.home>
References: <5565C2A8.1070505@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5565C2A8.1070505@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, May 27, 2015 at 03:12:08PM +0200, Stanislav Brabec wrote:
>  include/sysfs.h | 20 +++++++++++++++++++-
>  lib/sysfs.c     |  8 ++++++--
>  2 files changed, 25 insertions(+), 3 deletions(-)

 Applied, thanks.

>  static inline void sysfs_devname_to_dev_name (char *name)
> +static inline void sysfs_dev_name_to_devname (char *name)

 but I have renamed to

     sysfs_devname_sys_to_dev()
     sysfs_devname_dev_to_sys()

 because the original names have been too tricky :-)

 I have also changed some thing in sysfs.c, it would be nice if we can
 keep the crazy sysfs devnames (with '!') really only in sysfs specific
 code and externally provide regular device names.

 Please, test it -- especially lsblk.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
