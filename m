Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:9789 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752306AbaDDMzn (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 4 Apr 2014 08:55:43 -0400
Date: Fri, 4 Apr 2014 14:55:37 +0200
From: Karel Zak <kzak@redhat.com>
To: Dave Reisner <dreisner@archlinux.org>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] switch_root: verify initramfs by f_type, not devno
Message-ID: <20140404125537.GA21046@x2.net.home>
References: <1396449690-4215-1-git-send-email-dreisner@archlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1396449690-4215-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Apr 02, 2014 at 10:41:30AM -0400, Dave Reisner wrote:
>  sys-utils/switch_root.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
