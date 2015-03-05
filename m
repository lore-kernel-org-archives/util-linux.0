Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:60066 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932365AbbCEKVC (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 5 Mar 2015 05:21:02 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t25AL1oK031852
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <util-linux@vger.kernel.org>; Thu, 5 Mar 2015 05:21:01 -0500
Received: from ws ([10.40.204.58])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t25AL0iE008096
	for <util-linux@vger.kernel.org>; Thu, 5 Mar 2015 05:21:01 -0500
Date: Thu, 5 Mar 2015 11:21:00 +0100
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Subject: Re: [bug] logger 2.26: regression, option -i not combinable with
 other options
Message-ID: <20150305102100.GW8046@ws.net.home>
References: <20150220100647.GA2624@jue.netz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150220100647.GA2624@jue.netz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Feb 20, 2015 at 11:06:47AM +0100, Juergen Daubert wrote:
> Hello,
> 
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

 Fixed in git tree, the bugfix will be in v2.26.1 (probably last week
 this month or early).

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
