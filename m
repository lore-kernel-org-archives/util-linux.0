Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:40613 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753591AbbBXK37 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 24 Feb 2015 05:29:59 -0500
Date: Tue, 24 Feb 2015 11:29:48 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 05/16] tunelp: remove get_val() in favour of
 strtol_or_err()
Message-ID: <20150224102948.GH19430@ws.net.home>
References: <1424616106-580-1-git-send-email-kerolasa@iki.fi>
 <1424616106-580-6-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1424616106-580-6-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Feb 22, 2015 at 02:41:35PM +0000, Sami Kerola wrote:
>  sys-utils/Makemodule.am |  1 +
>  sys-utils/tunelp.c      | 22 ++++++++--------------
>  2 files changed, 9 insertions(+), 14 deletions(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
