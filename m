Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:39803 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750922AbbHaJ1N (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 31 Aug 2015 05:27:13 -0400
Date: Mon, 31 Aug 2015 11:27:12 +0200
From: Karel Zak <kzak@redhat.com>
To: Chen Qi <Qi.Chen@windriver.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] sys-utils/Makemodule.am: fix parallel build issue
Message-ID: <20150831092712.GC2726@ws.net.home>
References: <1441009426-13799-1-git-send-email-Qi.Chen@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1441009426-13799-1-git-send-email-Qi.Chen@windriver.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Aug 31, 2015 at 04:23:44PM +0800, Chen Qi wrote:
> --- a/sys-utils/Makemodule.am
> +++ b/sys-utils/Makemodule.am
> @@ -124,6 +124,7 @@ man_MANS += $(SETARCH_MAN_LINKS)
>  CLEANFILES += $(SETARCH_MAN_LINKS)
>  
>  $(SETARCH_MAN_LINKS):
> +	$(MKDIR_P) sys-utils
>  	$(AM_V_GEN)echo ".so man8/setarch.8" > $@

Already fixed:

   git blame -L165,+1 sys-utils/Makemodule.am 
   1eb19118 (Mike Frysinger 2015-05-03 23:51:04 -0400 165)      $(AM_V_at) test -d $(dir $@) || mkdir -p $(dir $@)


 Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
