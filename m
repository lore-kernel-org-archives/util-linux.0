Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:54260 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751274AbdAaRje (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 31 Jan 2017 12:39:34 -0500
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9292DAAA3
        for <util-linux@vger.kernel.org>; Tue, 31 Jan 2017 17:38:39 +0000 (UTC)
Subject: Re: [PATCH] lscpu: Fix regression caused by WSL detection
To: util-linux@vger.kernel.org
References: <39000ad3-20c6-0388-3fac-d96327df3793@suse.cz>
From: Stanislav Brabec <sbrabec@suse.cz>
Message-ID: <14cf8f82-ff0b-b14d-24a9-3e7ced89dea6@suse.cz>
Date: Tue, 31 Jan 2017 18:38:39 +0100
MIME-Version: 1.0
In-Reply-To: <39000ad3-20c6-0388-3fac-d96327df3793@suse.cz>
Content-Type: text/plain; charset=iso-8859-2
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Stanislav Brabec wrote:
> Commit 7572fb2b8cb69512ca230b7fcfa11577526843f4 introduced a failure on missing
> /proc/sys/kernel/osrelease. Make it non-fatal to prevent crash in some chroot
> environments.
> 
>  	if (path_exist(_PATH_PROC_OSRELEASE)
> -	    && (fd = path_fopen("r", 1, _PATH_PROC_OSRELEASE))) {
> +	    && (fd = path_fopen("r", 0, _PATH_PROC_OSRELEASE))) {

It was my fault. I did not sent a patch with path_exist(_PATH_PROC_OSRELEASE) as
7572fb2b8cb69512ca230b7fcfa11577526843f4. It was my old version.

Use of 0 in path_fopen() seems to be a better solution that path_exist().

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                         e-mail: sbrabec@suse.com
Køi¾íkova 148/34 (Corso IIa)                  tel: +49 911 7405384547
186 00 Praha 8-Karlín                          fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76
