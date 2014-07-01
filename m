Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:55912 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755955AbaGAJC3 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 1 Jul 2014 05:02:29 -0400
Date: Tue, 1 Jul 2014 11:02:25 +0200
From: Karel Zak <kzak@redhat.com>
To: Eric Rannaud <e@nanocritical.com>
Cc: util-linux@vger.kernel.org, Dave Reisner <d@falconindy.com>
Subject: Re: [PATCH 4/4] findmnt: use mnt_cache_set_targets() for non-kernel
 table
Message-ID: <20140701090225.GE24337@x2.net.home>
References: <747e9f8de90dc1e906d2f84f3952a801e70ef3d0.1403845374.git.e@nanocritical.com>
 <7f69c8fad1eed4faee033f1164f7481b10593413.1403845374.git.e@nanocritical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7f69c8fad1eed4faee033f1164f7481b10593413.1403845374.git.e@nanocritical.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jun 26, 2014 at 10:18:48PM -0700, Eric Rannaud wrote:
> diff --git a/misc-utils/findmnt.c b/misc-utils/findmnt.c
> index 06fdd8f41074..37dd92a10a14 100644
> --- a/misc-utils/findmnt.c
> +++ b/misc-utils/findmnt.c

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
