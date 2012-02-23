Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:51902 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755113Ab2BWJ5K (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 23 Feb 2012 04:57:10 -0500
Date: Thu, 23 Feb 2012 10:57:03 +0100
From: Karel Zak <kzak@redhat.com>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: util-linux@vger.kernel.org, Chandan B Rajenda <chandan@linux.vnet.ibm.com>
Subject: Re: [PATCH] lib/strutils.c: Move array bounds check in
 string_to_idarray() to appropriate place.
Message-ID: <20120223095703.GA23237@x2.net.home>
References: <1329988648-21830-1-git-send-email-heiko.carstens@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1329988648-21830-1-git-send-email-heiko.carstens@de.ibm.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Feb 23, 2012 at 10:17:28AM +0100, Heiko Carstens wrote:
>  lib/strutils.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
