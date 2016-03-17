Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:59610 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752731AbcCQL1Q (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 17 Mar 2016 07:27:16 -0400
Date: Thu, 17 Mar 2016 12:27:14 +0100
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] build-sys: no need to un-ignore tracked files
Message-ID: <20160317112714.mhscns6eexdde7b4@ws.net.home>
References: <1458209046-18526-1-git-send-email-sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1458209046-18526-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Mar 17, 2016 at 11:04:05AM +0100, Ruediger Meier wrote:
>  .gitignore | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/.gitignore b/.gitignore
> index a008740..841111e 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -55,16 +55,6 @@ tests/run.sh.log
>  tests/run.sh.trs
>  update.log
>  
> -# libuuid depends on AX_TLS macro
> -!m4/tls.m4
> -
> -# GTK_DOC_CHECK depends on gtk-doc.m4
> -!m4/gtk-doc.m4
> -
> -# util-linux specific macros
> -!m4/ul.m4
> -!m4/compiler.m4
> -

Strange, I'm almost sure this was necessary years ago.

Applied, thanks.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
