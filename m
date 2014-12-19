Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:58587 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751370AbaLSNaT (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 19 Dec 2014 08:30:19 -0500
Date: Fri, 19 Dec 2014 14:30:09 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 00/16] pull: updates to lslogins and chfn
Message-ID: <20141219133009.GM19904@x2.net.home>
References: <1418579052-29386-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1418579052-29386-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Dec 14, 2014 at 05:43:56PM +0000, Sami Kerola wrote:
> Sami Kerola (16):
>   lslogins: allow changing password changed and expiration time formats
>   lslogins: make journald last logs time stamps to honor --time-format
>   lslogins: tell why command failed
>   lslogins: fix short options
>   lslogins: reject unknown time format arguments
>   lslogins: add space to systemd journal header and message
>   lslogins: use hardcoded paths from pathnames.h
>   chfn: remove function prototypes
>   chfn: rewrite prompt() to use strutils
>   chfn: use xasprintf() rather than bunch of strlen() and malloc() calls
>   chfn: fix usage() regression
>   chfn: simplify parse_passwd() by using strsep()
>   chfn: add minimalistic struct chfn_control
>   chfn: clean up parse_argv()
>   chfn: move new and old finger structs to chfn control struct
>   chfn: make command to obey login.defs CHFN_RESTRICT instructions

 Applied from github, thanks. I th ink we can cleanup chfn later.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
