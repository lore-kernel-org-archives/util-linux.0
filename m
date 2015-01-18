Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:65264 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751596AbbARUgb (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 18 Jan 2015 15:36:31 -0500
Message-ID: <54BC1947.6060107@gmx.com>
Date: Sun, 18 Jan 2015 15:36:23 -0500
From: JWP <elseifthen@gmx.com>
MIME-Version: 1.0
To: Benno Schulenberg <bensberg@justemail.net>, util-linux@vger.kernel.org
Subject: Re: [PATCH] textual: fix spellos and inconsistencies in several program
 messages
References: <1421612229-5535-1-git-send-email-bensberg@justemail.net>
In-Reply-To: <1421612229-5535-1-git-send-email-bensberg@justemail.net>
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

> -		ui_warn(_("Cannot open: %s"), buf);
> +		ui_warn(_("Cannot open %s"), buf);

> -		ui_warn(_("Cannot open: %s"), buf);
> +		ui_warn(_("Cannot open %s"), buf);

> -		fdisk_warn(cxt, _("Cannot open: %s"), filename);
> +		fdisk_warn(cxt, _("Cannot open %s"), filename);

> -		fdisk_warn(cxt, _("Cannot open: %s"), filename);
> +		fdisk_warn(cxt, _("Cannot open %s"), filename);

> -		warn(_("cannot open: %s"), devname);
> +		warn(_("cannot open %s"), devname);

> -			warn(_("cannot open: %s"), dev);
> +			warn(_("cannot open %s"), dev);

> -		warn(_("cannot open: %s"), devname);
> +		warn(_("cannot open %s"), devname);

> -					"--map-root-user are mutually exclusive."));
> +					"--map-root-user are mutually exclusive"));

> -			log_warn(_("cannot open: %s: %m"), _PATH_OS_RELEASE);
> +			log_warn(_("cannot open %s: %m"), _PATH_OS_RELEASE);

> -		err(EXIT_FAILURE, _("cannot open: %s"), AGETTY_RELOAD_FILENAME);
> +		err(EXIT_FAILURE, _("cannot open %s"), AGETTY_RELOAD_FILENAME);

Hey Benno, I thought we weren't allowed to make changes for punctuation only!

