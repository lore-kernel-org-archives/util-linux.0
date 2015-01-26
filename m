Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:47725 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752075AbbAZKRb (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 26 Jan 2015 05:17:31 -0500
Date: Mon, 26 Jan 2015 11:17:22 +0100
From: Karel Zak <kzak@redhat.com>
To: JWP <elseifthen@gmx.com>
Cc: Benno Schulenberg <bensberg@justemail.net>, util-linux@vger.kernel.org
Subject: Re: [PATCH] textual: fix spellos and inconsistencies in several
 program messages
Message-ID: <20150126101722.GC6354@x2.net.home>
References: <1421612229-5535-1-git-send-email-bensberg@justemail.net>
 <54BC1947.6060107@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <54BC1947.6060107@gmx.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jan 18, 2015 at 03:36:23PM -0500, JWP wrote:
> > -		ui_warn(_("Cannot open: %s"), buf);
> > +		ui_warn(_("Cannot open %s"), buf);
> 
> > -		ui_warn(_("Cannot open: %s"), buf);
> > +		ui_warn(_("Cannot open %s"), buf);
> 
> > -		fdisk_warn(cxt, _("Cannot open: %s"), filename);
> > +		fdisk_warn(cxt, _("Cannot open %s"), filename);
> 
> > -		fdisk_warn(cxt, _("Cannot open: %s"), filename);
> > +		fdisk_warn(cxt, _("Cannot open %s"), filename);
> 
> > -		warn(_("cannot open: %s"), devname);
> > +		warn(_("cannot open %s"), devname);
> 
> > -			warn(_("cannot open: %s"), dev);
> > +			warn(_("cannot open %s"), dev);
> 
> > -		warn(_("cannot open: %s"), devname);
> > +		warn(_("cannot open %s"), devname);
> 
> > -					"--map-root-user are mutually exclusive."));
> > +					"--map-root-user are mutually exclusive"));
> 
> > -			log_warn(_("cannot open: %s: %m"), _PATH_OS_RELEASE);
> > +			log_warn(_("cannot open %s: %m"), _PATH_OS_RELEASE);
> 
> > -		err(EXIT_FAILURE, _("cannot open: %s"), AGETTY_RELOAD_FILENAME);
> > +		err(EXIT_FAILURE, _("cannot open %s"), AGETTY_RELOAD_FILENAME);
> 
> Hey Benno, I thought we weren't allowed to make changes for punctuation only!

This is wanted and expected change, because "cannot open %s" is
already translated and used on many many place in code. The goal is
consolidation of the messages...

    Karel

> 

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
