Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:1992 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751241AbaFJLwO (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 10 Jun 2014 07:52:14 -0400
Date: Tue, 10 Jun 2014 13:52:08 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] build-sys: use gettext 0.18.3 if possible
Message-ID: <20140610115208.GG30975@x2.net.home>
References: <1402394931-20416-1-git-send-email-sweet_f_a@gmx.de>
 <1402394931-20416-2-git-send-email-sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1402394931-20416-2-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jun 10, 2014 at 12:08:51PM +0200, Ruediger Meier wrote:
> We add a little hack for backward compatibility on systems with
> older gettext installed
> 
> See 0576dbd3 and 81ed13ed.
> 
> Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
> ---
>  autogen.sh   | 31 ++++++++++++++++++++++++++++++-
>  configure.ac |  3 ++-
>  2 files changed, 32 insertions(+), 2 deletions(-)

 Ah, I see, it seems like another pin for our gettext voodoo doll.

 Applied.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
