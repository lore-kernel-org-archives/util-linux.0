Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:24038 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752492Ab2HMNz3 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 13 Aug 2012 09:55:29 -0400
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q7DDtSwr019110
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Mon, 13 Aug 2012 09:55:28 -0400
Date: Mon, 13 Aug 2012 15:55:27 +0200
From: Karel Zak <kzak@redhat.com>
To: Milan Broz <mbroz@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] dmesg: fix kmsg read if read returns EPIPE
Message-ID: <20120813135527.GE21956@x2.net.home>
References: <1344858930-21075-1-git-send-email-mbroz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1344858930-21075-1-git-send-email-mbroz@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Aug 13, 2012 at 01:55:30PM +0200, Milan Broz wrote:
>  sys-utils/dmesg.c |   18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)

 Applied, thanks!

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
