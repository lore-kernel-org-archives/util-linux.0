Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:45620 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757259Ab2FENBX (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 5 Jun 2012 09:01:23 -0400
Date: Tue, 5 Jun 2012 15:01:14 +0200
From: Karel Zak <kzak@redhat.com>
To: maximilian attems <max@stro.at>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] lib/strutils: circumvent missing localeconv()
Message-ID: <20120605130114.GH14536@x2.net.home>
References: <1338486050-7490-1-git-send-email-max@stro.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1338486050-7490-1-git-send-email-max@stro.at>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, May 31, 2012 at 07:40:49PM +0200, maximilian attems wrote:
>  include/nls.h  |    6 ++++++
>  lib/strutils.c |    2 +-
>  2 files changed, 7 insertions(+), 1 deletion(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
