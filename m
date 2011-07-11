Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:22504 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752504Ab1GKJyT (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 11 Jul 2011 05:54:19 -0400
Date: Mon, 11 Jul 2011 11:54:12 +0200
From: Karel Zak <kzak@redhat.com>
To: Marc-Antoine Perennou <Marc-Antoine@Perennou.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] Don't try to chgrp write or wall if they are not built
Message-ID: <20110711095412.GF5214@nb.net.home>
References: <BANLkTikpHa-0aVp7G7cpRw_ePOQQiuXSEYnrV-AgssjhFEf2zg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BANLkTikpHa-0aVp7G7cpRw_ePOQQiuXSEYnrV-AgssjhFEf2zg@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jun 30, 2011 at 02:26:32AM +0200, Marc-Antoine Perennou wrote:
>  term-utils/Makefile.am |   10 ++++++++--
>  1 files changed, 8 insertions(+), 2 deletions(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
