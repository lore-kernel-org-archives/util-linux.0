Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:43494 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757254Ab1FQHhi convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 17 Jun 2011 03:37:38 -0400
From: Ludwig Nussel <ludwig.nussel@suse.de>
To: util-linux@vger.kernel.org, "Ted Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH 2/4] uuid: implement uuid_generate_random_safe
Date: Fri, 17 Jun 2011 09:37:35 +0200
References: <1308232779-21018-1-git-send-email-ludwig.nussel@suse.de> <1308232779-21018-2-git-send-email-ludwig.nussel@suse.de> <20110617021517.GC29725@thunk.org>
In-Reply-To: <20110617021517.GC29725@thunk.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201106170937.36082.ludwig.nussel@suse.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Ted Ts'o wrote:
> On Thu, Jun 16, 2011 at 03:59:37PM +0200, Ludwig Nussel wrote:
> > +int uuid_generate_random_safe(uuid_t out)
> > +{
> > +	int	num = 1;
> > +	/* No real reason to use the daemon for random uuid's -- yet */
> 
> Note that amongst some distributions, there is a very strong
> resistance against using the uuidd daemon.  Partially because it's
> "yet another daemon", partially because any long-running daemon has to
> get extra review/auditing because for potential security problems,
> etc.

Yes, that concerns us too. However I'd rather have uuidd running all
the time, started in a clean environment rather than making it
getuid/setgid. A third option would be to make uuidd startable via
inetd.

> Also please note that there's only *one* user of the uuid library, the
> proprietary SAP R/3 system, that generates enough uuids, and with a
> high enough frequency, where "safety" has ever been an issue.  Most of
> the time, people simply aren't generating uuid's at the rate of
> thousands a second.

I can't judge. We got quite some pressure to set the setuid bit on
uuidd by default because 'several customers' demand it. Making the
interface more explicitly require uuidd would defeat arguments that
an application and the admin can't even notice there's a problem. 

cu
Ludwig

-- 
 (o_   Ludwig Nussel
 //\
 V_/_  http://www.suse.de/
SUSE LINUX Products GmbH, GF: Jeff Hawn, Jennifer Guild, Felix Imendörffer, HRB 16746 (AG Nürnberg) 
