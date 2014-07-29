Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:16158 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750867AbaG2LyF (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 29 Jul 2014 07:54:05 -0400
Date: Tue, 29 Jul 2014 13:53:58 +0200
From: Karel Zak <kzak@redhat.com>
To: Jaromir Capik <jcapik@redhat.com>
Cc: kerolasa@gmail.com, util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] fdformat: Add new switches -f/--from, -t/--to,
 -r/--repair
Message-ID: <20140729115358.GW8533@x2.net.home>
References: <844628876.22654954.1406302034993.JavaMail.zimbra@redhat.com>
 <2139170067.22662578.1406302189694.JavaMail.zimbra@redhat.com>
 <CAG27Bk1hbE+WE7+CeMPv03YYR-78jGm8cG-kQNufgLfAU6f3qQ@mail.gmail.com>
 <969740755.24655086.1406558319251.JavaMail.zimbra@redhat.com>
 <20140728151034.GM8533@x2.net.home>
 <1340617573.25924027.1406633523481.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1340617573.25924027.1406633523481.JavaMail.zimbra@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jul 29, 2014 at 07:32:03AM -0400, Jaromir Capik wrote:
>  disk-utils/Makemodule.am |   1 +
>  disk-utils/fdformat.8    |  11 ++-
>  disk-utils/fdformat.c    | 210 ++++++++++++++++++++++++++++++++---------------
>  3 files changed, 157 insertions(+), 65 deletions(-)

 Applied, thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
