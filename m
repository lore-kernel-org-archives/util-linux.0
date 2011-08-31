Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:32242 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752489Ab1HaJrt (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 31 Aug 2011 05:47:49 -0400
Date: Wed, 31 Aug 2011 11:47:45 +0200
From: Karel Zak <kzak@redhat.com>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH/RFC 2/2] chcpu: new tool
Message-ID: <20110831094745.GF23423@nb.net.home>
References: <20110815152453.052584040@de.ibm.com> <20110815153925.969554416@de.ibm.com> <20110831094433.GE23423@nb.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110831094433.GE23423@nb.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Aug 31, 2011 at 11:44:33AM +0200, Karel Zak wrote:
> On Mon, Aug 15, 2011 at 05:24:55PM +0200, Heiko Carstens wrote:
> > +	if ((argc == 1) || (argc != optind))
> > +		usage(stderr);
> > +
> > +	switch (cmd) {
> > +	case CMD_CPU_ENABLE:
> > +		return cpu_enable(cpu_set, ncpus, 1);
> > +	case CMD_CPU_DISABLE:
> > +		return cpu_enable(cpu_set, ncpus, 0);
> > +	}
> 
>  What about to add CMD_CPU_SHOW and use it as a default if --enable/disable
>  is not specified? 

 Ah... I see your updated version now. Sorry. Ignore my note about
 CMD_CPU_SHOW :-) It will be better to use lscpu. 

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
