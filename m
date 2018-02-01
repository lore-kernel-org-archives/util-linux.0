Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:53482 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751761AbeBALXO (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 1 Feb 2018 06:23:14 -0500
Date: Thu, 1 Feb 2018 12:23:09 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] various: fix redeclared with different type warnings
 [smatch]
Message-ID: <20180201112309.wwjvpkmaqjd3el7w@ws.net.home>
References: <20180124210730.17034-1-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180124210730.17034-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jan 24, 2018 at 09:07:30PM +0000, Sami Kerola wrote:
> These warnings look like this:
> lib/exec_shell.c:33:6: error: symbol 'exec_shell' redeclared with different
> type (originally declared at ./include/exec_shell.h:1) - different modifiers
> 
> In same go move attributes in front of these functions, this is how they
> should be. 

 [citation needed]

We have only "noreturn" in front of declarations, everything else is
behind. For header files it would be probably better to use all
attributes behind. I don't see reason for a change.

I'll cleanup exec_shell.h.

> Related smatch message is: error: attributes should be specified
> before the declarator in a function definition.

Fix smatch.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
