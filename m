Return-Path: util-linux-owner@vger.kernel.org
Received: from li9-11.members.linode.com ([67.18.176.11]:47758 "EHLO
	test.thunk.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751111Ab1FQCPU (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 16 Jun 2011 22:15:20 -0400
Date: Thu, 16 Jun 2011 22:15:17 -0400
From: "Ted Ts'o" <tytso@mit.edu>
To: Ludwig Nussel <ludwig.nussel@suse.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 2/4] uuid: implement uuid_generate_random_safe
Message-ID: <20110617021517.GC29725@thunk.org>
References: <1308232779-21018-1-git-send-email-ludwig.nussel@suse.de>
 <1308232779-21018-2-git-send-email-ludwig.nussel@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1308232779-21018-2-git-send-email-ludwig.nussel@suse.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jun 16, 2011 at 03:59:37PM +0200, Ludwig Nussel wrote:
> +int uuid_generate_random_safe(uuid_t out)
> +{
> +	int	num = 1;
> +	/* No real reason to use the daemon for random uuid's -- yet */

Note that amongst some distributions, there is a very strong
resistance against using the uuidd daemon.  Partially because it's
"yet another daemon", partially because any long-running daemon has to
get extra review/auditing because for potential security problems,
etc.

Also please note that there's only *one* user of the uuid library, the
proprietary SAP R/3 system, that generates enough uuids, and with a
high enough frequency, where "safety" has ever been an issue.  Most of
the time, people simply aren't generating uuid's at the rate of
thousands a second.  So I'm really not convinced it's a good idea to
assume that the uuidd daemon will *always* be installed, let alone be
running, and the wholesale deprecation of the existing interfaces
(which are compatible with interfaces used by a number of other
operating systems, BTW), just because there is this idea that the
exsting interfaces are "unsafe".  Really, they're not.

						- Ted
