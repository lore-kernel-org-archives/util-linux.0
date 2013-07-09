Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:30403 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752865Ab3GIJhA (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 9 Jul 2013 05:37:00 -0400
Date: Tue, 9 Jul 2013 11:36:57 +0200
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: Damien Wyart <damien.wyart@gmail.com>,
        util-linux <util-linux@vger.kernel.org>
Subject: Re: forking in setsid
Message-ID: <20130709093657.GC24716@x2.net.home>
References: <CADJQGJfOj2GQNdoW89hC2LMukC_cwPuJVBiN6+xy64UphbOiZg@mail.gmail.com>
 <CAG27Bk0tULzTdYpPPZz3C9Z2XZk9mTHbV=UCkMJEW+6XbRFZvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk0tULzTdYpPPZz3C9Z2XZk9mTHbV=UCkMJEW+6XbRFZvw@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jun 19, 2013 at 05:00:09PM +0100, Sami Kerola wrote:
> From c2deb80ef6feb7039a0554e4b8a8272e59cb1a87 Mon Sep 17 00:00:00 2001
> From: Daniel Kahn Gillmor <dkg@fifthhorseman.net>
> Date: Wed, 20 Aug 2008 12:00:00 +0100
> Subject: [PATCH] setsid: add an option to wait child return value
> Organization: Lastminute.com

it would be nice to have usable patch, ideally sent by git-send-email.

    Karel

> - fputs(_(" -c, --ctty     set the controlling terminal to the current one\n"),
> - out);
> + fputs(_(" -c, --ctty     set the controlling terminal to the current
> one\n"), out);
> + fputs(_(" -w, --wait     wait program to exit, and use the same
> return\n"), out);

 invalid patch formatting

> + if (wait(&status) != pid)
> + err(EXIT_FAILURE, "wait");
> + if (WIFEXITED(status))
> + return WEXITSTATUS(status);
> + err(status, _("child %d did not exit normally"), pid);

 useless formatting...

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
