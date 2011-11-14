Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:58111 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750836Ab1KNNnC (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 14 Nov 2011 08:43:02 -0500
Date: Mon, 14 Nov 2011 14:42:59 +0100
From: Karel Zak <kzak@redhat.com>
To: Francesco Cosoleto <cosoleto@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/5] fdisk: print the welcome message when OSF/1
	disklabel is detected
Message-ID: <20111114134259.GB20881@nb.net.home>
References: <1321006331-7633-1-git-send-email-cosoleto@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1321006331-7633-1-git-send-email-cosoleto@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Nov 11, 2011 at 11:12:07AM +0100, Francesco Cosoleto wrote:
>  fdisk/fdisk.c |    9 +++++----
>  1 files changed, 5 insertions(+), 4 deletions(-)

Applied (all patches), thanks.

>  	gpt_warning(disk_device);
>  	get_boot(fdisk);
>  
> +	fprintf(stderr, _("Welcome to fdisk (%s).\n\n"
> +		"Changes will remain in memory only, until you decide to write them.\n"
> +		"Be careful before using the write command.\n"), PACKAGE_STRING);
> +

 I have moved this message before gpt_warning() and get_boot(). The
 get_boot() produces very often warnings (for example on disk with no
 PT) and I think that the welcome message should be printed as very
 first message in the interactive mode.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
