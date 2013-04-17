Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:13310 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966186Ab3DQNbq (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 17 Apr 2013 09:31:46 -0400
Date: Wed, 17 Apr 2013 15:31:36 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 00/33] pull: bash completions, help screens, and file
 writing
Message-ID: <20130417133136.GA16676@x2.net.home>
References: <1365882901-11429-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1365882901-11429-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Apr 13, 2013 at 08:54:28PM +0100, Sami Kerola wrote:
> I feel a bit like traitor.  Earlier the week I mentioned in irc I would

 No problem, mailing list is the best archive for patches :-)

> not send (much) changes before next release.  Then things changed.
> 
> There is the {u,}mount bash completion, which I promised to cover if

 See the original version from bash-completion package. It also
 supports filesystem specific mount options. (But I have doubts that
 maintain another place where we have the option is a good idea...)

 I'm going to apply the patches after 2.23 release.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
