Return-Path: util-linux-owner@vger.kernel.org
Received: from mx.datacom.ind.br ([177.66.5.10]:37939 "EHLO
        mail.datacom.ind.br" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752460AbdHAWNH (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 1 Aug 2017 18:13:07 -0400
Date: Tue, 1 Aug 2017 19:10:32 -0300 (BRT)
From: Carlos Santos <casantos@datacom.ind.br>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Message-ID: <1706511560.2888472.1501625432873.JavaMail.zimbra@datacom.ind.br>
In-Reply-To: <20170801124405.ikj44ulhisvfthnf@ws.net.home>
References: <1971282138.2691482.1501546323018.JavaMail.zimbra@datacom.ind.br> <1705151756.2691717.1501548399616.JavaMail.zimbra@datacom.ind.br> <20170801072017.yl7mgv64pq7ccj5e@ws.net.home> <1033867833.2726878.1501589362348.JavaMail.zimbra@datacom.ind.br> <20170801124405.ikj44ulhisvfthnf@ws.net.home>
Subject: Re: Problem building util-linux without a separate ncursesw include
 dir
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

> From: "Karel Zak" <kzak@redhat.com>
> To: "Carlos Santos" <casantos@datacom.ind.br>
> Cc: util-linux@vger.kernel.org
> Sent: Tuesday, August 1, 2017 9:44:05 AM
> Subject: Re: Problem building util-linux without a separate ncursesw include dir

[...]
> 
> We don't have to distinguish between wide and non-wide ncurses when we
> check for header files, because it's already done by
> UL_NCURSES_CHECK() and AC_CHECK_HEADERS() is executed only if we
> already have widechar lib.
> 
> Fixed... git-pull and try it.
> 
>    Karel

Works like a charm. Thanks!

-- 
Carlos Santos (Casantos) - DATACOM, P&D
“The greatest triumph that modern PR can offer is the transcendent 
success of having your words and actions judged by your reputation, 
rather than the other way about.” — Christopher Hitchens
