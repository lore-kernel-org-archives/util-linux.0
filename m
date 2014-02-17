Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:31332 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751855AbaBQKpQ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 17 Feb 2014 05:45:16 -0500
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s1HAjEnE008328
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Mon, 17 Feb 2014 05:45:15 -0500
Date: Mon, 17 Feb 2014 11:45:12 +0100
From: Karel Zak <kzak@redhat.com>
To: Masatake YAMATO <yamato@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] ionice: add the way to specify the target processes with
 pgid and uid
Message-ID: <20140217104512.GB2254@x2.net.home>
References: <1391093558-20108-1-git-send-email-yamato@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1391093558-20108-1-git-send-email-yamato@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jan 30, 2014 at 11:52:38PM +0900, Masatake YAMATO wrote:
>  schedutils/ionice.1 | 26 ++++++++++++++++++++
>  schedutils/ionice.c | 68 ++++++++++++++++++++++++++++++++++++-----------------
>  2 files changed, 73 insertions(+), 21 deletions(-)

 Applied, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
