Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:36795 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754890AbaGNNhT (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 14 Jul 2014 09:37:19 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s6EDbIOQ026189
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Mon, 14 Jul 2014 09:37:19 -0400
Date: Mon, 14 Jul 2014 15:37:16 +0200
From: Karel Zak <kzak@redhat.com>
To: Stef Walter <stefw@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] agetty: Reprompt and reprint /etc/issue if we receive
 SIGUSR1
Message-ID: <20140714133716.GB30288@x2.net.home>
References: <1404718284-4192-1-git-send-email-stefw@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1404718284-4192-1-git-send-email-stefw@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jul 07, 2014 at 09:31:24AM +0200, Stef Walter wrote:
> Several of the /etc/issue escape codes such as \4 and \S depend on
> variable data which can change after the agetty prompt is displayed.
> This can cause stale data to be displayed when a user looks at a VT,
> especially in cases of DHCP racing with system start up.
> 
> This commit allows agetty to react a SIGUSR1 signal by reprinting
> its prompt including the reprocessing of /etc/issue.
> 
> We never want this to occur once the user has started typing a
> user name. So we detect when the user starts typing, after which
> no further reprompting occurs even if SIGUSR1 is received.

 Good idea, interesting implementation, but it's too late for v2.25.
 I'm going to apply the patch to the git tree after v2.25 release.

 Thanks.
    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
