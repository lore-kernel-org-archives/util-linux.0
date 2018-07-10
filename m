Return-Path: util-linux-owner@vger.kernel.org
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44268 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932710AbeGJMFV (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 10 Jul 2018 08:05:21 -0400
Date: Tue, 10 Jul 2018 14:05:18 +0200
From: Karel Zak <kzak@redhat.com>
To: Alban Crequy <alban.crequy@gmail.com>
Cc: util-linux@vger.kernel.org, Alban Crequy <alban@kinvolk.io>,
        dongsu@kinvolk.io
Subject: Re: [PATCH] mountinfo: parse empty strings in source
Message-ID: <20180710120518.j73zkxfnwafam5xt@ws.net.home>
References: <20180622115425.26183-1-alban@kinvolk.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180622115425.26183-1-alban@kinvolk.io>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Jun 22, 2018 at 01:54:25PM +0200, Alban Crequy wrote:
>  libmount/src/tab_parse.c | 33 ++++++++++++++++++++++++++++-----
>  1 file changed, 28 insertions(+), 5 deletions(-)

Applied, thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
