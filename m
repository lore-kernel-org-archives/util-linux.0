Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:55953 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752704AbaETPML (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 20 May 2014 11:12:11 -0400
Message-ID: <1400598729.5497.79.camel@oct.suse.cz>
Subject: Re: [PATCH] libblkid: detect squashfs 3 vs 4
From: Stanislav Brabec <sbrabec@suse.cz>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org, Miklos Szeredi <mszeredi@suse.cz>
Date: Tue, 20 May 2014 17:12:09 +0200
In-Reply-To: <1400581413-17456-1-git-send-email-sweet_f_a@gmx.de>
References: <1400581413-17456-1-git-send-email-sweet_f_a@gmx.de>
Content-Type: text/plain; charset="ISO-8859-2"
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Ruediger Meier wrote:
> From: Ruediger Meier <ruediger.meier@ga-group.nl>
> 
> Detect squashfs version <= 3 as squashfs3 and version >= 4 as squashfs.
> 
> squashfs kernel module version 4.0 (kernel 2.6.29) is not backward
> compatible to open squashfs created with previous versions.

Thanks for the upstreaming effort. Patch porting and upstreaming is
still in my queue.

If anybody else is interested:
https://build.opensuse.org/package/show/Base:System/util-linux
(credits and descriptions are in util-linux.changes and util-linux.spec)

> This patch comes from openSUSE / SLE. Original author was probably
> Miklos Szeredi.

Yes, it looks so.

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                          e-mail: sbrabec@suse.cz
Lihovarská 1060/12                            tel: +49 911 7405384547
190 00 Praha 9                                 fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76

