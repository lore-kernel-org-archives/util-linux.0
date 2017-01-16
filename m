Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:49494 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750817AbdAPLbm (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 16 Jan 2017 06:31:42 -0500
Date: Mon, 16 Jan 2017 12:31:40 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] newgrp: use libc explicit_bzero() when it is available
Message-ID: <20170116113140.gc2mwcqv5vjywdtn@ws.net.home>
References: <20170105223340.2721-1-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170105223340.2721-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jan 05, 2017 at 10:33:40PM +0000, Sami Kerola wrote:
>  configure.ac         | 1 +
>  login-utils/newgrp.c | 6 ++++++
>  2 files changed, 7 insertions(+)

Applied, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
