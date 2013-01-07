Return-Path: util-linux-owner@vger.kernel.org
Received: from charlotte.tuxdriver.com ([70.61.120.58]:34957 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751705Ab3AGO6z (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 7 Jan 2013 09:58:55 -0500
Date: Mon, 7 Jan 2013 09:58:48 -0500
From: Neil Horman <nhorman@tuxdriver.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, kerolasa@gmail.com, grawity@gmail.com,
        ingenit@zoho.com
Subject: Re: [PATCH v3] sys-tools: Enhance unshare command to support the
 switching of namespaces
Message-ID: <20130107145848.GB31577@hmsreliant.think-freely.org>
References: <1355944006-27234-1-git-send-email-nhorman@tuxdriver.com>
 <1356711738-1573-1-git-send-email-nhorman@tuxdriver.com>
 <20130107140523.GA8265@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130107140523.GA8265@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jan 07, 2013 at 03:05:23PM +0100, Karel Zak wrote:
> On Fri, Dec 28, 2012 at 11:22:18AM -0500, Neil Horman wrote:
> >  sys-utils/unshare.1 | 34 +++++++++++++++---------
> >  sys-utils/unshare.c | 74 ++++++++++++++++++++++++++++++++++++++++++-----------
> >  2 files changed, 81 insertions(+), 27 deletions(-)
> 
>  Applied with some changes, please check/verify the changes in git, thanks.
> 
> > +static void close_files(void)
> > +{
> > +	int i;
> > +	for (i=0; ns_pids[i] > 0; i++)
> > +		close(ns_pids[i]);
> > +	close_stdout();
> > +}
> 
>  this is unnecessary, but O_CLOEXEC is probably good idea
> 
> > +	while((c = getopt_long(argc, argv, "hVm:u:i:n:", longopts, NULL)) != -1) {
> > +		ns = NULL;
> 
>  optional argument means "::" not ":"
> 
> > +		if (optarg && ns) {
> > +				if (nscount >= NUM_ENTRIES)
> > +					err(EXIT_FAILURE, _("Too many new namespaces specified"));
> > +				pid = strtoul(optarg, NULL, 10);
> 
>  for the short options the 'optarg' starts with '=', so you need
>  optarg++
> 
> > +	for (nscount = 0; ns_pids[nscount] > 0; nscount++)
> > +		if (-1 == setns(ns_pids[nscount], 0))
> > +			err(EXIT_FAILURE, _("setns failed"));
> > +	
> >  	if(-1 == unshare(unshare_flags))
> >  		err(EXIT_FAILURE, _("unshare failed"));
> 
>  it seems that unshare() should not be called if unshare_flags == 0

Your changes look fine.  FWIW, theres no need to check that unshare_flags is 0
(not that it matters if you do).  The man page documents (and the implementation
inforces that unshare(0) is a no-op.

Thanks!
Neil
> 
>     Karel
> 
> -- 
>  Karel Zak  <kzak@redhat.com>
>  http://karelzak.blogspot.com
> 
