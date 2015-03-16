Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:50136 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932431AbbCPOOT (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 16 Mar 2015 10:14:19 -0400
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx101)
 with ESMTPSA (Nemesis) id 0Mchyv-1YpJeK1OWf-00Hsbr for
 <util-linux@vger.kernel.org>; Mon, 16 Mar 2015 15:14:17 +0100
To: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] tailf: deprecated
From: Ruediger Meier <sweet_f_a@gmx.de>
Date: Mon, 16 Mar 2015 15:14:16 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201503161514.16813.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Monday 16 March 2015 at 14:32, you wrote:
> On Fri, Mar 13, 2015 at 04:09:36PM +0100, Ruediger Meier wrote:
> >  Documentation/deprecated.txt |  5 +++++
> >  tests/expected/tailf/simple  |  1 +
> >  text-utils/tailf.1           |  6 ++++++
> >  text-utils/tailf.c           | 16 ++++++++++++----
> >  4 files changed, 24 insertions(+), 4 deletions(-)
>
> Boys you're so bad.. I use tailf! Well, both patches applied :-)
>
> >  #include <stdio.h>
> >  #include <stdlib.h>
> >  #include <unistd.h>
> > @@ -246,6 +251,9 @@ int main(int argc, char **argv)
> >  	textdomain(PACKAGE);
> >  	atexit(close_stdout);
> >
> > +	warnx(_("warning: "
> > +		"use of 'tailf' is deprecated, use 'tail -f' instead"));
>
> moved to usage() to avoid regression in output.

Ok, then we can also remove it from test output again.

cu,
Rudi
