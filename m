Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pd0-f180.google.com ([209.85.192.180]:43702 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752338Ab3JLDuj (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 11 Oct 2013 23:50:39 -0400
Received: by mail-pd0-f180.google.com with SMTP id y10so5062637pdj.25
        for <util-linux@vger.kernel.org>; Fri, 11 Oct 2013 20:50:38 -0700 (PDT)
Subject: Re: [PATCH 2/2] libmount: Fix mnt_context_is_child()
From: Namhyung Kim <namhyung@gmail.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
In-Reply-To: <20131011085524.GD14457@x2.net.home>
References: <1381331829-9791-1-git-send-email-namhyung@gmail.com>
	 <1381331829-9791-2-git-send-email-namhyung@gmail.com>
	 <20131011085524.GD14457@x2.net.home>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 12 Oct 2013 12:50:30 +0900
Message-ID: <1381549830.1797.1.camel@leonhard>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi Karel,

2013-10-11 (금), 10:55 +0200, Karel Zak:
> On Thu, Oct 10, 2013 at 12:17:09AM +0900, Namhyung Kim wrote:
> > It should check if fork (mount -F) is enabled.
> > 
> > Signed-off-by: Namhyung Kim <namhyung@gmail.com>
> > ---
> >  libmount/src/context.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/libmount/src/context.c b/libmount/src/context.c
> > index 04eb286..a4d9824 100644
> > --- a/libmount/src/context.c
> > +++ b/libmount/src/context.c
> > @@ -387,7 +387,7 @@ int mnt_context_is_parent(struct libmnt_context *cxt)
> >   */
> >  int mnt_context_is_child(struct libmnt_context *cxt)
> >  {
> > -	return !mnt_context_is_fork(cxt) && cxt->pid;
> > +	return mnt_context_is_fork(cxt) && cxt->pid;
> >  }
> 
>  No, the code is correct, the function docs is incorrect. The fork
>  flag is disabled in all children (see mnt_fork_context()) to avoid
>  recursive forking.
> 
>  I have fixed the function comment.

Okay, thanks for the explanation.


-- 
Regards,
Namhyung Kim


