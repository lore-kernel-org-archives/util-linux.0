Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:37740 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751212AbcLGMeH (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 7 Dec 2016 07:34:07 -0500
Date: Wed, 7 Dec 2016 13:34:05 +0100
From: Karel Zak <kzak@redhat.com>
To: Andreas Henriksson <andreas@fatal.se>,
        =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] sulogin: make getpasswd(...) return NULL on ^D
Message-ID: <20161207123405.aep462wswdbeizp7@ws.net.home>
References: <1480350290-7875-1-git-send-email-andreas@fatal.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1480350290-7875-1-git-send-email-andreas@fatal.se>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Nov 28, 2016 at 05:24:49PM +0100, Andreas Henriksson wrote:
> Reported-by: Bjørn Mork <bjorn@mork.no>
> Addresses: http://bugs.debian.org/846112
> Signed-off-by: Andreas Henriksson <andreas@fatal.se>

Applied (both patches), thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
