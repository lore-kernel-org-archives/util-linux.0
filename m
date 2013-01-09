Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:26234 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757436Ab3AINhD (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 9 Jan 2013 08:37:03 -0500
Date: Wed, 9 Jan 2013 14:36:53 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 4/4] losetup: fix declarations [smatch scan]
Message-ID: <20130109133653.GK18204@x2.net.home>
References: <1356729823-729-1-git-send-email-kerolasa@iki.fi>
 <1356729823-729-4-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1356729823-729-4-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Dec 28, 2012 at 09:23:43PM +0000, Sami Kerola wrote:
>  sys-utils/losetup.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

 [...]

> -	for (int i = 0; i < ncolumns; i++) {
> +	for (i = 0; i < ncolumns; i++) {

 Ah yes, we hate this... Applied, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
