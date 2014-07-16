Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:47746 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751361AbaGPKCR (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 16 Jul 2014 06:02:17 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s6GA2Gwo007894
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Wed, 16 Jul 2014 06:02:17 -0400
Date: Wed, 16 Jul 2014 12:02:15 +0200
From: Karel Zak <kzak@redhat.com>
To: Stef Walter <stefw@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] agetty: Reprompt and reprint /etc/issue if we receive
 SIGUSR1
Message-ID: <20140716100215.GC4874@x2.net.home>
References: <1404718284-4192-1-git-send-email-stefw@redhat.com>
 <20140715074717.GN30288@x2.net.home>
 <53C4DED8.2070706@redhat.com>
 <20140715091907.GQ30288@x2.net.home>
 <53C52149.6010301@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <53C52149.6010301@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jul 15, 2014 at 02:40:41PM +0200, Stef Walter wrote:
> On 15.07.2014 11:19, Karel Zak wrote:
> >  Note that we does not control code of all login(1) implementations
> >  and we have --login-program <path> to start arbitrary random thing
> >  from agetty, so our solution have to be generic rather than rely 
> >  on any login(1) change.
> 
> Well you don't need to modify login(1) (or other --login-program's) at
> all. SIG_IGN is kept across an exec.

 Sure, but it's little bit fragile way.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
