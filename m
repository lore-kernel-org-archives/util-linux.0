Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ea0-f172.google.com ([209.85.215.172]:39820 "EHLO
	mail-ea0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934811Ab3FSRQq (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 19 Jun 2013 13:16:46 -0400
Received: by mail-ea0-f172.google.com with SMTP id q10so3408038eaj.3
        for <util-linux@vger.kernel.org>; Wed, 19 Jun 2013 10:16:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAG27Bk0tULzTdYpPPZz3C9Z2XZk9mTHbV=UCkMJEW+6XbRFZvw@mail.gmail.com>
References: <CADJQGJfOj2GQNdoW89hC2LMukC_cwPuJVBiN6+xy64UphbOiZg@mail.gmail.com>
	<CAG27Bk0tULzTdYpPPZz3C9Z2XZk9mTHbV=UCkMJEW+6XbRFZvw@mail.gmail.com>
Date: Wed, 19 Jun 2013 19:16:44 +0200
Message-ID: <CADJQGJfBf3-oO1c7zi8AW8a=uO0PN5u+nw9jT-PePKK-uespSQ@mail.gmail.com>
Subject: Re: forking in setsid
From: Damien Wyart <damien.wyart@gmail.com>
To: kerolasa@gmail.com
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Thanks for your answer. Let's wait for other comments on it...

Btw, would it make sense to have a "full" daemonization command in
util-linux (like this one http://software.clapper.org/daemonize/) ?
There is one in FreeBSD (daemon), and a daemon function also exists in
glibc.

Thanks,

Damien
