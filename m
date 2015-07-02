Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.15]:51854 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753272AbbGBKVH (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 2 Jul 2015 06:21:07 -0400
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx001)
 with ESMTPSA (Nemesis) id 0MRGTX-1ZcUyU1wtz-00Ua1Y for
 <util-linux@vger.kernel.org>; Thu, 02 Jul 2015 12:21:05 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: Re: [PATCH] script: evaluate errno only if read() sets it
Date: Thu, 2 Jul 2015 12:21:02 +0200
References: <201507021206.47499.sweet_f_a@gmx.de> <1435831817-13227-1-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1435831817-13227-1-git-send-email-sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <201507021221.02981.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

I have a question and a comment about my own patch :)

On Thursday 02 July 2015, Ruediger Meier wrote:

> @@ -367,7 +365,7 @@ static void handle_signal(struct script_control
> *ctl, int fd)
>
>  	bytes = read(fd, &info, sizeof(info));
>  	if (bytes != sizeof(info)) {
> -		if (errno == EAGAIN)
> +		if (bytes < 0 && errno == EAGAIN)
>  			return;

Should we also return on EINTR here like we do in handle_io()?

>  		fail(ctl);
>  	}


And I see some more potential problems. For example see this snippet 
from handle_io();

	bytes = read(fd, buf, sizeof(buf));
	if (bytes < 0) {
		DBG(IO, ul_debug(" read failed"));
		if (errno == EAGAIN || errno == EINTR)
			return;
		fail(ctl);
	}

We are using errno after DBG(). But in theory printf() or whatever we do 
in DBG() could change errno. Wouldn't it be a good idea to write 
generally all DBG macros errno-invariant?

cu,
Rudi
