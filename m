Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:42430 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751372AbdAaUAM (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 31 Jan 2017 15:00:12 -0500
Date: Tue, 31 Jan 2017 21:00:09 +0100
From: Karel Zak <kzak@redhat.com>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] lscpu: Fix regression caused by WSL detection
Message-ID: <20170131200009.tfyccytavt2si33c@ws.net.home>
References: <39000ad3-20c6-0388-3fac-d96327df3793@suse.cz>
 <14cf8f82-ff0b-b14d-24a9-3e7ced89dea6@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <14cf8f82-ff0b-b14d-24a9-3e7ced89dea6@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jan 31, 2017 at 06:38:39PM +0100, Stanislav Brabec wrote:
> Stanislav Brabec wrote:
> > Commit 7572fb2b8cb69512ca230b7fcfa11577526843f4 introduced a failure on missing
> > /proc/sys/kernel/osrelease. Make it non-fatal to prevent crash in some chroot
> > environments.
> > 
> >  	if (path_exist(_PATH_PROC_OSRELEASE)
> > -	    && (fd = path_fopen("r", 1, _PATH_PROC_OSRELEASE))) {
> > +	    && (fd = path_fopen("r", 0, _PATH_PROC_OSRELEASE))) {
> 
> It was my fault. I did not sent a patch with path_exist(_PATH_PROC_OSRELEASE) as
> 7572fb2b8cb69512ca230b7fcfa11577526843f4. It was my old version.
> 
> Use of 0 in path_fopen() seems to be a better solution that path_exist().

Yes, I have found the problem and added path_exist() like we use on
another places in the code, but you're right that path_fopen("r", 0,
...) is more elegant solution.

Fixed and path_exist() before path_fopen() removed from the another
places too.

Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
