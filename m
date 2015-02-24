Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:41513 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752504AbbBXKfD (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 24 Feb 2015 05:35:03 -0500
Date: Tue, 24 Feb 2015 11:34:51 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 07/16] lib/strutils: move parse_switch() from setterm(1)
 to library
Message-ID: <20150224103451.GI19430@ws.net.home>
References: <1424616106-580-1-git-send-email-kerolasa@iki.fi>
 <1424616106-580-8-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1424616106-580-8-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Feb 22, 2015 at 02:41:37PM +0000, Sami Kerola wrote:
>  include/strutils.h   |  2 ++
>  lib/strutils.c       |  8 ++++++++
>  term-utils/setterm.c | 14 --------------
>  3 files changed, 10 insertions(+), 14 deletions(-)

 Applied (and removed the extra comment as suggested by Benno), thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
