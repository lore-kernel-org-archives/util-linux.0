Return-Path: util-linux-owner@vger.kernel.org
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46400 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752381AbeGDNUm (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 4 Jul 2018 09:20:42 -0400
Date: Wed, 4 Jul 2018 15:20:38 +0200
From: Karel Zak <kzak@redhat.com>
To: kmahlkuc@linux.vnet.ibm.com
Cc: util-linux@vger.kernel.org, KyleMahlkuch <Kyle.Mahlkuch@ibm.com>
Subject: Re: [PATCH v2] libfdisk: Fix multipath partition seperators for
 user-friendly names
Message-ID: <20180704132038.sxpxirjbgxq26joh@ws.net.home>
References: <20180622095252.ik5n2oki4ekcsnbg@ws.net.home>
 <1529956321-18722-1-git-send-email-kmahlkuc@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1529956321-18722-1-git-send-email-kmahlkuc@linux.vnet.ibm.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jun 25, 2018 at 02:52:01PM -0500, kmahlkuc@linux.vnet.ibm.com wrote:
>  libfdisk/src/utils.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)

Applied, thanks!


I have a little clean upped the code by next patch to reduce number
of asprintf() calls and to check for asprintf() return value. 

Please, re-test if it still works for your use case :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
