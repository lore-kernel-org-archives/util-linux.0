Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:49777 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752387AbcDFLfy (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 6 Apr 2016 07:35:54 -0400
Date: Wed, 6 Apr 2016 13:35:52 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] libuuid: remove HAVE_UUIDD
Message-ID: <20160406113552.6nrd4xnqjjrwqbrc@ws.net.home>
References: <1459939867-20719-1-git-send-email-sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1459939867-20719-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Apr 06, 2016 at 12:51:06PM +0200, Ruediger Meier wrote:
> configure --disable-uuidd disabled both the build of uuidd and also
> disabled uuidd support of libuuid.

 Yes.

> Now we build libuuid always with uuidd support. 

 Not sure if I follow... we always build uuidd and uuidd support
 within libuuid except situation you specify --disable-uuidd.

> +++ b/libuuid/src/gen_uuid.c
> @@ -329,7 +329,7 @@ try_again:
>  	return ret;
>  }
>  
> -#if defined(HAVE_UUIDD) && defined(HAVE_SYS_UN_H)
> +#ifdef HAVE_SYS_UN_H

 So you want uuidd stuff in libuuid although --disable-uuidd has been
 specified? Why?

 The --disable-uuidd is (or should be) pretty common for desktop-only
 distros. 

 IMHO the current behaviour is correct.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
