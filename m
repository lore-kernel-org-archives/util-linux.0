Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:38512 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754780AbbESItQ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 19 May 2015 04:49:16 -0400
Date: Tue, 19 May 2015 10:08:29 +0200
From: Karel Zak <kzak@redhat.com>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] Fix /sys to /dev node name translation
Message-ID: <20150519080829.GO4834@ws.net.home>
References: <555A3E16.6090003@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <555A3E16.6090003@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, May 18, 2015 at 09:31:34PM +0200, Stanislav Brabec wrote:
> linux/drivers/base/core.c: device_get_devnode() defines a translation of
> '!' in sysfs nodes to '/' in /dev nodes. The same translation has to be
> done to properly support device nodes with slash (e. g. device nodes of
> cciss driver and several other drivers).

Strange feature.

> +	/* replace '!' in the name with '/', see
> +	 * linux/drivers/base/core.c: device_get_devnode() */
> +	while ((s = strchr(name, '!')))
> +		s[0] = '/';


 What about to add small inline function sysfs_fix_devname() to
 include/sysfs.h ?

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
