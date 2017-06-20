Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:4640 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750846AbdFTKKN (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 20 Jun 2017 06:10:13 -0400
Date: Tue, 20 Jun 2017 12:10:09 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 4/4] agetty: cleanup usage issues
Message-ID: <20170620101009.ovse5b43niqngfyz@ws.net.home>
References: <1497872174-9852-1-git-send-email-sweet_f_a@gmx.de>
 <1497872174-9852-5-git-send-email-sweet_f_a@gmx.de>
 <201706201135.43824.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201706201135.43824.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jun 20, 2017 at 11:35:43AM +0200, Ruediger Meier wrote:
> >  	if (argc < optind + 1) {
> >  		log_warn(_("not enough arguments"));
> > -		usage(stderr);
> > +		errtryhelp(EXIT_FAILURE);
> >  	}
> 
> BTW here we print the real warning to syslog only. But a few lines below 
> we have this
>             warn(_("not enough arguments"));
>             errtryhelp(EXIT_FAILURE);
> 
> Could somebody review this, I'm not sure when agetty is allowed to write 
> to the terminal and when not. 

It's probably bad idea to use stdout/stdin/stderr before open_tty().
The file descriptors maybe open, but for sure it's better to rely on
open_tty().

For parse_args() it would be better to use log_* functions only. It
means that strtou32_or_err() and warnx() are bad idea.

For the --help and --version it's probably fine to use stdout.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
