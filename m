Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:23744 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751200AbaDRKxC (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 18 Apr 2014 06:53:02 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s3IAr2qY016544
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Fri, 18 Apr 2014 06:53:02 -0400
Date: Fri, 18 Apr 2014 12:53:01 +0200
From: Karel Zak <kzak@redhat.com>
To: Lukas Czerner <lczerner@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] fallocate: add FALLOC_FL_ZERO_RANGE support
Message-ID: <20140418105301.GK5786@x2.net.home>
References: <1396438265-21535-1-git-send-email-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1396438265-21535-1-git-send-email-lczerner@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Apr 02, 2014 at 01:31:05PM +0200, Lukas Czerner wrote:
>  sys-utils/fallocate.1 | 14 ++++++++++++++
>  sys-utils/fallocate.c | 25 +++++++++++++++++++------
>  2 files changed, 33 insertions(+), 6 deletions(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
