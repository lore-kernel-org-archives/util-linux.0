Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:58827 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751335Ab1FPPia (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 16 Jun 2011 11:38:30 -0400
Date: Thu, 16 Jun 2011 17:38:26 +0200
From: Karel Zak <kzak@redhat.com>
To: Ludwig Nussel <ludwig.nussel@suse.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/4] uuidgen: fail if uuidd isn't running
Message-ID: <20110616153826.GA5352@nb.redhat.com>
References: <1308232779-21018-1-git-send-email-ludwig.nussel@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1308232779-21018-1-git-send-email-ludwig.nussel@suse.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jun 16, 2011 at 03:59:36PM +0200, Ludwig Nussel wrote: 
> -static void usage(const char *progname)
> +static const struct option long_options[] = {
> +	{ "time",      0, NULL, 't' },
> +	{ "random",    0, NULL, 'r' },
> +	{ "force",     0, NULL, 128 },
                            ^^^^
              Why not 'f' (as short option)?

  Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
