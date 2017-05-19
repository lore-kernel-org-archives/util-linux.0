Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:35304 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755471AbdESI02 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 19 May 2017 04:26:28 -0400
Date: Fri, 19 May 2017 10:26:18 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 3/3] chsh: make readline completion to propose valid
 shells
Message-ID: <20170519082618.7karkcbuugicnmvx@ws.net.home>
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

Not sure with this patch, seems too invasive for rc2. Let's wait for v2.31

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
