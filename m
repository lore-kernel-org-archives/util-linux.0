Return-Path: util-linux-owner@vger.kernel.org
Received: from wp221.webpack.hosteurope.de ([80.237.132.228]:59867 "EHLO
	wp221.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754086AbbBTMov (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Fri, 20 Feb 2015 07:44:51 -0500
Received: by jue.netz (masqmail 0.3.5, from userid 500)
	id 1YOmwe-4kC-00
	for <util-linux@vger.kernel.org>; Fri, 20 Feb 2015 13:44:36 +0100
Date: Fri, 20 Feb 2015 13:44:36 +0100
From: Juergen Daubert <jue@jue.li>
To: util-linux@vger.kernel.org
Subject: Re: [bug] logger 2.26: regression, option -i not combinable with
 other options
Message-ID: <20150220124436.GA18236@jue.netz>
References: <20150220100647.GA2624@jue.netz>
 <20150220104106.GB19430@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150220104106.GB19430@ws.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Feb 20, 2015 at 11:41:06AM +0100, Karel Zak wrote:
> On Fri, Feb 20, 2015 at 11:06:47AM +0100, Juergen Daubert wrote:
> > with logger from util-linux 2.25.x it's possible to combine the option
> > -i with other options like:
> > 
> >  logger -is
> > 
> > with 2.26 I get the following error message:
> > 
> >  $:~> logger -is
> >  logger: failed to parse id: 's'
> > 
> > The changed behaviour breaks existing scripts like dhcpcd-run-hooks [1]
> > from dhcpcd [2].
> 
> Hmm... stupid regression, next time it would be probably better to
> introduce optional arguments for long options only.
> 
> Anyway, always use long options in scripts. It's more robust and more
> readable.

here's the response from dhcpcd's author:

 The original BSD sources from which logger is clearly based don't support
 long options .... and dhcpcd needs to work with them. 


Greetings
Juergen
