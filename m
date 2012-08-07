Return-Path: util-linux-owner@vger.kernel.org
Received: from e06smtp15.uk.ibm.com ([195.75.94.111]:51082 "EHLO
	e06smtp15.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751726Ab2HGHfq (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 7 Aug 2012 03:35:46 -0400
Received: from /spool/local
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <util-linux@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
	Tue, 7 Aug 2012 08:35:44 +0100
Received: from d06av06.portsmouth.uk.ibm.com (d06av06.portsmouth.uk.ibm.com [9.149.37.217])
	by d06nrmr1707.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q777ZAdu2183260
	for <util-linux@vger.kernel.org>; Tue, 7 Aug 2012 08:35:10 +0100
Received: from d06av06.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av06.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q777Z9xu021270
	for <util-linux@vger.kernel.org>; Tue, 7 Aug 2012 01:35:09 -0600
Date: Tue, 7 Aug 2012 09:35:09 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: faizan husain <faizanh@linux.vnet.ibm.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] lscpu : -b and -c option does not give expected output.
Message-ID: <20120807073509.GA31284@osiris.de.ibm.com>
References: <1344229852-4737-1-git-send-email-faizanh@linux.vnet.ibm.com>
 <20120806114906.GA3432@osiris.de.ibm.com>
 <5020A7F8.9070402@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5020A7F8.9070402@linux.vnet.ibm.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Aug 07, 2012 at 11:00:32AM +0530, faizan husain wrote:
> On Monday 06 August 2012 05:20 PM, Heiko Carstens wrote:
> >On Sun, Aug 05, 2012 at 10:10:52PM -0700, Faizan husain wrote:
> >>From: faizan husain <faizanh@linux.vnet.ibm.com>
> >>
> >>Options for lscpu command are giving incorrect output.
> >>As per the man page or help, '-b' option should limit the output to online CPUs
> >>and '-c' option should limit the output to offline CPUs.
> >>But we could see the output is same for '-a','-b' and '-c' options.
> >>
> >>Signed-off-by: faizan husain <faizanh@linux.vnet.ibm.com>
> >The -a, -b and -c options were meant to influence the output for the
> >extended (-e) and parsable (-p) output options.
> >I'm not sure it makes sense to change the default output with these
> >options. I'd prefer an update of the man page.
> >
> >Hm?
> This fix is not going to influence the default output with these
> options (-e and -p),

Yes, I'm aware of that.

> and it does not make any sense if -a, -b and -c option print same output.

Just to make sure we talk about the same things:

extended output: -e option
parsable output: -p option
default output : no -e or -p option specified

What I tried to say above was that the -a, -b and -c modifiers were
only added to influence the output for the extended and parsable
options.
If you have a system with a lot of cpus the output can be significantly
different for the extended and parsable options if you specify any of the
modifiers.

The default output (no -e or -p) however is intended to give an overview
of the complete system.

So from a usability point of view: why would a user want to exclude the
line which contains the online list of cpus for the default output?

>From my point of view the correct "fix" would be to change the lscpu man
page in order to document that the -a, -b and -c modifiers only influence
the output for the extended and parsable options.

