Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:50022 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751476AbcLGLpe (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 7 Dec 2016 06:45:34 -0500
Date: Wed, 7 Dec 2016 12:44:49 +0100
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 00/11] switch to utmpx.h
Message-ID: <20161207114449.5x5au3gqgj74bmo5@ws.net.home>
References: <1480582332-17407-1-git-send-email-sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1480582332-17407-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Dec 01, 2016 at 09:52:03AM +0100, Ruediger Meier wrote:
>   last: include libgen.h for basename(3p)
>   login-utils: remove _HAVE_UT_TV fallback
>   lslogins: remove useless strlen()
>   utmpdump: code formatting for readability
>   login-utils: avoid using the defined utmp sizes.
>   login: re-add lastlog.h header
>   agetty: remove obsolete HAVE_UPDWTMP fallback
>   login-utils: switch to utmpx.h
>   build-sys: check for POSIX utmpx usage
>   travis: let OSX auto-skip utmpx tools
>   agetty: re-add utmp.h for Debian GNU/kFreeBSD

    Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
