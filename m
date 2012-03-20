Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:36148 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758098Ab2CTI3W (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 20 Mar 2012 04:29:22 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q2K8TLxs031781
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Tue, 20 Mar 2012 04:29:21 -0400
Date: Tue, 20 Mar 2012 09:29:19 +0100
From: Karel Zak <kzak@redhat.com>
To: harald@redhat.com
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH v2] setsid: add option "-c" to set the controlling
 terminal
Message-ID: <20120320082919.GC3956@x2.net.home>
References: <1331716038-8808-1-git-send-email-harald@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1331716038-8808-1-git-send-email-harald@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Mar 14, 2012 at 10:07:18AM +0100, harald@redhat.com wrote:
>  sys-utils/setsid.1 |    4 ++++
>  sys-utils/setsid.c |   18 ++++++++++++++++--
>  2 files changed, 20 insertions(+), 2 deletions(-)

 Applied, thanks.


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
