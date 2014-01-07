Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:29439 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756037AbaAGKWh (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 7 Jan 2014 05:22:37 -0500
Date: Tue, 7 Jan 2014 11:22:07 +0100
From: Karel Zak <kzak@redhat.com>
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: util-linux@vger.kernel.org, Mikhail Gusarov <dottedmag@dottedmag.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] unshare: Add possibility to add mapping into root user
 in user namespace
Message-ID: <20140107102207.GB2658@x2.net.home>
References: <1388178888-24475-1-git-send-email-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1388178888-24475-1-git-send-email-lkundrak@v3.sk>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Dec 27, 2013 at 10:14:48PM +0100, Lubomir Rintel wrote:
> $ unshare --uts
> unshare: unshare failed: Operation not permitted
> 
> $ unshare --user --uts
> [nfsnobody@odvarok ~]$ hostname swag
> hostname: you must be root to change the host name
> 
> $ unshare -r --uts
> [root@odvarok util-linux]# hostname swag
> [root@odvarok util-linux]#

 Applied with some minor changes, thanks. It's really nice simplification.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
