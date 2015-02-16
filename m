Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:60186 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755646AbbBPKMB (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 16 Feb 2015 05:12:01 -0500
Date: Mon, 16 Feb 2015 11:11:46 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org, Gabriele Balducci <balducci@units.it>
Subject: Re: [PATCH] logger: add --socket-errors compatibility option
Message-ID: <20150216101146.GE11948@ws.net.home>
References: <1423993823-13551-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1423993823-13551-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Feb 15, 2015 at 09:50:23AM +0000, Sami Kerola wrote:
> Reference: 1d57503378bdcd838365d625f6d2d0a09da9c29d
> Reported-by: Gabriele Balducci <balducci@units.it>
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  misc-utils/logger.1 | 17 ++++++++++++
>  misc-utils/logger.c | 75 ++++++++++++++++++++++++++++++++++++++++++++---------
>  2 files changed, 80 insertions(+), 12 deletions(-)

 Applied, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
