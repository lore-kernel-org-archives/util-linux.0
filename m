Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:47729 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932353AbcCNPKl (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 14 Mar 2016 11:10:41 -0400
Date: Mon, 14 Mar 2016 16:10:34 +0100
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: Isaac Dunham <ibid.ag@gmail.com>, util-linux@vger.kernel.org
Subject: Re: [PATCH 00/12] another BSD/OSX related patch-set
Message-ID: <20160314151034.mszzctntfnxjbun6@ws.net.home>
References: <1457392322-4974-1-git-send-email-sweet_f_a@gmx.de>
 <20160308012836.GA26455@newbook>
 <201603140243.40546.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201603140243.40546.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Mar 14, 2016 at 02:43:40AM +0100, Ruediger Meier wrote:
> > > Ruediger Meier (12):
> > >   wipefs, sfdisk: include libgen.h for basename(3p)
> >
> > I'm glad to see use of POSIX basename(), which is the only version
> > that musl implements.
> 
> There are still two files to be fixed
>   login-utils/last.c
>   login-utils/su-common.c
> 
> On the other hand I thought we could also completely avoid basename(3p) 
> and use something like our stripoff_last_component() from 
> lib/fileutils.c.

Yep, and maybe also introduce strdup_last_component() in case we
don't want to modify the original path.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
