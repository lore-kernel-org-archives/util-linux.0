Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:14131 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932440AbaGOHrU (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 15 Jul 2014 03:47:20 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s6F7lJES019663
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Tue, 15 Jul 2014 03:47:19 -0400
Date: Tue, 15 Jul 2014 09:47:17 +0200
From: Karel Zak <kzak@redhat.com>
To: Stef Walter <stefw@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] agetty: Reprompt and reprint /etc/issue if we receive
 SIGUSR1
Message-ID: <20140715074717.GN30288@x2.net.home>
References: <1404718284-4192-1-git-send-email-stefw@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1404718284-4192-1-git-send-email-stefw@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jul 07, 2014 at 09:31:24AM +0200, Stef Walter wrote:
>  /* Get user name, establish parity, speed, erase, kill & eol. */
>  static char *get_logname(struct options *op, struct termios *tp, struct chardata *cp)
>  {
> @@ -1625,9 +1676,18 @@ static char *get_logname(struct options *op, struct termios *tp, struct chardata
>  
>  	while (*logname == '\0') {
>  
> +		reprompt_flag = 0;
> +
>  		/* Write issue file and prompt */
>  		do_prompt(op, tp);
>  
> +		/* If asked to reprompt *before* terminal input arrives, then do so */
> +		if (!wait_for_term_input(STDIN_FILENO) && reprompt_flag != 0) {
> +			if (op->flags & F_VCONSOLE)
> +				termio_clear(STDOUT_FILENO);
> +			continue;
> +		}

 Now when I think about it.. would be better to have this feature
 optional? I think it's overkill to have it enabled on all machines. 
 
 The another story is the signal usage (and possible race with login(1) as 
 discussed at https://bugzilla.redhat.com/show_bug.cgi?id=1110763). 
 
 What about  for example: 

   agetty --reload-trigger <file>

 and use inotify for the <file>. I guess this way also allows to avoid
 the ioctl() tty voodoo and you can use select() for the inotify and
 tty file descriptors.


  Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
