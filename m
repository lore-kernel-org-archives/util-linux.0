Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:5415 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752746Ab2GPQY3 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 16 Jul 2012 12:24:29 -0400
Date: Mon, 16 Jul 2012 18:24:26 +0200
From: Karel Zak <kzak@redhat.com>
To: Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 2/2] libblkid: cast blkid_loff_t to unsigned long long
Message-ID: <20120716162426.GF9087@x2.net.home>
References: <1342080599-12346-1-git-send-email-petr.uzel@suse.cz>
 <1342080599-12346-2-git-send-email-petr.uzel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1342080599-12346-2-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jul 12, 2012 at 10:09:59AM +0200, Petr Uzel wrote:
>  libblkid/src/probe.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
