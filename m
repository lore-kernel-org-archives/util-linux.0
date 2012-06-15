Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:58023 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756275Ab2FOJxp (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 15 Jun 2012 05:53:45 -0400
Date: Fri, 15 Jun 2012 11:53:40 +0200
From: Karel Zak <kzak@redhat.com>
To: Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 1/3] libmount: plug a memory leak in exec_helper()
Message-ID: <20120615095340.GF16531@x2.net.home>
References: <1339683183-21804-1-git-send-email-petr.uzel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1339683183-21804-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jun 14, 2012 at 04:13:01PM +0200, Petr Uzel wrote:
>  libmount/src/context_mount.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
