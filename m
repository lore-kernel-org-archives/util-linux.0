Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:61581 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752314Ab3JKIz1 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 11 Oct 2013 04:55:27 -0400
Date: Fri, 11 Oct 2013 10:55:24 +0200
From: Karel Zak <kzak@redhat.com>
To: Namhyung Kim <namhyung@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 2/2] libmount: Fix mnt_context_is_child()
Message-ID: <20131011085524.GD14457@x2.net.home>
References: <1381331829-9791-1-git-send-email-namhyung@gmail.com>
 <1381331829-9791-2-git-send-email-namhyung@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381331829-9791-2-git-send-email-namhyung@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Oct 10, 2013 at 12:17:09AM +0900, Namhyung Kim wrote:
> It should check if fork (mount -F) is enabled.
> 
> Signed-off-by: Namhyung Kim <namhyung@gmail.com>
> ---
>  libmount/src/context.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/libmount/src/context.c b/libmount/src/context.c
> index 04eb286..a4d9824 100644
> --- a/libmount/src/context.c
> +++ b/libmount/src/context.c
> @@ -387,7 +387,7 @@ int mnt_context_is_parent(struct libmnt_context *cxt)
>   */
>  int mnt_context_is_child(struct libmnt_context *cxt)
>  {
> -	return !mnt_context_is_fork(cxt) && cxt->pid;
> +	return mnt_context_is_fork(cxt) && cxt->pid;
>  }

 No, the code is correct, the function docs is incorrect. The fork
 flag is disabled in all children (see mnt_fork_context()) to avoid
 recursive forking.

 I have fixed the function comment.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
