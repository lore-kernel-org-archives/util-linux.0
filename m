Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:40211 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753731AbbBTKlJ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 20 Feb 2015 05:41:09 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t1KAf8lr030410
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <util-linux@vger.kernel.org>; Fri, 20 Feb 2015 05:41:08 -0500
Received: from ws (ovpn-113-26.phx2.redhat.com [10.3.113.26])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t1KAf7fX013254
	for <util-linux@vger.kernel.org>; Fri, 20 Feb 2015 05:41:08 -0500
Date: Fri, 20 Feb 2015 11:41:06 +0100
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Subject: Re: [bug] logger 2.26: regression, option -i not combinable with
 other options
Message-ID: <20150220104106.GB19430@ws.net.home>
References: <20150220100647.GA2624@jue.netz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150220100647.GA2624@jue.netz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Feb 20, 2015 at 11:06:47AM +0100, Juergen Daubert wrote:
> with logger from util-linux 2.25.x it's possible to combine the option
> -i with other options like:
> 
>  logger -is
> 
> with 2.26 I get the following error message:
> 
>  $:~> logger -is
>  logger: failed to parse id: 's'
> 
> The changed behaviour breaks existing scripts like dhcpcd-run-hooks [1]
> from dhcpcd [2].

Hmm... stupid regression, next time it would be probably better to
introduce optional arguments for long options only.

Anyway, always use long options in scripts. It's more robust and more
readable.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
