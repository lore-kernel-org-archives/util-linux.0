Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:25014 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754513Ab2HBRZ1 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 2 Aug 2012 13:25:27 -0400
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q72HPQYA006620
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Thu, 2 Aug 2012 13:25:27 -0400
Date: Thu, 2 Aug 2012 19:25:19 +0200
From: Karel Zak <kzak@redhat.com>
To: harald@redhat.com
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] wdctl: add "--settimeout" to set the timeout
Message-ID: <20120802172519.GB8807@x2.net.home>
References: <1343821146-28238-1-git-send-email-harald@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1343821146-28238-1-git-send-email-harald@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Aug 01, 2012 at 01:39:06PM +0200, harald@redhat.com wrote:
>  sys-utils/wdctl.8 |  2 ++
>  sys-utils/wdctl.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 70 insertions(+), 1 deletion(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
