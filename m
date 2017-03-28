Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.18]:65167 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755402AbdC1Tdc (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 28 Mar 2017 15:33:32 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: col issue
Date: Tue, 28 Mar 2017 21:32:08 +0200
Cc: util-linux@vger.kernel.org, Sami Kerola <kerolasa@iki.fi>
References: <20170328121630.prr5s6aikqvt2awt@ws.net.home>
In-Reply-To: <20170328121630.prr5s6aikqvt2awt@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201703282132.08215.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tuesday 28 March 2017, Karel Zak wrote:
>  Hi,
>
>  see https://bugzilla.redhat.com/show_bug.cgi?id=1436432
>
>  any idea what is the right col(1) behavior for escape sequences?

I have no opinion and no clue about col but still one comment :)

While you are looking at this issue, maybe it's related to some test 
failures on OSX and FreeBSD. In .travis-functions we have disabled 
certain test for OSX:

    export TS_OPT_col_multibyte_known_fail=yes
    export TS_OPT_colcrt_regressions_known_fail=yes
    export TS_OPT_column_invalid_multibyte_known_fail=yes

cu,
Rudi
