Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:52607 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754551AbbFBMFT (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 2 Jun 2015 08:05:19 -0400
Date: Tue, 2 Jun 2015 14:05:17 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 00/12] pull: script(1) changes
Message-ID: <20150602120517.GK7285@ws.net.home>
References: <1424616169-693-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1424616169-693-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Feb 22, 2015 at 02:42:37PM +0000, Sami Kerola wrote:
> Hello,
> 
> The following changes are clean ups and improvements to script(1)
> command.  These changes are also available from my github remote
> repository.
> 
>  git://github.com/kerolasa/lelux-utiliteetit.git script

 script2

  - the branch contains also rtcwake changes!
  - the "script: replay" test hangs :-(
  - no tested with HAVE_LIBUTEMPTER, you need:

          -       utempter_add_record(master, NULL);
          +       utempter_add_record(ctl.master, NULL);

 
    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
