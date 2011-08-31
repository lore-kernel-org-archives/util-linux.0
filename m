Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:63410 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752604Ab1HaJoh (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 31 Aug 2011 05:44:37 -0400
Date: Wed, 31 Aug 2011 11:44:33 +0200
From: Karel Zak <kzak@redhat.com>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH/RFC 2/2] chcpu: new tool
Message-ID: <20110831094433.GE23423@nb.net.home>
References: <20110815152453.052584040@de.ibm.com> <20110815153925.969554416@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110815153925.969554416@de.ibm.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Aug 15, 2011 at 05:24:55PM +0200, Heiko Carstens wrote:
> +	if ((argc == 1) || (argc != optind))
> +		usage(stderr);
> +
> +	switch (cmd) {
> +	case CMD_CPU_ENABLE:
> +		return cpu_enable(cpu_set, ncpus, 1);
> +	case CMD_CPU_DISABLE:
> +		return cpu_enable(cpu_set, ncpus, 0);
> +	}

 What about to add CMD_CPU_SHOW and use it as a default if --enable/disable
 is not specified? 
 
 I know that you can use lscpu, but it's not intuitive... see for example 
 ionice, nice or so. You can see the current status and then change it.

 It's trivial change to the cpu_enable() function.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
