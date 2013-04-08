Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:36190 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761473Ab3DHQ1A (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 8 Apr 2013 12:27:00 -0400
Date: Mon, 8 Apr 2013 18:26:50 +0200
From: Karel Zak <kzak@redhat.com>
To: Ville =?iso-8859-1?Q?Skytt=E4?= <ville.skytta@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] bash-completion: Symlink runuser symlink to su so it
 gets loaded on demand.
Message-ID: <20130408162650.GQ14350@x2.net.home>
References: <1365324972-4139-1-git-send-email-ville.skytta@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1365324972-4139-1-git-send-email-ville.skytta@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Apr 07, 2013 at 11:56:12AM +0300, Ville Skyttä wrote:
>  bash-completion/Makemodule.am | 3 +++
>  1 file changed, 3 insertions(+)

 Applied, thanks.

> 
> diff --git a/bash-completion/Makemodule.am b/bash-completion/Makemodule.am
> index 34bdc6c..4c41218 100644
> --- a/bash-completion/Makemodule.am
> +++ b/bash-completion/Makemodule.am
> @@ -98,6 +98,9 @@ endif
>  if BUILD_SU
>  dist_bashcompletion_DATA += \
>  	bash-completion/su
> +install-data-hook-bashcomp-su::
> +	ln -sf su $(DESTDIR)$(bashcompletiondir)/runuser
> +INSTALL_DATA_HOOKS += install-data-hook-bashcomp-su

 I have renamed the hook (*-runuser rather than *-su) and added 
 'if BUILD_RUNUSER'.

     Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
