Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:51318 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751263AbdFVIib (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 22 Jun 2017 04:38:31 -0400
Date: Thu, 22 Jun 2017 10:38:24 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 06/13] setarch: print usage error if no argument given
Message-ID: <20170622083824.hqgqykwccfb7jmbb@ws.net.home>
References: <1498099066-24235-1-git-send-email-sweet_f_a@gmx.de>
 <1498099066-24235-7-git-send-email-sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1498099066-24235-7-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jun 22, 2017 at 04:37:39AM +0200, Ruediger Meier wrote:
> From: Ruediger Meier <ruediger.meier@ga-group.nl>
> 
> This looks more likely as intended.
> 
> Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
> ---
>  sys-utils/setarch.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sys-utils/setarch.c b/sys-utils/setarch.c
> index eb9cf21..6481eb2 100644
> --- a/sys-utils/setarch.c
> +++ b/sys-utils/setarch.c
> @@ -301,7 +301,7 @@ int main(int argc, char *argv[])
>  	textdomain(PACKAGE);
>  	atexit(close_stdout);
>  
> -	if (argc < 1)
> +	if (argc < 2)
>  		show_usage(_("Not enough arguments"));

I don't think so. 

We use setarch by symlinks (i386, uname26 linux32 linux64, ...) and in
this case it's executed without argument. The symlink name is good
enough.

The right solutions is to remove this entire if() block. 

Later in the code we have "no architecture argument specified".


    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
