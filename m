Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:14340 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751825AbaEUIKl (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 21 May 2014 04:10:41 -0400
Date: Wed, 21 May 2014 10:10:34 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 5/5] lscpu: avoid compiler warnings
Message-ID: <20140521081034.GB2898@x2.net.home>
References: <1400600551-7227-1-git-send-email-sweet_f_a@gmx.de>
 <1400600551-7227-6-git-send-email-sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1400600551-7227-6-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, May 20, 2014 at 03:42:31PM +0000, Ruediger Meier wrote:
> From: Ruediger Meier <ruediger.meier@ga-group.nl>
> 
> Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
> ---
>  sys-utils/lscpu.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
> index ee3ad19..58f6609 100644
> --- a/sys-utils/lscpu.c
> +++ b/sys-utils/lscpu.c
> @@ -598,6 +598,9 @@ static jmp_buf segv_handler_env;
>  static void
>  segv_handler(int sig, siginfo_t *info, void *ignored)
>  {
> +	(void)sig;
> +	(void)info;
> +	(void)ignored;

 please, use
 
    segv_handler(__attribute__((__unused__)) sig,
                 __attribute__((__unused__)) info,
                 __attribute__((__unused__)) ignored)

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
