Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:57840 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750769AbdIRJH7 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 18 Sep 2017 05:07:59 -0400
Date: Mon, 18 Sep 2017 11:07:55 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 2/3] tools: update git-version-gen from gnulib
Message-ID: <20170918090755.mxogoxmodbq2hlzp@ws.net.home>
References: <20170917184902.1218-1-kerolasa@iki.fi>
 <20170917184902.1218-2-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170917184902.1218-2-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Sep 17, 2017 at 07:49:01PM +0100, Sami Kerola wrote:
> from-gnulib-commit: e277cd7c6cf6435d9d4d380fd6cef0510e3f5afe
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  tools/git-version-gen | 137 +++++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 102 insertions(+), 35 deletions(-)

I'm not sure about this. Did you check all the changes?

We have some local changes to the file, see 

    git whatchanged tools/git-version-gen
    
It would be nice to be sure that all works as expected.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
