Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:32948 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751001Ab1JLI0Q (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 12 Oct 2011 04:26:16 -0400
Date: Wed, 12 Oct 2011 10:25:50 +0200
From: Karel Zak <kzak@redhat.com>
To: Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 1/2] fdisk: don't shorten long path to disk device
Message-ID: <20111012082550.GA9667@nb.net.home>
References: <1318252338-11200-1-git-send-email-petr.uzel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1318252338-11200-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Oct 10, 2011 at 03:12:17PM +0200, Petr Uzel wrote:
> fdisk/partname.c:partname() uses fixed 80 char static buffer for partition
> name. This might be not enough if the used path to the disk device is long
> enough, e.g.
[...]
> -	static char bufp[80];
> +	char *bufp;

Hmm, after review... your idea to increase the static buffer
size to PATH_MAX seems less invasive ;-)

 -       static char bufp[80];
 +       static char bufp[PATH_MAX];


Fixed :-)

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
