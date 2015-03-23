Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:46005 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752091AbbCWJUJ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 23 Mar 2015 05:20:09 -0400
Date: Mon, 23 Mar 2015 10:20:06 +0100
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: unshare(1) --propagation
Message-ID: <20150323091618.GB1749@ws.net.home>
References: <20150318172603.GE28925@ws.net.home>
 <20150322062437.GK4504@vapier>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150322062437.GK4504@vapier>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Mar 22, 2015 at 02:24:37AM -0400, Mike Frysinger wrote:
> On 18 Mar 2015 18:26, Karel Zak wrote:
> > Comments, objections?
> 
> i was looking for exactly this sort of feature recently :) -- namely to unshare 
> & mark everything private w/out having to write my own dummy wrapper.
> 
> i just worry about the next request where people want to mark everything private 
> except that one special mount ...

:-)

> > +static unsigned long parse_propagation(const char *str)
> > +{
> > +	size_t i;
> > +	struct prop_opts {
> > +		const char *name;
> > +		unsigned long flag;
> > +	} opts[] = {
> > +		{ "slave",	MS_REC | MS_SLAVE },
> > +		{ "private",	MS_REC | MS_PRIVATE },
> > +		{ "shared",     MS_REC | MS_SHARED },
> > +		{ "off",        0 }
> > +	};
> 
> static/const ?

 Fixed.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
