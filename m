Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:60342 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751290AbdFELgj (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 5 Jun 2017 07:36:39 -0400
Date: Mon, 5 Jun 2017 13:36:34 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 3/3] chsh: make readline completion to propose valid
 shells
Message-ID: <20170605113634.jai2iuwhqozelkey@ws.net.home>
References: <20170518211936.28153-1-kerolasa@iki.fi>
 <20170518211936.28153-4-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170518211936.28153-4-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, May 18, 2017 at 10:19:36PM +0100, Sami Kerola wrote:
> This is better than default readline completion, that gives paths from
> current directory onwards.
> 
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  login-utils/chsh.c | 117 ++++++++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 90 insertions(+), 27 deletions(-)

Applied, thanks. I did some another changes to  the code.

    Karel
-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
