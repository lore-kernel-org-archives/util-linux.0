Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:47244 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751181Ab2A3MYG (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 30 Jan 2012 07:24:06 -0500
Date: Mon, 30 Jan 2012 13:24:01 +0100
From: Karel Zak <kzak@redhat.com>
To: "Voelker, Bernhard" <bernhard.voelker@siemens-enterprise.com>
Cc: "dave@gnu.org" <dave@gnu.org>, util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] whereis: move token assignment into loop syntax
Message-ID: <20120130122401.GB22107@x2.net.home>
References: <1327847124.3305.1.camel@offbook>
 <7856072A9D04C24B82DFE2B1112FE38A0D8BBA2C2D@MCHP058A.global-ad.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7856072A9D04C24B82DFE2B1112FE38A0D8BBA2C2D@MCHP058A.global-ad.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jan 30, 2012 at 10:08:41AM +0100, Voelker, Bernhard wrote:
> Davidlohr Bueso wrote:
> 
> > ... use for() naturally instead.
> 
> > -	for (tmp = pathcp; ; tmp = NULL) {
> > -		tok = strtok_r(tmp, ":", &key);
> > -		if (!tok)
> > -			break;
> > -
> > +	for (tmp = pathcp; tok = strtok_r(tmp, ":", &key); tmp = NULL) {
> >  		/* make sure we don't repeat the search path */
> >  		if (inpath(tok))
> >  			continue;
> 
> hmm, a repetitive assignment like "tmp = NULL" as the increment
> expression of the for-loop doesn't read too natural for me either.
> ;-)

 Yes,

    for (tok = strtok_r(pathcp, ":", &key); tok;
         tok = strtok_r(NULL, ":", &key)) {

 is more readable solution, 'tmp' is unnecessary. Fixed.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
