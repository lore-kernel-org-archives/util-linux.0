Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:20052 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751709AbaGXJpM (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 24 Jul 2014 05:45:12 -0400
Date: Thu, 24 Jul 2014 11:44:54 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org, Kodiak Firesmith <ksf@sei.cmu.edu>
Subject: Re: [PATCH 06/10] logger: add function pointer to choose how logging
 is done
Message-ID: <20140724094454.GJ26781@x2.net.home>
References: <1406066459-4816-1-git-send-email-kerolasa@iki.fi>
 <1406066459-4816-7-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1406066459-4816-7-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jul 22, 2014 at 11:00:55PM +0100, Sami Kerola wrote:
> +	void (*syslogfp)(struct logger_ctl *ctl, char *msg);

 What about to move it to the control struct too?

> +	if (server) {
> +		ctl.fd = inet_socket(server, port, socket_type);
> +		syslogfp = syslog_rfc3164;
> +	} else if (usock) {
> +		ctl.fd = unix_socket(usock, socket_type);
> +		syslogfp = syslog_rfc3164;
> +	} else {
> +		openlog(ctl.tag ? ctl.tag : xgetlogin(), ctl.logflags, 0);
> +		syslogfp = syslog_local;
> +	}

Maybe it would be better to create small functions

  logger_open()
  logger_log()
  logger_close()

to keep main() simple and readable and without all the details like
"if (usock) ...".

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
