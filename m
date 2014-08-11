Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:33781 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751523AbaHKND4 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 11 Aug 2014 09:03:56 -0400
Date: Mon, 11 Aug 2014 15:03:44 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 0/5] logger: remove use of libc openlog and other small
 changes
Message-ID: <20140811130344.GJ17719@x2.net.home>
References: <1407671771-29745-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1407671771-29745-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Aug 10, 2014 at 12:56:06PM +0100, Sami Kerola wrote:
> In commit eea331abd7159432d8f45f978b2fbac19330ce48 I added an option to
> use ppid instead of pid in logger message.  That change worked only when

 Maybe it would be better to use --id[=<id>] rather than support PID and 
 PPID only. It means allow to specify arbitrary id, because in some
 more complex situations PPID does not have to be enough.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
